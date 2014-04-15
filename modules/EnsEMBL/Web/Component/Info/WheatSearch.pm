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

  return $self->pageHTML($seq);
}

sub pageHTML {
    my $self = shift;
    my ($seq, $fn, $jobid, @params) = @_;
    my $hub = $self->hub;
    my $species_defs      = $hub->species_defs;

    my $evalue = $hub->param('evalue') || 1;
    my $qtype = $hub->param('splicing');

#   my $file = "/ssi/species/about_${species}.html";
#   my $html = EnsEMBL::Web::Controller::SSI::template_INCLUDE($self, $file);


    my @evalues = qw(10 1 0.1 1E-3 1E-5 1E-10 1E-20 1E-40 1E-80);
    my $evalue_html = join "\n",  map { $_ eq $evalue ? "<option value=\"$_\" selected>$_</option>" : "<option value=\"$_\">$_</option>" } @evalues;
    
    my $splice_html = $qtype ? 'checked' : '';
    
    my $html = qq{
<div id="enawrapper">
<form method="post" enctype="multipart/form-data" action="#" id="blastForm" name="iform">
<input type="hidden" name="jobid" id="jobid" value="$jobid" />
<input type="hidden" name="sdomain" id="sdomain" value="23" />

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
<input type="submit" value="Submit" id="submit-button" class="jobSmall" style="float:right" />
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

</form>
<div id="ena-results" style="width:100%">
</div>

</div>
};

  $html = sprintf '<div class="js_panel"><input type="hidden" class="panel_type" value="ENASearch"/>%s</div>', $html;
  return $html;

# $file = "/ssi/species/extra_${species}.html";
# $html .= EnsEMBL::Web::Controller::SSI::template_INCLUDE($self, $file);

}

1;
