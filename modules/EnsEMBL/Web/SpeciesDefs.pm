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

package EnsEMBL::Web::SpeciesDefs;

use strict;
use warnings;
no warnings qw(uninitialized);

use previous qw(prodnames_to_urls_lookup);

sub prodnames_to_urls_lookup {
  my $self = shift;
  my $compara_db = $_[0] || 'compara';

  my $lookup = $self->PREV::prodnames_to_urls_lookup(@_);

  if ($compara_db ne 'compara_pan_ensembl') {
    my $cdb_info = $self->multi_val('DATABASE_COMPARA');
    if (defined $cdb_info) {
      my $pan_info = $self->multi_val('PAN_COMPARA_LOOKUP');
      if (defined $pan_info) {
        # If we are working with a regular Compara database,
        # we can top up the lookup from Pan Compara info.
        foreach my $prod_name (keys %{$cdb_info->{'COMPARA_SPECIES'}}) {
          if (!exists $lookup->{$prod_name} && exists $pan_info->{$prod_name}) {
            $lookup->{$prod_name} = $pan_info->{$prod_name}{'species_url'};
          }
        }
      }
    }
  }

  return $lookup;
}

1;
