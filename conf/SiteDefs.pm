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

    $SiteDefs::ENSEMBL_PRIMARY_SPECIES   = 'Oryza_sativa';
    $SiteDefs::ENSEMBL_SECONDARY_SPECIES = 'Arabidopsis_thaliana';

    $SiteDefs::ENSEMBL_BASE_URL          = 'http://plants.ensembl.org';

    $SiteDefs::ENSEMBL_SITETYPE = 'Ensembl Plants';
    $SiteDefs::SITE_NAME        = 'Ensembl Plants';
    $SiteDefs::SITE_FTP         = 'ftp://ftp.ensemblgenomes.org/pub/plants';

    @SiteDefs::ENSEMBL_PERL_DIRS =
      ( $SiteDefs::ENSEMBL_SERVERROOT.'/perl',
        $SiteDefs::ENSEMBL_SERVERROOT.'/eg-plugins/common/perl',
        $SiteDefs::ENSEMBL_SERVERROOT.'/eg-plugins/plants/perl',
      );

    $SiteDefs::ENSEMBL_DATASETS = [
      'Arabidopsis_lyrata',
      'Arabidopsis_thaliana',
      'Aegilops_tauschii',
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
      'Physcomitrella_patens',
      'Populus_trichocarpa',
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
      
    $SiteDefs::DOCSEARCH_INDEX_DIR = $SiteDefs::ENSEMBL_SERVERROOT.'/eg-plugins/plants/data/docsearch';

    $SiteDefs::ENA_COLLECTION_ID = 224;

    $SiteDefs::ENA_SAMPLE_SEQ = "MDDCRFETSELQASVMISTPLFTDSWSSCNTANCNGSIKIHDIAGITYVAIPAVSMIQLGNLVGLPVTGDVLFPGLSSDEPLPMVDAAILKLFLQLKIKEGLELELLGKKLVVITGHSTGGALAAFTALWLLSQSSPPSFRVFCITFGSPLLGNQSLSTSISRSRLAHNFCHVVSIHDLVPRSSNEQFWPFGTYLFCSDKGGVCLDNAGSVRLMFNILNTTATQNTEEHQRYGHYVFTLSHMFLKSRSFLGGSIPDNSYQAGVALAVEALGFSNDDTSGVLVKECIETATRIVRAPILRSAELANELASVLPARLEIQWYKDRCDASEEQLGYYDFFKRYSLKRDFKVNMSRIRLAKFWDTVIKMVETNELPFDFHLGKKWIYASQFYQLLAEPLDIANFYKNRDIKTGGHYLEGNRPKRYEVIDKWQKGVKVPEECVRSRYASTTQDTCFWAKLEQAKEWLDEARKESSDPQRRSLLREKIVPFESYANTLVTKKEVSLDVKAKNSSYSVWEANLKEFKCKMGYENEIEMVVDESDAMET";

}

1;
