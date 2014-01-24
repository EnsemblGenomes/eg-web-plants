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
