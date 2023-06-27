package EnsEMBL::Web::Component::Compara_Alignments;

use strict;
use previous qw (draw_tree);

sub draw_tree {
  my ($self, $cdb, $align_blocks, $slice, $align, $class, $groups, $slices) = @_;
  warn $align;
  if ($align == 313160) {
    return;
  }
  $self->PREV::draw_tree(@_);
}

1;
