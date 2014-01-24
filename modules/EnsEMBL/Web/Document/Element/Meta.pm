package EnsEMBL::Web::Document::Element::Meta;

sub init {
  my $self = shift;
  $self->add('description', 'Ensembl Plants is a genome-centric portal for plant species of scientific interest');
  $self->add('keywords', 'Ensembl, Ensembl Genomes, genome, genome browser, comparative genomics, variation, SNPs, EST, mRNA, rna-Seq, orthologs, paralogs, synteny, assembly, genes, transcripts, translations, proteins, cereals, monocots, dicots, moss, Arabidsopsis, rice, maize, 1001 genomes, plants');
  $self->add('google-site-verification', 'tC5CRODhAwiBEeIZY_EP_k7AaLGupandW7e1v3_s8ak');
}

1;
