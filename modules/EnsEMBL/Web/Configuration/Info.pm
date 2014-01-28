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

# $Id $
package EnsEMBL::Web::Configuration::Info;
use strict;

sub modify_tree {
  my $self = shift;
  my $species = $self->hub->species;
  my $menu = $self->create_submenu('Appendix');
  $menu->append($self->create_node('WheatSearch', 'Wheat Search',
    [qw(wheatsearch EnsEMBL::Web::Component::Info::WheatSearch)],
    {'availability' => 1}
  ));
  ## must add from eg-plugins/common
  $self->create_node('PanComparaSpecies', 'Pan Compara Species',
    [qw(pan_species EnsEMBL::Web::Component::Info::PanComparaSpecies)],
    { availability => 1, title => 'Pan Compara Species' }
  );
  $self->get_node('Annotation')->data->{'title'} = 'Details';

}

1;

