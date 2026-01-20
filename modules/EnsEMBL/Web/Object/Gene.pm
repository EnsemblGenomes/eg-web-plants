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

# $Id $
package EnsEMBL::Web::Object::Gene;

# EG added for ENSEMBL-2041: suppress display of INSDC coords
sub insdc_accession {
 return 0;
}

sub getReactomeXrefs() {
  my $self   = shift;
  return $self->Obj->get_all_DBEntries('Plant_Reactome_Pathway');
}

sub has_unannotated_paralogs {
  my $self        = shift;
  my $compara_db  = shift || 'compara';
  my $consensus_clusterset_id = shift || 'default';

  my $cache_key  = sprintf('_has_unannotated_paralogs_%s_%s', $compara_db, $consensus_clusterset_id);

  if (!$self->{$cache_key}) {
    my $args = {'stable_id' => $self->stable_id, 'cdb' => $compara_db};
    my $member  = $self->get_compara_Member($args);

    my $has_unannotated_paralogs = 0;
    if ($member) {
      my $gene_tree_adaptor = $member->adaptor->db->get_adaptor('GeneTree');
      if ($gene_tree_adaptor) {
        my $tree = $gene_tree_adaptor->fetch_default_for_Member($member, $consensus_clusterset_id);
        if($tree && $tree->get_tagvalue('has_other_paralog_groups')) {
          my $gtos_adaptor = $tree->adaptor->db->get_adaptor('GeneTreeObjectStore');
          if ($gtos_adaptor) {
            my $json_string = $gtos_adaptor->fetch_by_GeneTree_and_label($tree, 'other_paralog_groups');
            if ($json_string) {
              my $other_paralog_groups = JSON->new->decode($json_string);
              while (my ($gdb_id, $rec) = each %{$other_paralog_groups}) {
                if (grep {$_ == $member->gene_member_id} @{$rec->{'gene_member_ids'}}) {
                  $has_unannotated_paralogs = 1;
                }
              }
            }
          }
        }
      }
    }

    $self->{$cache_key} = $has_unannotated_paralogs;
  }

  return $self->{$cache_key};
}

1;
