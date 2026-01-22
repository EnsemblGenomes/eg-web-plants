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

package EnsEMBL::Web::Query::Availability::Gene;

use previous qw(_counts);


sub _counts {
  my $self = shift;

  my ($args,$member) = @_;
  my $counts = $self->PREV::_counts(@_);

  if ($member) {
    my $division = $self->sd_config($args, 'DIVISION');
    if ($division) {
      $counts->{'families'} = $member->number_of_families($division);
    }
  }

  return $counts;
}


1;
