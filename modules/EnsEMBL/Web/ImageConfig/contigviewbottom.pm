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

package EnsEMBL::Web::ImageConfig::contigviewbottom;

use strict;

sub modify {
  my $self = shift;

  # move some SNPSs
  my $snp_menu = $self->tree->get_node('wheat_assembly');
  foreach (qw(simple_core_wheat_snp_a simple_core_wheat_snp_b)) {
    if (my $node = $self->tree->get_node($_)) {
      $node->remove;
      $snp_menu->append_children($node);
    }
  } 
  
  # move some EST
  my $est_menu = $self->tree->get_node('wheat_ests');
  foreach (qw(dna_align_otherfeatures_wheat_unigene_exonerate dna_align_otherfeatures_wheat_est_exonerate dna_align_otherfeatures_wheat_est_star)) {
    if (my $node = $self->tree->get_node($_)) {
      $node->remove;
      $est_menu->append_children($node);
    }
  } 
  
  my $ml = $self->get_node('fg_methylation_legend');
  $ml->remove if $ml;
} 

1;
