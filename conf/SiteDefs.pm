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

package EG::Plants::SiteDefs;
use strict;
sub update_conf {
    $SiteDefs::ENSEMBL_PORT           = 8003;
    $SiteDefs::ENSEMBL_SERVERNAME     = 'plants.ensembl.org';


    $SiteDefs::__species_aliases{ 'Aegilops_tauschii'       } = [qw(ae)];
    $SiteDefs::__species_aliases{ 'Arabidopsis_lyrata'      } = [qw(al)];
    $SiteDefs::__species_aliases{ 'Arabidopsis_thaliana'    } = [qw(at)];
    $SiteDefs::__species_aliases{ 'Brachypodium_distachyon' } = [qw(bd)];
    $SiteDefs::__species_aliases{ 'Brassica_rapa'           } = [qw(br)];
    $SiteDefs::__species_aliases{ 'Oryza_brachyantha'       } = [qw(ob)];
    $SiteDefs::__species_aliases{ 'Oryza_glaberrima'        } = [qw(og)];
    $SiteDefs::__species_aliases{ 'Oryza_indica'            } = [qw(oi)];
    $SiteDefs::__species_aliases{ 'Oryza_sativa'            } = [qw(oj)];
    $SiteDefs::__species_aliases{ 'Physcomitrella_patens'   } = [qw(pp)];
    $SiteDefs::__species_aliases{ 'Populus_trichocarpa'     } = [qw(pt)];
    $SiteDefs::__species_aliases{ 'Setaria_italica'         } = [qw(si)];
    $SiteDefs::__species_aliases{ 'Solanum_lycopersicum'    } = [qw(sl)];
    $SiteDefs::__species_aliases{ 'Solanum_tuberosum'       } = [qw(st)];
    $SiteDefs::__species_aliases{ 'Sorghum_bicolor'         } = [qw(sb)];
    $SiteDefs::__species_aliases{ 'Triticum_urartu'         } = [qw(tu)];
    $SiteDefs::__species_aliases{ 'Vitis_vinifera'          } = [qw(vv)];
    $SiteDefs::__species_aliases{ 'Musa_acuminata'          } = [qw(ma)];
# Release 23
    $SiteDefs::__species_aliases{ 'Streococcus_lucimarinus' } = [qw(sl)];
    $SiteDefs::__species_aliases{ 'Brassica_oleracea'       } = [qw(bo)];
    $SiteDefs::__species_aliases{ 'Oryza_rufipogon'         } = [qw(or)];
    $SiteDefs::__species_aliases{ 'Leersia_perrieri'        } = [qw(lp)];
    $SiteDefs::__species_aliases{ 'Theobroma_cacao'         } = [qw(tc)];

    $SiteDefs::ENSEMBL_PRIMARY_SPECIES   = 'Oryza_sativa';
    $SiteDefs::ENSEMBL_SECONDARY_SPECIES = 'Arabidopsis_thaliana';

    $SiteDefs::ENSEMBL_BASE_URL          = 'http://plants.ensembl.org';

    $SiteDefs::ENSEMBL_SITETYPE = 'Ensembl Plants';
    $SiteDefs::SITE_NAME        = 'Ensembl Plants';
    $SiteDefs::SITE_FTP         = 'ftp://ftp.ensemblgenomes.org/pub/plants';

    @SiteDefs::ENSEMBL_PERL_DIRS =
      ( $SiteDefs::ENSEMBL_WEBROOT.'/perl',
        $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-common/perl',
        $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-plants/perl',
      );

    $SiteDefs::ENSEMBL_DATASETS = [
      'Arabidopsis_lyrata',
      'Arabidopsis_thaliana',
      'Aegilops_tauschii',
      'Amborella_trichopoda',
      'Brachypodium_distachyon',
      'Brassica_rapa',
      'Chlamydomonas_reinhardtii',
      'Cyanidioschyzon_merolae',
      'Glycine_max',
      'Hordeum_vulgare',
      'Medicago_truncatula',
      'Musa_acuminata',
      'Oryza_brachyantha',
      'Oryza_glaberrima',
      'Oryza_indica',
      'Oryza_sativa',
      'Oryza_barthii',
      'Oryza_glumaepatula',
      'Oryza_meridionalis',
      'Oryza_nivara',
      'Oryza_punctata',
      'Physcomitrella_patens',
      'Populus_trichocarpa',
      'Prunus_persica',
      'Selaginella_moellendorffii',
      'Setaria_italica',
      'Solanum_lycopersicum',
      'Solanum_tuberosum',
      'Sorghum_bicolor',
      'Triticum_aestivum',
      'Triticum_urartu',
      'Vitis_vinifera',
      'Zea_mays',

    ];

    push @SiteDefs::ENSEMBL_HTDOCS_DIRS, $SiteDefs::ENSEMBL_SERVERROOT. '/../biomarts/plants/biomart-perl/htdocs';
      
    $SiteDefs::DOCSEARCH_INDEX_DIR = $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-plants/data/docsearch';

    $SiteDefs::ENA_COLLECTION_ID = 224;

    $SiteDefs::ENA_SAMPLE_SEQ = "MDDCRFETSELQASVMISTPLFTDSWSSCNTANCNGSIKIHDIAGITYVAIPAVSMIQLGNLVGLPVTGDVLFPGLSSDEPLPMVDAAILKLFLQLKIKEGLELELLGKKLVVITGHSTGGALAAFTALWLLSQSSPPSFRVFCITFGSPLLGNQSLSTSISRSRLAHNFCHVVSIHDLVPRSSNEQFWPFGTYLFCSDKGGVCLDNAGSVRLMFNILNTTATQNTEEHQRYGHYVFTLSHMFLKSRSFLGGSIPDNSYQAGVALAVEALGFSNDDTSGVLVKECIETATRIVRAPILRSAELANELASVLPARLEIQWYKDRCDASEEQLGYYDFFKRYSLKRDFKVNMSRIRLAKFWDTVIKMVETNELPFDFHLGKKWIYASQFYQLLAEPLDIANFYKNRDIKTGGHYLEGNRPKRYEVIDKWQKGVKVPEECVRSRYASTTQDTCFWAKLEQAKEWLDEARKESSDPQRRSLLREKIVPFESYANTLVTKKEVSLDVKAKNSSYSVWEANLKEFKCKMGYENEIEMVVDESDAMET";

}

1;
