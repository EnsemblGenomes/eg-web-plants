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

package EnsEMBL::Web::Component::Gene::GeneFamilies;

use strict;
use warnings;


sub _show_large_gene_family_info_panel {
  my $self = shift;

  my $msg = '<p>The EnsemblCompara protein-trees pipeline has identified this gene as a member of a very large gene family, shown here.'
            . ' Because of the number of genes involved, some or all of the members of this family lack protein-tree and homology pair data.'
            . ' For more information, see <a href="https://www.ensembl.info/2026/01/14/large-plant-protein-clusters-accessible-via-gene-families-view/">'
            . 'this blog post on large gene families</a>.</p>';

  return $self->_info_panel('info', 'Large gene family', $msg);
}

1;
