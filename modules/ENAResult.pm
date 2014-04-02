=head1 LICENSE

Copyright [2009-2014] EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut

package ENAResult;

use strict;
use Data::Dumper;
use EnsEMBL::Web::DBSQL::DBConnection;
use Data::Page;

use Bio::EnsEMBL::Registry;

sub new {
    my($class, $params) = @_;

    my $dbc = EnsEMBL::Web::DBSQL::DBConnection->new( undef, $params->{_species_defs} );
    my $dba;
    eval {
	$dba =   $dbc->_get_blast_database;
    };

    if ($@) {
	warn "ERROR: $@";
    }

    my $self = bless {
	_dba => $dba,
	_dbc => $dbc, 
	_alignments => [],
	}, $class;

    foreach my $p (keys %$params) {
	$self->{$p} = $params->{$p};
    }
    
    $self->_fetch_state();

    return $self;
}

sub status {
    my $self = shift;
    return $self->{_status} || 'Not found';
}

sub progress {
    my $self = shift;
    return $self->{_progress} || -1;
}

sub counter {
    my $self = shift;
    return $self->{_counter} || -1;
}

sub fetch_alignments {
    my ($self, $column, $page, $size) = @_;
    my $jobId = $self->{_jobid};

    my $order = '';
    if ($column =~ /qlen|tlen|identity/) {
	$order = 'DESC';
    }
    
    $page ||= 1;
    $self->current_page = $page;
    if ($column) {
	$self->order = $column;
    }

    $size ||= 10;
    $self->page_size ||= $size;
    my $from = ($page -1) * $size;
    my $to = $from + $size;
    if ($to > $self->counter) {
	$to = $self->counter;
    }
    $self->{_message} = sprintf "Showing %d-%d of %d alignments found", $from+1, $to, $self->counter;
    $self->{_alignments} =  $self->{_dba}->fetch_alignments($jobId, $column, $order, $from, $size);
}

sub _fetch_state {
    my $self = shift;
    my $jobId = $self->{_jobid};
    if (my $state =  $self->{_dba}->fetch_state($jobId)) {
#	warn Dumper $state;
	$self->{_status} = $state->[0]->[4];
	$self->{_progress} = $state->[0]->[3];
	$self->{_counter} = $state->[0]->[5];
    }
}


