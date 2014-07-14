=head1 LICENSE

Copyright [1999-2014] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

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

package Bio::EnsEMBL::GlyphSet::_alignment;

use strict;

use List::Util qw(min max);

sub render_normal {
  my $self = shift;
  return $self->render_text if $self->{'text_export'};
  
  my $h               = @_ ? shift : ($self->my_config('height') || 8);
     $h               = $self->{'extras'}{'height'} if $self->{'extras'} && $self->{'extras'}{'height'};
  my $strand_bump     = $self->my_config('strandbump');
  my $depth           = @_ ? shift : ($self->my_config('dep') || 6);
     $depth           = 0 if $strand_bump || $self->my_config('nobump');
  my $gap             = $h < 2 ? 1 : 2;   
  my $strand          = $self->strand;
  my $strand_flag     = $self->my_config('strand');
  my $length          = $self->{'container'}->length;
  my $pix_per_bp      = $self->scalex;
  my $draw_cigar      = $self->my_config('force_cigar') eq 'yes' || $pix_per_bp > 0.2;
  my %highlights      = map { $_, 1 } $self->highlights;
  my $db              = 'DATABASE_CORE';
  my $extdbs          = $self->species_defs->databases->{$db}{'tables'}{'external_db'}{'entries'};      # Get details of external_db - currently only retrieved from core since they should be all the same
  my %features        = $self->features;                                                                # Get array of features and push them into the id hash
  my @sorted          = $self->sort_features_by_priority(%features);                                    # Sort (user tracks) by priority
     @sorted          = $strand < 0 ? sort keys %features : reverse sort keys %features unless @sorted;
  my $join            = $self->{'my_config'}{'data'}{'join'} ne 'off' && !$self->{'renderer_no_join'};
  my @greyscale       = qw(ffffff d8d8d8 cccccc a8a8a8 999999 787878 666666 484848 333333 181818 000000);
  my $ngreyscale      = scalar @greyscale;
  my $regexp          = $pix_per_bp > 0.1 ? '\dI' : $pix_per_bp > 0.01 ? '\d\dI' : '\d\d\dI';
  my $y_offset        = 0;
  my $features_drawn  = 0;
  my $features_bumped = 0;
  my $label_h         = 0;
  my ($fontname, $fontsize);
  
  if ($self->{'show_labels'}) {
    ($fontname, $fontsize) = $self->get_font_details('outertext');
    $label_h = [ $self->get_text_width(0, 'X', '', ptsize => $fontsize, font => $fontname) ]->[3];
    $join    = 1; # The no-join thing gets completely mad with labels on.
  }
  
  foreach my $feature_key (@sorted) {
    ## Fix for userdata with per-track config
    my ($config, @features);
    
    $self->{'track_key'} = $feature_key;
    
    next unless $features{$feature_key};
    
    my @tmp = @{$features{$feature_key}};
    my %id;

    if (ref $tmp[0] eq 'ARRAY') {
      @features = @{$tmp[0]};
      $config   = $tmp[1];
      $depth  //= $tmp[1]{'dep'};
    } else {
      @features = @tmp;
    }

    $self->_init_bump(undef, $depth);
    
    my $nojoin_id = 1;

## EG
    my $fgroup_count = 0;
##
    
    foreach (sort { $a->[0] <=> $b->[0] }  map [ $_->start, $_->end, $_ ], @features) {
      my ($s, $e, $f) = @$_;
      
      next if $strand_flag eq 'b' && $strand != (($f->can('hstrand') ? $f->hstrand : 1) * $f->strand || -1) || $e < 1 || $s > $length;
      
## EG - hack the feature grouping - see ENSEMBL-1149        
      my $fgroup_name = $join ? ($f->can('hseqname') ?  $f->hseqname : $self->feature_group($f)) : $nojoin_id++;
      while( exists $id{"$fgroup_name.$fgroup_count"} ) {
        $fgroup_count++;
      }      
      $fgroup_name .= ".$fgroup_count" if (exists $id{$fgroup_name});
##
      
      my $db_name     = $f->can('external_db_id') ? $extdbs->{$f->external_db_id}{'db_name'} : 'OLIGO';
      
      push @{$id{$fgroup_name}}, [ $s, $e, $f, int($s * $pix_per_bp), int($e * $pix_per_bp), $db_name ];
    }

    
    next unless keys %id;
    
    my $colour_key     = $self->colour_key($feature_key);
    my $feature_colour = $self->my_colour($colour_key);
    my $join_colour    = $self->my_colour($colour_key, 'join');
    my $label_colour   = $feature_colour;
    my $max_score      = $config->{'max_score'} || 1000;
    my $min_score      = $config->{'min_score'} || 0;
    my ($cg_grades, $score_per_grade, @colour_gradient, $y_pos);
    
    if ($config && $config->{'useScore'} == 2) {
      $cg_grades       =  $config->{'cg_grades'} || 20;
      $score_per_grade = ($max_score - $min_score) / $cg_grades;
      
      my @cg_colours = map { /^cgColour/ && $config->{$_} ? $config->{$_} : () } sort keys %$config;
      my $ccount     = scalar @cg_colours;
      
      if ($ccount) {
        unshift @cg_colours, 'white' if $ccount == 1;
      } else {
        @cg_colours = qw(yellow green blue);
      }
      
      @colour_gradient = $self->{'config'}->colourmap->build_linear_gradient($cg_grades, \@cg_colours);
    }
    
    my $greyscale_max = $config && exists $config->{'greyscale_max'} && $config->{'greyscale_max'} > 0 ? $config->{'greyscale_max'} : 1000;
    
    foreach my $i (sort { $id{$a}[0][3] <=> $id{$b}[0][3] || $id{$b}[-1][4] <=> $id{$a}[-1][4] } keys %id) {
      my @feat       = @{$id{$i}};
      my $db_name    = $feat[0][5];
      my $bump_start = int($pix_per_bp * ($feat[0][0]  < 1       ? 1       : $feat[0][0])) - 1;
      my $bump_end   = int($pix_per_bp * ($feat[-1][1] > $length ? $length : $feat[-1][1]));
         $bump_end   = max($bump_end, $bump_start + 1 + [ $self->get_text_width(0, $self->feature_label($feat[0][2], $db_name), '', ptsize => $fontsize, font => $fontname) ]->[2]) if $self->{'show_labels'};
      my $x          = -1e8;
      my $row        = 0;
      
      if ($depth > 0) {
        $row = $self->bump_row($bump_start, $bump_end);
        
        if ($row > $depth) {
          $features_bumped++;
          next;
        }
      }
## EG - temporary fix for https://github.com/Ensembl/ensembl-webcode/pull/71      
      if ($config and $config->{'useScore'}) {
##
        my $score = $feat[0][2]->score || 0;
        
        # implicit_colour means that a colour has been arbitrarily assigned
        # during parsing and some stronger indication, such as the presence 
        # of scores, should override those assignments. -- ds23
        if ($config->{'useScore'} == 1 && $config->{'implicit_colour'}) {
          $feature_colour = $greyscale[min($ngreyscale - 1, int(($score * $ngreyscale) / $greyscale_max))];
          $label_colour   = '#333333';
        } elsif ($config->{'useScore'} == 2) {
          $score          = min(max($score, $min_score), $max_score);
          $feature_colour = $colour_gradient[$score >= $max_score ? $cg_grades - 1 : int(($score - $min_score) / $score_per_grade)];
        }
      }
      
      # +1 below cos we render eg a rectangle from (100, 100) of height
      # and width 10 as (100,100)-(110,110), ie actually 11x11. -- ds23
      $y_pos = $y_offset - $row * int($h + 1 + $gap * $label_h) * $strand;

      my $strand_y = $strand_bump && $feat[0][2]->strand == -1 ? $h : 0;
      my $position = {
        x      => $feat[0][0] > 1 ? $feat[0][0] - 1 : 0,
        y      => 0,
        width  => 0,
        height => $h,
      };
      
      my $composite;
      
      if (scalar @feat == 1 and $config->{'simpleblock_optimise'}) {
        $composite = $self;
      } else {
        $composite = $self->Composite({
          %$position,
          href  => $self->href($feat[0][2]),
          title => $self->feature_title($feat[0][2], $db_name),
          class => 'group',
        });
        
        $position = $composite;
      }
      
      foreach (@feat) {
        my ($s, $e, $f) = @$_;
        
        next if int($e * $pix_per_bp) <= int($x * $pix_per_bp);
        
        my $feature_object = ref $f ne 'HASH';
        my $start          = max($s, 1);
        my $end            = min($e, $length);
        my $cigar;
        
        $x = $end;
        
        if ($feature_object) {
          eval { $cigar = $f->cigar_string; };
          
          $feature_colour = $f->external_data->{'item_colour'}[0] if $config->{'itemRgb'} =~ /on/i;
        }
        
        if ($draw_cigar || $cigar =~ /$regexp/) {
          $composite->push($self->Space({
            x         => $start - 1,
            y         => 0,
            width     => $end - $start + 1,
            height    => $h,
            absolutey => 1,
          }));
          
          $self->draw_cigar_feature({
            composite      => $composite, 
            feature        => $f, 
            height         => $h, 
            feature_colour => $feature_colour, 
            label_colour   => $label_colour,
            delete_colour  => 'black', 
            scalex         => $pix_per_bp,
            y              => $strand_y,
          });
        } else {
          $composite->push($self->Rect({
            x            => $start - 1,
            y            => $strand_y,
            width        => $end - $start + 1,
            height       => $h,
            colour       => $feature_colour,
            label_colour => $label_colour,
            absolutey    => 1,
          }));
        }
        
        $features_drawn = 1;
      }
      
      if ($composite ne $self) {
        if ($h > 1) {
          $composite->bordercolour($feature_colour) if $join;
        } else {
          $composite->unshift($self->Rect({
            x         => $composite->{'x'},
            y         => $composite->{'y'},
            width     => $composite->{'width'},
            height    => $h,
            colour    => $join_colour,
            absolutey => 1
          }));
        }
        
        $composite->y($composite->y + $y_pos);
        $self->push($composite);
      }
      
      if ($self->{'show_labels'}) {
        $self->push($self->Text({
          font      => $fontname,
          colour    => $label_colour,
          height    => $fontsize,
          ptsize    => $fontsize,
          text      => $self->feature_label($feat[0][2], $db_name),
          title     => $self->feature_title($feat[0][2], $db_name),
          halign    => 'left',
          valign    => 'center',
          x         => $position->{'x'},
          y         => $position->{'y'} + $h + 2,
          width     => $position->{'x'} + ($bump_end - $bump_start) / $pix_per_bp,
          height    => $label_h,
          absolutey => 1,
          href      => $self->href($feat[0][2]),
        }));
      }
      
      if ($self->{'config'}->get_option('opt_highlight_feature') != 0 && exists $highlights{$i}) {
        $self->unshift($self->Rect({
          x         => $position->{'x'} - 1 / $pix_per_bp,
          y         => $position->{'y'} - 1,
          width     => $position->{'width'} + 2 / $pix_per_bp,
          height    => $h + 2,
          colour    => 'highlight1',
          absolutey => 1,
        }));
      }
    }
    
    $y_offset -= $strand * ($self->_max_bump_row * ($h + $gap + $label_h) + 6);
  }
  
  $self->_render_hidden_bgd($h) if $features_drawn && $self->my_config('addhiddenbgd') && $self->can('href_bgd');
  
  $self->errorTrack(sprintf q{No features from '%s' in this region}, $self->my_config('name')) unless $features_drawn || $self->{'no_empty_track_message'} || $self->{'config'}->get_option('opt_empty_tracks') == 0;
  $self->errorTrack(sprintf(q{%s features from '%s' omitted}, $features_bumped, $self->my_config('name')), undef, $y_offset) if $self->get_parameter('opt_show_bumped') && $features_bumped;
}

1;
