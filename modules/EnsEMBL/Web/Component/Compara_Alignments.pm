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

package EnsEMBL::Web::Component::Compara_Alignments;

use strict;
use warnings;


sub check_for_wrong_genome_component {

  my ($self, $args) = @_;

  my $align         = $args->{align};
  my $db_key        = $args->{cdb} =~ /pan_ensembl/ ? 'DATABASE_COMPARA_PAN_ENSEMBL' : 'DATABASE_COMPARA';
  my $alignments    = $self->hub->species_defs->multi_hash->{$db_key}->{'ALIGNMENTS'};
  my $align_details = $alignments->{$align};
  my $slice         = $args->{slice} || $self->object->slice;

  my ($title, $warning);
  if ($align_details->{'type'} eq 'CACTUS_DB' && exists $align_details->{'genome_component'}) {
    my $slice_component = $slice->get_genome_component();

    if (defined $slice_component && $slice_component ne $align_details->{'genome_component'}) {

      $title = 'Region not in alignment';

      my @component_aligns = sort { $a <=> $b } grep {
        exists $alignments->{$_}{'genome_component'}
        && $alignments->{$_}{'genome_component'} eq $slice_component
      } keys %{$alignments};

      my $other_align_clause;
      if (@component_aligns) {
        my $other_align_name = $alignments->{$component_aligns[0]}{'name'} =~ s/_/ /gr;
        $other_align_clause = sprintf(", such as '%s'", encode_entities($other_align_name));
      }

      my $this_align_name = $align_details->{'name'} =~ s/_/ /gr;
      $warning = sprintf(
        "<p>The region selected is not part of the alignment '%s' - use the alignment selector to choose an alternative alignment%s.</p>",
        encode_entities($this_align_name),
        $other_align_clause,
      );
    }
  }

  return $warning ? $self->warning_panel($title, $warning) : undef;
}

1;
