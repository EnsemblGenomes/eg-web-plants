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

package EnsEMBL::Web::ImageConfig::alignsliceviewbottom;

use strict;

use previous qw (init_cacheable);


sub init_cacheable {

  my $self = shift;

  $self->PREV::init_cacheable(@_);

  my $align_params = $self->hub->referer->{'params'}{'align'}[0];
  my ($align) = split '--', $align_params;

  if ($align == 314995) {
    my $align_type = $self->species_defs->multi_hash->{'DATABASE_COMPARA'}{'ALIGNMENTS'}{$align}{'type'};
    if ($align_type eq 'CACTUS_DB') {
      my $node = $self->get_node('transcript');
      my @tracks = grep { $_->get_data('node_type') eq 'track' } @{$node->get_all_nodes};
      foreach my $track (@tracks) {
        if ($track->get_data('key') ne 'ensembl') {
          $track->set_data('display', 'off');
        }
      }
    }
  }
}

1;
