package EnsEMBL::Web::Component::Compara_Alignments;

use strict;
use previous qw (draw_tree);
### This is a fix for ENSWEB-6844 until we have a longer term fix.
sub draw_tree {
  my $self = shift;
  my ($cdb, $align_blocks, $slice, $align, $class, $groups, $slices) = @_;
  if ($align == 313160) {
    return;
  }
  $self->PREV::draw_tree(@_);
}

1;
