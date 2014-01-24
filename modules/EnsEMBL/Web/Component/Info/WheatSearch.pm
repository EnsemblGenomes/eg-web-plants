# $Id $
package EnsEMBL::Web::Component::Info::WheatSearch;
use strict;
use base qw(EnsEMBL::Web::Component);

use ENASearch;
use ENAResult;
sub _init {
  my $self = shift;
  $self->cacheable(0);
  $self->ajaxable(0);
}
sub content {
  my $self              = shift;
  return $self->wheatHomePage;
}
sub wheatHomePage {
  my $self              = shift;
  my $hub               = $self->hub;

  my $evalue = $hub->param('evalue') || 1;
  my $qtype = $hub->param('splicing');
  my $domain = 23;
  my $jobid = $hub->param('jobid');
  my $jobstatus = $hub->param('jobstatus');
  my $masking = $hub->param('masking');
  my $species_defs      = $hub->species_defs;
  my $html = '';

  if ($jobstatus eq 'ready') {
    my $seq = $hub->param('_query_sequence');
    $html .= $self->pageHTML($seq, 'loadResults', $jobid, $evalue, $qtype, $masking, $domain);
    return $html;
  }


  if (my $seq = $hub->param('_query_sequence')) {	
      $seq =~ s/^\>.*\n//;
      my $search = new ENASearch({_species_defs => $species_defs});
      $search->collection = $domain;
      $search->masking = 'Soft_Masking'  if ($masking && $masking eq 'on');
      $search->splicing = 1	  if ($qtype && $qtype eq 'on');

      my $jobid = $search->submit($seq);

      $html .= $self->pageHTML($seq, 'setUpdate', $jobid, $evalue, $qtype, $masking, $domain);

      $html .= qq{
<script>\$(document).ready(
function(){
  setUpdate('$jobid','$evalue','$qtype','$masking','$domain');
}
);
</script>
};

      my $pid = fork();
      if (not defined $pid) {
	  print "resources not avilable.\n";
      } elsif ($pid == 0) {
	  getResults($search, $evalue);
	  exit(0);
      } else {
	  #    waitpid($pid,0);
      }  
    return $html;
  }


  my $seq = ">Example Sequence\n".
'CTTGTGGGTGTCCAGCATGAGGAACGCGAAGAGCGCACAGAACAGGCTCACGCACAGCTT
CCCCAGGAACAGGATCACGTCCCCGATCACGTTCACCTTCCCGATGCGCAGTATGTTGTT
CATTATGAGGCCGGTCGCGAGCACCGAAGCTTTGAAGAACCCTTTCCCCGTGATGGCAAT
CTGCAAAaCAGCAAaGAGAAGCCTTGTCAGTTCAAAAGTTGCAACTCTCAAATGATAGAC
AGACAAAAGgAGTTCAGAACTATCAGGTCAAATGCGGGGAGTGAACAGCCCCAAATGGCG
CACCATAAAAGCCCAGTCGGCAATCATTATGAACAAAGCAGACAACCAATGGCATTGTGC
TTCAGGACAGGAACGATCaGTAAAaCAAAAAAAaTGTTCATGCTTACCATTATGTAGGCA
TTTCGATTTaCGGACATGAGGGTCCAGTCTATGCAGCCTCGGCAGCACTGAGACGAGGAC
GATGACACTTTCCCAAAGCAGCTCTCCCCAGCAGAACCGACCAGCTTCAACTTGCGGCGA
AGGCATTCTAGTATAAACCGCACCCACTCAACAGCAGACACAACAAGCGAGCCTATGGCA
GCAGATCCAAGGTTGTAACGCATCAGCCGCTTGAGCGAAGAGACAACACTGACAAACGGT
ATATCATGCTGCACcAGAATGGCTTCAaTTGTCAGTAAATGGTGATAatGCAAAAGTATG
GAGTAAATTAAAGAGCACCCATTTAGtAAAAATAGTtGAAGTTCTGACTCTTTTGtGCTG
TACTTACAGATATTTCGCCACGCGCCCAGTAGTAAGAAGCAACTGATCCAGCAACCACAG
TTGCAGAGCATGCCATGAAGAATTGAGTAGCCCAGTAGCATCCAAATAAGTGGAAAAGAA
TGGCAATGCCGATATGAGGGGTGTAGTGGATGCTGTACCCACAACAGTTGTCACAGTTCA
CTTTGCCCAACTTCAGATCATATGAACAACAATCTGTACTGCAGTCATTTCGGACAACTT
GACCAGAGCTGAAGAGGTGGAGTGTAGCAGAAAACCAGAACATaTAAAaGATAGCGaGGA
TAAAATACGGCACAACTGGGAAAACTATCAGTGCCTGAACTTCACCAATGACCTTCGCAG
CAACCTG';
  $html .= $self->pageHTML($seq);

  return $html;

}
sub pageHTML {
    my $self = shift;
    my ($seq, $fn, $jobid, @params) = @_;
    my $hub = $self->hub;
    my $species_defs      = $hub->species_defs;

    my $evalue = $hub->param('evalue') || 1;
    my $qtype = $hub->param('splicing');

    my $section = $hub->param('page');
    my $column = $hub->param('order');

    my $page_size = 10;
    my $species           = $hub->species;

#   my $file = "/ssi/species/about_${species}.html";
#   my $html = EnsEMBL::Web::Controller::SSI::template_INCLUDE($self, $file);
    my $html = "";

    $html .= qq{
 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    };

    my @evalues = qw(10 1 0.1 1E-3 1E-5 1E-10 1E-20 1E-40 1E-80);
    my $evalue_html = join "\n",  map { $_ eq $evalue ? "<option value=\"$_\" selected>$_</option>" : "<option value=\"$_\">$_</option>" } @evalues;
    
    my $splice_html = $qtype ? 'checked' : '';
    
    $html .= qq{
<div id="enawrapper">
<form method="post" enctype="multipart/form-data" action="#" id="blastForm" name="iform">
<input type="hidden" name="jobid" id="jobid" value="$jobid" />
<input type="hidden" name="jobstatus" id="jobstatus" />

<table id="ena-content" class="center" >
<tr> <td id="ena-seq-td" rowspan="2">
<div class="jobBox">
<h1>Query Sequence (DNA only)</h1>
<textarea id="ena-seq" name="_query_sequence" onfocus="if(this.value.match(/Example/)) this.value='';">$seq</textarea>

</div>
</td>
<td id="ena-options">
<div class="jobBox">
<h1>Options</h1>
<ul>
<li><label class="altLabel" for="evalue">Maximum E-Value</label>
<select id="evalue" class="jobSmall hashelp" name="evalue">
$evalue_html
</select>
</li>
<li><label class="altLabel" for="splicing">Use spliced query</label>
<input type="checkbox" name="splicing" id="splicing" $splice_html />
</li>
</ul>
</div></td>
</tr>
<tr>
<td style="vertical-align:bottom">
<div id="submit-box"  class="jobBox">
<table>
<tr>
<td>
<input type="submit" value="Submit" id="submit-button" class="jobSmall" style="float:right" onclick="resetStatus();" />
</td>
<td style="width:190px;">
<div id="progress">
<div id="progress-msg"></div>
<div id="progress-bar">&nbsp;</div>
</div>
</td>
</tr>
</table>
</div>
</td>
</tr>

<tr>
<td colspan="2">
</td>
</tr>
</table>

};

if ($fn && $fn eq 'loadResults') {
	my $result = new ENAResult( { _jobid => $jobid, _species_defs => $species_defs } );
	$result->fetch_alignments($column, $section, $page_size);
	$html .= $result->render;
}

$html .= qq{
</form>
</div>
};


# $file = "/ssi/species/extra_${species}.html";
# $html .= EnsEMBL::Web::Controller::SSI::template_INCLUDE($self, $file);

  return $html;
}


sub getResults {
  my ($search, $maxval) = @_;

  my $hitcount = 0;
  my $status;

  while (($status = $search->status) =~ /RUNNING_SEARCH|COMPLETE/) {
#      warn "$status";
      if (my @alignments = @{$search->new_alignments($maxval) || []}) {
	$hitcount += scalar(@alignments);
      }
      last if ($status eq 'COMPLETE');
  }
#  warn " COMPLETED ($status / $hitcount)\n";
}

1;
