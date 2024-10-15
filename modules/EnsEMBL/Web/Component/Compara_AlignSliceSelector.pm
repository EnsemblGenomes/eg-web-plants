=head1 LICENSE

Copyright [2009-2024] EMBL-European Bioinformatics Institute

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

package EnsEMBL::Web::Component::Compara_AlignSliceSelector;

use strict;


sub _filter_alignments {
  my ($self, $alignments) = @_;

  my @non_polyploid_species = ('aegilops_tauschii', 'brachypodium_distachyon', 'hordeum_vulgare', 'secale_cereale', 'triticum_urartu');
  my $prodname  = $self->hub->species_defs->SPECIES_PRODUCTION_NAME;

  if (grep { $_ eq $prodname } @non_polyploid_species) {
    my @alignment_ids = grep { $_ != 314995 && $alignments->{$_}{'type'} ne 'CACTUS_DB' } keys %$alignments;
    $alignments = {map { $_ => $alignments->{$_} } @alignment_ids};
  }

  return $alignments;
}

1;
