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

package EnsEMBL::Web::ConfigPacker;
use strict;
use warnings;
no warnings qw(uninitialized);

use previous qw(_munge_meta munge_databases_multi);


sub _munge_meta {
  my $self = shift;
  $self->PREV::_munge_meta(@_);
  my $full_tree = $self->full_tree;
  if (exists $full_tree->{'hordeum_vulgare_goldenmelon'}
        && defined $full_tree->{'hordeum_vulgare_goldenmelon'}
        && $full_tree->{'hordeum_vulgare_goldenmelon'}{'STRAIN_GROUP'} ne 'hordeum_vulgare') {
    $self->tree('hordeum_vulgare_goldenmelon')->{'STRAIN_GROUP'} = 'hordeum_vulgare';
  }
}

sub munge_databases_multi {
  my $self = shift;
  $self->PREV::munge_databases_multi(@_);
  $self->_configure_per_component_alignments;
}

sub _configure_per_component_alignments {
  my $self = shift;
  my $db_name = 'DATABASE_COMPARA';
  my $dbh = $self->db_connect($db_name);

  my $res_aref = $dbh->selectall_arrayref('
      select method_link_species_set_id, value
        from method_link_species_set_tag
      where tag = "genome_component"
  ');

  foreach my $row (@$res_aref) {
    my ($alignment_id, $genome_component) = ($row->[0], $row->[1]);
    if (exists $self->db_tree->{$db_name}{'ALIGNMENTS'}
          && exists $self->db_tree->{$db_name}{'ALIGNMENTS'}{$alignment_id}) {
      $self->db_tree->{$db_name}{'ALIGNMENTS'}{$alignment_id}{'genome_component'} = $genome_component;
    }
  }

  $dbh->disconnect;
}

1;
