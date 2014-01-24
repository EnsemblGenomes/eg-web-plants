# $Id $
package EnsEMBL::Web::Object::Gene;

# EG added for ENSEMBL-2041: suppress display of INSDC coords
sub insdc_accession {
 return 0;
}

1;
