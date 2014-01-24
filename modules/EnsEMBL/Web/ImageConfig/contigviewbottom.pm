package EnsEMBL::Web::ImageConfig::contigviewbottom;

use strict;

sub modify {
  my $self = shift;
  
  my $gene_transcript_menu = $self->tree->get_node('gene_transcript');
  
  # create wheat menus
  my $wheat_menu = $self->create_submenu('wheat_alignment', 'Wheat SNPs and alignments');
  $gene_transcript_menu->after($wheat_menu);
  
  my $snp_menu             = $self->create_submenu('wheat_assembly', 'Wheat Assembly and SNPs');
  my $transcriptomics_menu = $self->create_submenu('wheat_transcriptomics', 'Wheat transcriptomics');
  my $est_menu             = $self->create_submenu('wheat_ests', 'Wheat ESTs');
  
  $wheat_menu->append($snp_menu);
  $wheat_menu->append($transcriptomics_menu);
  $wheat_menu->append($est_menu);

  my $rnaseq_cultivar_menu = $self->create_submenu('rnaseq_cultivar', 'RNASeq study of nine cultivars');
  my $rnaseq_tissue_menu = $self->create_submenu('rnaseq_tissue', 'RNASeq study of eight growth stages');
  my $mrna_prot   = $self->tree->get_node('mrna_prot')->append($rnaseq_cultivar_menu);
  $mrna_prot = $self->tree->get_node('mrna_prot')->append($rnaseq_tissue_menu);
 
  # move some SNPSs
  foreach (qw(simple_core_wheat_snp_a simple_core_wheat_snp_b)) {
    if (my $node = $self->tree->get_node($_)) {
      $node->remove;
      $snp_menu->append_children($node);
    }
  } 
  
  # move some ESTs
  foreach (qw(dna_align_otherfeatures_wheat_unigene_exonerate dna_align_otherfeatures_wheat_est_exonerate)) {
    if (my $node = $self->tree->get_node($_)) {
      $node->remove;
      $est_menu->append_children($node);
    }
  } 
  
  $self->load_configured_bam;
  $self->load_configured_bed;
} 

1;
