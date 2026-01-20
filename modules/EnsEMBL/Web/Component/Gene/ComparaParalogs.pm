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

package EnsEMBL::Web::Component::Gene::ComparaParalogs;

use strict;
use warnings;


sub _show_unannotated_paralogs_info_panel {
  my ($self, $strain) = @_;
  my $html;

  my @info_text_parts = (
    'Due to the large number of ancient paralogues of this gene in its supertree, not all of its ancient paralogues have been annotated.',
    ' As a consequence, this list of paralogues may be incomplete.',
  );

  if ($self->object->availability->{'family'}) {
    push(@info_text_parts, 'Homologues of this gene may be accessible through its "Gene families" page.')
  }

  my $info_panel_html = '<p>' . join(' ', @info_text_parts) . '</p>';
  $html = $self->_info_panel('warning', 'Unannotated paralogues', $info_panel_html);

  return $html;
}


1;