sub render {
    my ($self) = @_;

    my $jobId = $self->{_jobid};

    my $wheat = 0;
    my $header = '';
    my $html = '';
    my $msg = '';

    my $num = $self->{_counter};

    if ($num) {
	$msg = $self->{_message};
	$header = qq{<tr><th colspan="10"><h1 class="enaheader"> $msg </h1></td></tr>
<tr><td class="ehleft" style="font-style:normal"><a class="ena-sort" id="sort-species">Species</a></td>
<td class="ehleft"><a class="ena-sort" id="sort-location">Location<a/></td>
<td class="eh"><a class="ena-sort" id="sort-qlen">Query Length</a></td>
<td class="eh"><a class="ena-sort" id="sort-tlen">Target Length</a></td>
<td class="eh"><a class="ena-sort" id="sort-identity">Identity</a></td>
<td class="eh"><a class="ena-sort" id="sort-evalue">E-Value</a></td>
<td class="eh" style="text-align:left;">Genes</td>
</tr>};

	my $esite = $self->{_species_defs}->SPECIES_DISPLAY_NAME;
	my $sd = $self->{_species_defs};
	my $registry = 'Bio::EnsEMBL::Registry';
	my $registry_loaded = 0;

        my $i = 0;
        foreach my $a (@{$self->{_alignments} || []}) {
#          warn Dumper $a;

          my ($qlen, $tlen, $id, $jobid, $site, $species, $qset, $location, $qstart, $qend, $identity, $pvalue, $rawresult, $region, $tstart, $tend, $fcount, $ftext) = @$a;
          my $evalue = sprintf "%.0E", $pvalue;

	  my $href = $qset eq 'ena' ? "http://www.ebi.ac.uk/ena/data/view/$region" : ($site eq $self->{_species_defs}->GENOMIC_UNIT ? '' : "http://${site}.ensembl.org") . '/' . $qset . '/Location/View?r='.$location;

          my $ftext = '';
	  
	  my $barleyHref = ''; 
	  my $barleyRegion = '';

#my $unit = $esite->{$qset};
#warn "QSET : $qset : $species : $site : $unit \n";

	  if ($qset ne 'ena') {
	    my ($dba, $sa);
            my $site_url = '';
	    eval {
              if ($site eq $self->{_species_defs}->GENOMIC_UNIT) {
	        $dba = $self->{_dbc}->get_DBAdaptor('core', $qset);
	        $sa = $dba->get_SliceAdaptor;
              } else {
		  # for EG wide search we need to load the registry to get adaptors for species which are not configured in the current site
		  unless ($registry_loaded) {
		      $registry->load_registry_from_db(
			  -host => $sd->DATABASE_HOST,
			  -port => $sd->DATABASE_HOST_PORT,
			  -user =>  $sd->DATABASE_DBUSER,
			  -pass => $sd->DATABASE_DBPASS
			  );
		      $registry_loaded = 1;
		  }

                $sa = $registry->get_adaptor( $species, 'Core', 'Slice' );
                $site_url =  "http://${site}.ensembl.org";
                $species = $esite->{$qset};
              }
            };
            if ($sa) {
($tstart, $tend ) = ($tend, $tstart) if ($tstart > $tend);
	       if (my $slice = $sa->fetch_by_region( undef, $region, $tstart, $tend)) {
		 foreach my $gene (@{ $slice->get_all_Genes()}) {
		   $ftext .= sprintf(qq{ <a href="%s/%s/Gene/Summary?g=%s">%s</a> },  $site_url, $qset, $gene->stable_id, $gene->display_xref ? $gene->display_xref->display_id : $gene->display_id);
		 }
	       }
	    }
	  } else {

	    my ($dba, $sa);
	      if ($species =~ /Triticum aestivum/) { # Special case for Wheat - which is not in ensembl yet
                my $sp = 'Triticum_aestivum';
                $wheat = 1;
	        $dba = $self->{_dbc}->get_DBAdaptor('core', $sp);
	        $sa = $dba->get_SliceAdaptor;
                ($tstart, $tend ) = ($tend, $tstart) if ($tstart > $tend);
                 my $ta_slice =    $sa->fetch_by_region('wheat_ENA', $region, $tstart, $tend, 1, 'ENA1');
                 next unless $ta_slice;

# put the link to ENA into the last column
                 $ftext = qq{<a href="$href">$region</a>};
                 $region = '';
                 $href = '';
#warn $ta_slice->name();
# the segments must be of the same length otherwise they will not map, will generate an error and kill the process
                 eval {
		     my ($bsegment) = @{ $ta_slice->project('chromosome','brachy_v1.0') || []};
		     if ($bsegment) {
#			 warn " ### ", $bsegment->to_Slice->name();
			 $species = 'Brachypodium distachyon';
			 my $bslice = $bsegment->to_Slice;

			 $region =  sprintf qq{%s : %d-%d}, $bslice->seq_region_name, $bslice->start, $bslice->end;

## Special request by Dan B
## show alignments in region of 2K
			 
			 my $blength = abs($bslice->end - $bslice->start + 1);
			 my $rmax = 2000;
			 my $bstart = $bslice->start;
			 my $bend = $bslice->end;
			 
			 if ($blength < $rmax ) {
			     my $rhalf = $rmax / 2;
			     $bstart = $bslice->start + $blength - $rhalf;
			     $bstart = 1 if ($bstart < 1);
			     $bend = $bslice->end - $blength + $rhalf;
			 }

			 $href = sprintf '/Brachypodium_distachyon/Location/View?r=%s:%d-%d', $bslice->seq_region_name, $bstart, $bend;

# switch on the bam tracks if they are not
			 $href .= ';contigviewbottom=Lastz_Wheat_A_subsequences_alignments=normal,Lastz_Wheat_B_subsequences_alignments=normal,Lastz_Wheat_D_subsequences_alignments=normal,Lastz_Wheat_X_subsequences_alignments=normal,simple_core_wheat_snp_a=normal,simple_core_wheat_snp_b=normal,dna_align_otherfeatures_wheat_est_exonerate=normal,Gmap_Wheat_ERR125556=normal,Gmap_Wheat_ERR125557=normal,Gmap_Wheat_ERR125558=normal,Gmap_Wheat_ERR125559=normal,Gmap_Wheat_ERR125560=normal,Gmap_Wheat_ERR125561=normal,Gmap_Wheat_ERR125562=normal,Gmap_Wheat_ERR125563=normal,Gmap_Wheat_ERR125564=normal,Gmap_Wheat_ERR125565=normal';
		     }
                };

                if ($@) {
		    warn $@;
		    next;
                }
# now try to find mappings to barley
                eval {
		     my ($bsegment) = @{ $ta_slice->project('chromosome','barley_v1.0') || []};
		     if ($bsegment) {
#			 warn " ### ", $bsegment->to_Slice->name();
			 $species = 'Hordeum vulgare';
			 my $bslice = $bsegment->to_Slice;

			 $barleyRegion =  sprintf qq{%s : %d-%d}, $bslice->seq_region_name, $bslice->start, $bslice->end;

## Special request by Dan B
## show alignments in region of 2K
			 
			 my $blength = abs($bslice->end - $bslice->start + 1);
			 my $rmax = 2000;
			 my $bstart = $bslice->start;
			 my $bend = $bslice->end;
			 
			 if ($blength < $rmax ) {
			     my $rhalf = $rmax / 2;
			     $bstart = $bslice->start + $blength - $rhalf;
			     $bstart = 1 if ($bstart < 1);
			     $bend = $bslice->end - $blength + $rhalf;
			 }

			 $barleyHref = sprintf '/Hordeum_vulgare/Location/View?r=%s:%d-%d', $bslice->seq_region_name, $bstart, $bend;

# switch on the bam tracks if they are not
			 $barleyHref .= ';contigviewbottom=Lastz_Wheat_A_subsequences_alignments=normal,Lastz_Wheat_B_subsequences_alignments=normal,Lastz_Wheat_D_subsequences_alignments=normal,Lastz_Wheat_X_subsequences_alignments=normal,simple_core_wheat_snp_a=normal,simple_core_wheat_snp_b=normal,dna_align_otherfeatures_wheat_est_exonerate=normal,Gmap_Wheat_ERR125556=normal,Gmap_Wheat_ERR125557=normal,Gmap_Wheat_ERR125558=normal,Gmap_Wheat_ERR125559=normal,Gmap_Wheat_ERR125560=normal,Gmap_Wheat_ERR125561=normal,Gmap_Wheat_ERR125562=normal,Gmap_Wheat_ERR125563=normal,Gmap_Wheat_ERR125564=normal,Gmap_Wheat_ERR125565=normal';
		     }

                };

                if ($@) {
		    warn $@;
		    next;
                }

$species = $ftext;
$ftext = '';
            }
	  }
          

$html .= qq{<tr class="} . ($i % 2 == 0 ? 'odd' : 'even') . qq{"><td>$species</td>};

if ($wheat) {
    $html .= qq{<td>&nbsp;</td>};
} else {
    $html .= qq{<td><a href="$href">$region</a></td>};
}

$html .= qq{
<td>$qlen</td><td>$tlen</td>
<td><a class="ena-alignment" id="link_$id">$identity \%</a></td>
<td style="white-space:nowrap">$evalue</td>
<td style="text-align:center">$ftext</td>
};

if ($wheat) {
    $html .= qq{<td><a href="$href" alt="View location in Ensembl Plants" title="View location in Ensembl Plants">$region</a></td>
<td><a href="$barleyHref" alt="View location in Ensembl Plants" title="View location in Ensembl Plants">$barleyRegion</a></td>}
}
$html .= qq{
</tr>
<tr><td id="hit_$id" class="rawresult" colspan="7">$rawresult</td></tr>
}; 
 	  $i++;
        }
        
        $html .= "<tr><th colspan=10>".$self->render_pagination($jobId)."</th></tr>";

    } else {
      $html .= qq{<tr><th> <h1 class="enaheader"> No alignments found &nbsp; </h1> &nbsp; </th></tr>};
   }

if ($wheat) {
	$header = qq{<tr><th colspan="10"><h1 class="enaheader"> $msg </h1></td></tr>
<tr>
<td class="ehleft" style="font-style:normal"><a class="ena-sort" id="sort-location">Wheat Sequence</a><br/>(View in ENA)</td>
<td class="eh" style="width:1px">&nbsp;</td>
<td class="eh"><a class="ena-sort" id="sort-qlen">Query Length</a></td>
<td class="eh"><a class="ena-sort" id="sort-tlen">Target Length</a></td>
<td class="eh"><a class="ena-sort" id="sort-identity">Identity</a></td>
<td class="eh"><a class="ena-sort" id="sort-evalue">E-Value</a></td>
<td class="eh" style="text-align:left;"></td>
<td class="eh" style="text-align:center">Mapped Location<br/>(in Brachypodium)</td><td class="eh" style="text-align:center">Mapped Location<br/>(in Barley)</td>

</tr>};
}

return qq{
<input type="hidden" name="jobid" id="jobid" value="$jobId" />
<input type="hidden" name="jobstatus" value="ready" />
<table id="enaresults" class="center" align="center" cellpadding="0" cellspacing="0">
$header
$html
</table>
};
}

