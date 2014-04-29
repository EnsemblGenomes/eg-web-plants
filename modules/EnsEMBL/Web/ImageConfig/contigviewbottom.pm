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

package EnsEMBL::Web::ImageConfig::contigviewbottom;

use strict;

sub modify {
  my $self = shift;

  my $gene_transcript_menu = $self->tree->get_node('gene_transcript');

  # create wheat menus
  my $wheat_menu = $self->create_submenu('wheat_alignment', 'Wheat SNPs and alignments');

  $gene_transcript_menu->after($wheat_menu);
  
  my $snp_menu             = $self->create_submenu('wheat_assembly', 'Wheat Assemblies and SNPs');
  my $transcriptomics_menu = $self->create_submenu('wheat_transcriptomics', 'Wheat transcriptomics');
  my $est_menu             = $self->create_submenu('wheat_ests', 'Wheat UniGene and ESTs');
  
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
  
  # move some EST
  foreach (qw(dna_align_otherfeatures_wheat_unigene_exonerate dna_align_otherfeatures_wheat_est_exonerate dna_align_otherfeatures_wheat_est_star)) {
    if (my $node = $self->tree->get_node($_)) {
      $node->remove;
      $est_menu->append_children($node);
    }
  } 
  
  # add resequencing menu - put this in core webcode?
  $self->tree->get_node('functional')->after( $self->create_submenu('resequencing', 'Resequencing') ); 

  $self->load_configured_bam;
  $self->load_configured_bed;
  $self->load_configured_bedgraph;
  $self->load_configured_bigwig;
  $self->load_configured_bigbed;
  $self->load_configured_mw;
  $self->load_configured_vcf;
  
  $self->add_track('information', 'gradient_legend', 'Gradient Legend', 'gradient_legend', { strand => 'r' });
} 

1;
