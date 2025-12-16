
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

use JSON;

use previous qw(_counts get);


sub _counts {
  my $self = shift;

  my ($args,$member) = @_;
  my $counts = $self->PREV::_counts(@_);
  my $division = $self->sd_config($args, 'DIVISION');
  $counts->{'families'} = $member->number_of_families($division);

  return $counts;
}


sub get {

  my ($self, $args) = @_;
  my $hub = $self->context;
  my $species_defs = $hub->species_defs;

  my ($out) = @{$self->PREV::get($args)};

  my $member;

  if ($out->{'has_gene_tree'}) {
    $member = $self->compara_member($args) if (!defined $member);
    my $gene_tree_adaptor = $member->adaptor->db->get_adaptor('GeneTree');
    if ($gene_tree_adaptor) {
      my $tree = $gene_tree_adaptor->fetch_default_for_Member($member);
      if($tree && $tree->get_tagvalue('has_other_paralog_groups')) {
        my $gtos_adaptor = $tree->adaptor->db->get_adaptor('GeneTreeObjectStore');
        my $json_string = $gtos_adaptor->fetch_by_GeneTree_and_label($tree, 'other_paralog_groups');
        my $other_paralog_groups = JSON->new->decode($json_string);
        my $member_has_unannotated_paralogs = 0;
        while (my ($gdb_id, $rec) = each %{$other_paralog_groups}) {
          if (grep {$_ eq $member->gene_member_id} @{$rec->{'gene_member_ids'}}) {
            $member_has_unannotated_paralogs = 1;
            last;
          }
        }

        $out->{'has_other_paralogs_unannotated'} = $member_has_unannotated_paralogs;
      }
    }
  }

  if ($out->{'has_strain_gene_tree'}) {
    $member = $self->compara_member($args) if (!defined $member);
    my $gene_tree_adaptor = $member->adaptor->db->get_adaptor('GeneTree');
    if ($gene_tree_adaptor) {
      my $strain_cset_id = $species_defs->get_config($hub->species,'RELATED_TAXON');
      my $strain_tree = $gene_tree_adaptor->fetch_default_for_Member($member, $strain_cset_id);
      if($strain_tree && $strain_tree->get_tagvalue('has_other_paralog_groups')) {
        my $gtos_adaptor = $strain_tree->adaptor->db->get_adaptor('GeneTreeObjectStore');
        my $json_string = $gtos_adaptor->fetch_by_GeneTree_and_label($strain_tree, 'other_paralog_groups');
        my $other_paralog_groups = JSON->new->decode($json_string);
        my $member_has_unannotated_paralogs = 0;
        while (my ($gdb_id, $rec) = each %{$other_paralog_groups}) {
          if (grep {$_ eq $member->gene_member_id} @{$rec->{'gene_member_ids'}}) {
            $member_has_unannotated_paralogs = 1;
            last;
          }
        }

        $out->{'has_strain_other_paralogs_unannotated'} = $member_has_unannotated_paralogs;
      }
    }
  }

  return [$out];
}


1;