sub current_page:lvalue   { $_[0]->{_page} };
sub page_size:lvalue   { $_[0]->{_page_size} };
sub order:lvalue   { $_[0]->{_order} };

sub pager {
    my ($self, $page_size) = @_;

    my $pager = Data::Page->new();
    $pager->total_entries($self->counter > 1000 ? 1000 : $self->counter);
    $pager->entries_per_page($page_size || $self->page_size);
    $pager->current_page($self->current_page);

    return $pager;
}
sub render_pagination {
  my ($self,$jobid) = @_;

  return if $self->counter <= $self->page_size;

  my $pager = $self->pager;
  my $current_page = $pager->current_page;
  my $last_page = $pager->last_page;
  my $previous_page = $pager->previous_page;
  my $next_page = $pager->next_page;
  
  my $out = '<h4><div class="paginate">';
  if ( $pager->previous_page) {
    $out .= sprintf( '<a class="prev ena-pager" id="page-%d">< Prev</a> ', $pager->previous_page);
  }
  foreach my $i (1..$last_page) {
    if( $i == $current_page ) {
      $out .= sprintf( '<span class="current">%s</span> ', $i );
    } elsif( $i < 5 || ($last_page-$i)<4 || abs($i-$current_page+1)<4 ) {
      $out .= sprintf( '<a class="ena-pager" id="page-%d">%s</a> ', $i, $i );
    } else {
      $out .= '..';
    }
  }
  $out =~ s/\.\.+/ ... /g;
  if ($pager->next_page) {
    $out .= sprintf( '<a class="next ena-pager" id="page-%d">Next ></a> ', $pager->next_page );
  }
  
  return "$out</div></h4>";
}


1;
