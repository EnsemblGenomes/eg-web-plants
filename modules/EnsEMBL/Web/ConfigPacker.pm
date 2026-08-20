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

use Bio::EnsEMBL::Utils::IO qw(slurp);

no warnings qw(uninitialized);

use previous qw(_summarise_compara_alignments munge_databases_multi);

sub munge_databases_multi {
  my $self = shift;
  $self->PREV::munge_databases_multi(@_);
  $self->_configure_per_component_alignments;
  $self->_load_intra_species_alignments_from_json;
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

sub _find_intra_species_alignments_json_file {
  my $self = shift;

  my $json_location;
  foreach my $confdir (@SiteDefs::ENSEMBL_CONF_DIRS) {
    my $possible_json_location = "$confdir/json/compara_intra_species_alignments.json";
    if (-f $possible_json_location) {
      $json_location = $possible_json_location;
      last;
    }
  }

  return $json_location;
}

sub _load_intra_species_alignments_from_json {
  my $self = shift;

  my $json_file_path = $self->_find_intra_species_alignments_json_file();
  # Skip if INTRA_SPECIES_ALIGNMENTS JSON file does NOT exist.
  return if !$json_file_path;

  my $db_name = 'DATABASE_COMPARA';
  my $dbh = $self->db_connect($db_name);
  $self->db_tree->{$db_name}{'INTRA_SPECIES_ALIGNMENTS'} = from_json(slurp($json_file_path));
  $dbh->disconnect;
}

sub _summarise_compara_alignments {
  my $self = shift;

  my $json_file_path = $self->_find_intra_species_alignments_json_file();
  # Skip if INTRA_SPECIES_ALIGNMENTS JSON file exists.
  return if $json_file_path;

  $self->PREV::_summarise_compara_alignments(@_);
}

1;
