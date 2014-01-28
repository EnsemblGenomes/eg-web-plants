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

# $Id: ExternalData.pm,v 1.1 2013-03-13 16:47:35 jh15 Exp $
# EG see ENSEMBL-2053. This overrides the plugin from eg-plugins/common/
# The function form() should be kept identical to core webcode

package EnsEMBL::Web::ViewConfig::ExternalData;

use strict;

sub form {
  my $self    = shift;
  my $hub     = $self->hub;
  my $view    = $hub->type . '/ExternalData';
  my @all_das = sort { lc $a->label cmp lc $b->label } grep $_->is_on($view), values %{$hub->get_all_das};
  
  $self->add_fieldset('DAS sources');
  
  foreach my $das (@all_das) {
    $self->add_form_element({
      type  => 'DASCheckBox',
      das   => $das,
      name  => $das->logic_name,
      value => 'yes'
    });
  }
  
  $self->get_form->force_reload_on_submit if $hub->param('reset');
}

1;
