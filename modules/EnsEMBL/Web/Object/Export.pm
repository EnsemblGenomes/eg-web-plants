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

package EnsEMBL::Web::Object::Export;

sub config {
  my $self = shift;
  
  $self->__data->{'config'} = {
    fasta => {
      label => 'FASTA sequence',
      formats => [
        [ 'fasta', 'FASTA sequence' ]
      ],
      params => [
        [ 'cdna',    'cDNA' ],
        [ 'coding',  'Coding sequence' ],
        [ 'peptide', 'Peptide sequence' ],
        [ 'utr5',    "5' UTR" ],
        [ 'utr3',    "3' UTR" ],
        [ 'exon',    'Exons' ],
        [ 'intron',  'Introns' ]
      ]
    },
    features => {
      label => 'Feature File',
      formats => [
        [ 'csv',  'CSV (Comma separated values)' ],
        [ 'tab',  'Tab separated values' ],
        [ 'gtf',  'GTF (Gene Transfer Format)' ],
        [ 'gff',  'GFF (Generic Feature Format)' ],
        [ 'gff3', 'GFF3 (Generic Feature Format Version 3)' ],
      ],
      params => [
        [ 'similarity', 'Similarity features' ],
        [ 'repeat',     'Repeat features' ],
        [ 'genscan',    'Prediction features (genscan)' ],
        [ 'variation',  'Variation features' ],
        [ 'probe',      'Probe features' ],
        [ 'gene',       'Gene information' ],
        [ 'transcript', 'Transcripts' ],
        [ 'exon',       'Exons' ],
        [ 'intron',     'Introns' ],
        [ 'cds',        'Coding sequences' ]
      ]
    },
    bed => {
      label => 'Bed Format',
      formats => [
        [ 'bed',  'BED Format' ],
      ],
      params => [
        [ 'variation',  'Variation features' ],
        [ 'probe',      'Probe features' ],
        [ 'gene',       'Gene information' ],
        [ 'repeat',     'Repeat features' ],
        [ 'similarity', 'Similarity features' ],
        [ 'genscan',    'Prediction features (genscan)' ],
        [ 'userdata',  'Uploaded Data' ],
      ]
    },
#     PSL => {
#       label => 'PSL Format',
#       formats => [
#         [ 'PSL',  'PSL Format' ],
#       ],
#       params => [
#           [ 'name',  'Bed Line Name' ],
#         ]
#     },
#    flat => {

## ENA  
#      label => 'Flat File',
#      formats => [
#        [ 'embl',    'EMBL' ],
#        [ 'genbank', 'GenBank' ]
#      ],
#      params => [
#        [ 'similarity', 'Similarity features' ],
#        [ 'repeat',     'Repeat features' ],
#        [ 'genscan',    'Prediction features (genscan)' ],
#        [ 'contig',     'Contig Information' ],
#        [ 'variation',  'Variation features' ],
#        [ 'marker',     'Marker features' ],
#        [ 'gene',       'Gene Information' ],
#        [ 'vegagene',   'Vega Gene Information' ],
#        [ 'estgene',    'EST Gene Information' ]
#      ]
#    },
## /ENA

    pip => {
      label => 'PIP (%age identity plot)',
      formats => [
        [ 'pipmaker', 'Pipmaker / zPicture format' ],
        [ 'vista',    'Vista Format' ]
      ]
    },
    genetree => {
      label => 'Gene Tree',
      formats => [
        [ 'phyloxml',    'PhyloXML from Compara' ],
        [ 'phylopan',    'PhyloXML from Pan-taxonomic Compara' ]
      ],
      params => [
        [ 'cdna', 'cDNA rather than protein sequence' ],
        [ 'aligned', 'Aligned sequences with gaps' ],
        [ 'no_sequences', 'Omit sequences' ],
      ]
    },
    homologies => {
      label => 'Homologies',
      formats => [
        [ 'orthoxml',    'OrthoXML from Compara' ],
        [ 'orthopan',    'OrthoXML from Pan-taxonomic Compara' ]
      ],
      params => [
        [ 'possible_orthologs', 'Treat not supported duplications as speciations (makes a non species-tree-compliant tree)' ],
      ]
    }  
  };

if(! $self->get_object->can('get_GeneTree') ){
	delete $self->__data->{'config'}{'genetree'};
	delete $self->__data->{'config'}{'homologies'};
}
  
  my $func = sprintf 'modify_%s_options', lc $self->function;
  $self->$func if $self->can($func);
  
  return $self->__data->{'config'};
}

1;
