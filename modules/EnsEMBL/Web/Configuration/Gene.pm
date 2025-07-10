
=head1 LICENSE

Copyright [2009-2025] EMBL-European Bioinformatics Institute

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

package EnsEMBL::Web::Configuration::Gene;

use HTML::Entities qw(encode_entities);

use previous qw(modify_tree);


sub modify_tree {
  my $self = shift;

  $self->PREV::modify_tree(@_);

  my $strain_compara_menu = $self->get_node('Strain_Compara');

  if (defined $strain_compara_menu) {
    my $related_taxon = $self->hub->species_defs->get_config($self->hub->species, 'RELATED_TAXON');  # e.g. 'rice_cultivars'
    if (defined $related_taxon) {
      $related_taxon =~ tr/[A-Z]_/[a-z] /;  # e.g. from 'rice_cultivars' to 'rice cultivars'
      my $strain_cset_title = ucfirst($related_taxon);  # e.g. from 'rice cultivars' to 'Rice cultivars'
      $strain_compara_menu->set_data('caption', encode_entities($strain_cset_title));
    }
  }
}


1;
