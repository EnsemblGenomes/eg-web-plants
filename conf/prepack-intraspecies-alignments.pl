#! /usr/bin/env perl

# Copyright [1999-2015] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute
# Copyright [2016-2026] EMBL-European Bioinformatics Institute
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use strict;
use warnings;

# Tool for prepacking intra-species alignment data to a JSON file.
#
# $ ./prepack-intraspecies-alignments.pl mysql://anonymous@mysql-eg-publicsql.ebi.ac.uk:4157/ensembl_compara_plants_63_116 ./json/compara_intra_species_alignments.json

use JSON;

use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;
use EnsEMBL::Web::Utils::Compara qw(_fetch_intraspecies_constraints _summarise_compara_alignments);
use Bio::EnsEMBL::Utils::IO qw(spurt);


my ($compara_url, $output_file) = @ARGV;

if (!($compara_url && $output_file)) {
  die("please specify a Compara database URL and output file\n");
}

my $compara_dba = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->go_figure_compara_dba($compara_url);
my $dbh = $compara_dba->dbc->db_handle;
my $constraint = EnsEMBL::Web::Utils::Compara::_fetch_intraspecies_constraints($dbh);
my $alignment_summary = EnsEMBL::Web::Utils::Compara::_summarise_compara_alignment_data($dbh, 'DATABASE_COMPARA', $constraint);
spurt($output_file, JSON->new->pretty->encode($alignment_summary->{'INTRA_SPECIES_ALIGNMENTS'}));
