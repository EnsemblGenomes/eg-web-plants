# $Id: MultiBottom.pm,v 1.2 2013-01-11 09:43:22 ek3 Exp $

package EnsEMBL::Web::ImageConfig::MultiBottom;

sub init {
  my $self = shift;
  
  $self->set_parameters({
    title           => 'Main panel',
    sortable_tracks => 1,  # allow the user to reorder tracks
    opt_lines       => 1,  # register lines
    global_options  => 1,
    spritelib       => { default => $self->species_defs->ENSEMBL_SERVERROOT . '/htdocs/img/sprites' }
  });

  # Add menus in the order you want them for this display
  $self->create_menus(qw(
    options 
    sequence
    marker
    transcript
    prediction
    protein_align 
    dna_align_cdna
    dna_align_est 
    dna_align_rna 
    dna_align_other 
    rnaseq
    oligo 
    simple
    misc_feature
    repeat
    variation 
    somatic 
    functional
    decorations 
    information 
  ));
  
  $self->get_node('options')->set('caption', 'Comparative features');
  
  $self->add_options( 
    [ 'opt_pairwise_blastz', 'BLASTz/LASTz net pairwise alignments',    {qw(off 0 normal normal compact compact)}, [qw(off Off normal Normal compact Compact)] ],
    [ 'opt_pairwise_tblat',  'Translated BLAT net pairwise alignments', {qw(off 0 normal normal compact compact)}, [qw(off Off normal Normal compact Compact)] ],
    [ 'opt_join_genes',      'Join genes', undef, undef, 'off' ]
  );
  
  if ($self->species_defs->valid_species($self->species)) {
    $_->set('menu', 'no') for map $self->get_node($_), qw(opt_pairwise_blastz opt_pairwise_tblat opt_join_genes);
    
    # Add in additional tracks
    $self->load_tracks;
  
    #bug fix BOF   
    $self->modify_configs([ 'prediction' ], { display => 'off' });
    #bug fix EOF

    $self->load_configured_das;
    
    $self->add_tracks('sequence', 
      [ 'contig', 'Contigs', 'contig', { display => 'normal', strand => 'r', description => 'Track showing underlying assembly contigs' }]
    );
    
    $self->add_tracks('decorations',
      [ 'scalebar',  '', 'scalebar',   { display => 'normal', strand => 'b', name => 'Scale bar', description => 'Shows the scalebar' }],
      [ 'ruler',     '', 'ruler',      { display => 'normal', strand => 'b', name => 'Ruler',     description => 'Shows the length of the region being displayed' }],
      [ 'draggable', '', 'draggable',  { display => 'normal', strand => 'b', menu => 'no' }],
      [ 'nav',       '', 'navigation', { display => 'normal', strand => 'b', menu => 'no' }]
    );
    
    $_->set('display', 'off') for grep $_->id =~ /^chr_band_/, $self->get_node('decorations')->nodes; # Turn off chromosome bands by default
    
    delete $self->{'extra_menus'}->{'display_options'};
  } else {
    $self->set_parameters({
      active_menu     => 'options',
      sortable_tracks => 0
    });
    
    $self->{'extra_menus'} = { display_options => 1 };
  }
}

1;
