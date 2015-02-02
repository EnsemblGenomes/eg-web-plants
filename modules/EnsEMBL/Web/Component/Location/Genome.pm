=head1 LICENSE

Copyright [2009-2014] EMBL-European Bioinformatics Institute

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

## EG Plants hack - Display warning only for Barley 
package EnsEMBL::Web::Component::Location::Genome;

use strict;
use previous qw(content);

sub content {
  my $self = shift;
  
  my $html = $self->PREV::content(@_);

  if ($html and $self->hub->species eq 'Hordeum_vulgare') {
    $html .= $self->_warning('Non-standard assembly', '<p>This assembly comprises sets of contigs co-located in unordered bins due to linkage with markers on physical and/or genetic maps. <a href="/Hordeum_vulgare/Info/Annotation/#assembly">More information</a></p>');
  }

  return $html;
}
##
1;
