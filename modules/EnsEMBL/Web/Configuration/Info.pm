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

