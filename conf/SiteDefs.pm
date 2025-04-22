=head1 LICENSE

Copyright [2009-2024] EMBL-European Bioinformatics Institute

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

    $SiteDefs::ENSEMBL_PRIMARY_SPECIES   = 'Oryza_sativa';
    $SiteDefs::ENSEMBL_SECONDARY_SPECIES = 'Arabidopsis_thaliana';

    $SiteDefs::ENSEMBL_BASE_URL          = 'http://plants.ensembl.org';
    # TODO dedup these if equivalent
    $SiteDefs::DIVISION         = 'plants';
    $SiteDefs::EG_DIVISION      = 'plants';
    $SiteDefs::SUBDOMAIN_DIR    = 'plants';
    $SiteDefs::ENSEMBL_SITETYPE = 'Ensembl Plants';
    $SiteDefs::SITE_NAME        = 'Ensembl Plants';
    $SiteDefs::SITE_FTP         = 'https://ftp.ensemblgenomes.ebi.ac.uk/pub/plants';

    @SiteDefs::ENSEMBL_PERL_DIRS =
      ( $SiteDefs::ENSEMBL_WEBROOT.'/perl',
        $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-common/perl',
        $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-plants/perl',
      );

    $SiteDefs::PRODUCTION_NAMES = [sort qw(
      actinidia_chinensis
      ananas_comosus
      arabidopsis_halleri
      arabidopsis_lyrata
      arabidopsis_thaliana
      arabis_alpina
      arachis_hypogaea
      asparagus_officinalis
      aegilops_tauschii
      aegilops_umbellulata
      amborella_trichopoda
      avena_sativa_ot3098
      avena_sativa_sang
      beta_vulgaris
      brachypodium_distachyon
      brassica_juncea
      brassica_napus
      brassica_oleracea
      brassica_rapa
      brassica_rapa_ro18
      brassica_rapa_z1
      cajanus_cajan
      capsicum_annuum
      camelina_sativa
      cannabis_sativa_female
      chara_braunii
      chenopodium_quinoa
      chlamydomonas_reinhardtii
      chondrus_crispus
      citrus_clementina
      citrullus_lanatus
      coffea_canephora
      corchorus_capsularis
      corylus_avellana
      corymbia_citriodora
      cucumis_melo
      cucumis_sativus
      cyanidioschyzon_merolae
      cynara_cardunculus
      daucus_carota
      dioscorea_rotundata
      digitaria_exilis
      echinochloa_crusgalli
      eragrostis_curvula
      eragrostis_tef
      eucalyptus_grandis
      eutrema_salsugineum
      ficus_carica
      fraxinus_excelsior
      galdieria_sulphuraria
      glycine_max
      glycine_soja
      gossypium_raimondii
      helianthus_annuus
      hordeum_vulgare
      hordeum_vulgare_10tj18
      hordeum_vulgare_aizu6
      hordeum_vulgare_akashinriki
      hordeum_vulgare_barke
      hordeum_vulgare_bonus
      hordeum_vulgare_bowman
      hordeum_vulgare_chikurinibaraki1
      hordeum_vulgare_foma
      hordeum_vulgare_ft11
      hordeum_vulgare_ft144
      hordeum_vulgare_ft262
      hordeum_vulgare_ft286
      hordeum_vulgare_ft333
      hordeum_vulgare_ft628
      hordeum_vulgare_ft67
      hordeum_vulgare_ft880
      hordeum_vulgare_goldenmelon
      hordeum_vulgare_goldenpromise
      hordeum_vulgare_hid055
      hordeum_vulgare_hid101
      hordeum_vulgare_hid249
      hordeum_vulgare_hid357
      hordeum_vulgare_hid380
      hordeum_vulgare_hockett
      hordeum_vulgare_hor10096
      hordeum_vulgare_hor10350
      hordeum_vulgare_hor10892
      hordeum_vulgare_hor1168
      hordeum_vulgare_hor12184
      hordeum_vulgare_hor12541
      hordeum_vulgare_hor13594
      hordeum_vulgare_hor13663
      hordeum_vulgare_hor13821
      hordeum_vulgare_hor13942
      hordeum_vulgare_hor14061
      hordeum_vulgare_hor14121
      hordeum_vulgare_hor14273
      hordeum_vulgare_hor1702
      hordeum_vulgare_hor18321
      hordeum_vulgare_hor19184
      hordeum_vulgare_hor21256
      hordeum_vulgare_hor21322
      hordeum_vulgare_hor21595
      hordeum_vulgare_hor21599
      hordeum_vulgare_hor2180
      hordeum_vulgare_hor2779
      hordeum_vulgare_hor2830
      hordeum_vulgare_hor3081
      hordeum_vulgare_hor3365
      hordeum_vulgare_hor3474
      hordeum_vulgare_hor4224
      hordeum_vulgare_hor495
      hordeum_vulgare_hor6220
      hordeum_vulgare_hor7172
      hordeum_vulgare_hor7385
      hordeum_vulgare_hor7552
      hordeum_vulgare_hor8117
      hordeum_vulgare_hor8148
      hordeum_vulgare_hor9043
      hordeum_vulgare_hor9972
      hordeum_vulgare_igri
      hordeum_vulgare_maximus
      hordeum_vulgare_oun333
      hordeum_vulgare_rgtplanet
      hordeum_vulgare_tritex
      hordeum_vulgare_wbdc078
      hordeum_vulgare_wbdc103
      hordeum_vulgare_wbdc133
      hordeum_vulgare_wbdc184
      hordeum_vulgare_wbdc199
      hordeum_vulgare_wbdc207
      hordeum_vulgare_wbdc237
      hordeum_vulgare_wbdc348
      hordeum_vulgare_wbdc349
      hordeum_vulgare_zdm01467
      hordeum_vulgare_zdm02064
      ipomoea_triloba
      juglans_regia
      kalanchoe_fedtschenkoi
      lactuca_sativa
      lathyrus_sativus
      leersia_perrieri
      lolium_perenne
      lupinus_angustifolius
      malus_domestica_golden
      manihot_esculenta
      marchantia_polymorpha
      medicago_truncatula
      musa_acuminata
      nicotiana_attenuata
      nymphaea_colorata
      olea_europaea
      olea_europaea_sylvestris
      oryza_barthii
      oryza_brachyantha
      oryza_glaberrima
      oryza_glumipatula
      oryza_indica
      oryza_longistaminata
      oryza_meridionalis
      oryza_nivara
      oryza_punctata
      oryza_rufipogon
      oryza_sativa
      oryza_sativa_arc
      oryza_sativa_azucena
      oryza_sativa_chaomeo
      oryza_sativa_gobolsailbalam
      oryza_sativa_ir64
      oryza_sativa_ketannangka
      oryza_sativa_khaoyaiguang
      oryza_sativa_larhamugad
      oryza_sativa_lima
      oryza_sativa_liuxu
      oryza_sativa_mh63
      oryza_sativa_n22
      oryza_sativa_natelboro
      oryza_sativa_pr106
      oryza_sativa_zs97
      ostreococcus_lucimarinus
      panicum_hallii_fil2
      panicum_hallii
      papaver_somniferum
      phaseolus_vulgaris
      physcomitrium_patens
      pistacia_vera
      pisum_sativum
      populus_trichocarpa
      prunus_avium
      prunus_dulcis
      prunus_persica
      quercus_lobata
      quercus_suber
      rosa_chinensis
      saccharum_spontaneum
      secale_cereale
      selaginella_moellendorffii
      sesamum_indicum
      setaria_italica
      setaria_viridis
      solanum_lycopersicum
      solanum_tuberosum
      solanum_tuberosum_rh8903916
      sorghum_bicolor
      sphenostylis_stenocarpa
      theobroma_cacao_criollo
      theobroma_cacao
      trifolium_pratense
      triticum_aestivum
      triticum_aestivum_alchemy
      triticum_aestivum_arinalrfor
      triticum_aestivum_cadenza
      triticum_aestivum_claire
      triticum_aestivum_jagger
      triticum_aestivum_julius
      triticum_aestivum_kariega
      triticum_aestivum_lancer
      triticum_aestivum_landmark
      triticum_aestivum_mace
      triticum_aestivum_mattis
      triticum_aestivum_norin61
      triticum_aestivum_paragon
      triticum_aestivum_refseqv2
      triticum_aestivum_renan
      triticum_aestivum_robigus
      triticum_aestivum_stanley
      triticum_aestivum_weebil
      triticum_dicoccoides
      triticum_spelta
      triticum_timopheevii
      triticum_turgidum 
      triticum_urartu
      vicia_faba
      vigna_angularis
      vigna_radiata
      vigna_unguiculata
      vitis_vinifera
      zea_mays
    avena_atlantica_gca910589765v1cm
    avena_byzantina_gca910574625v1cm
    avena_eriantha_gca910589775v1cm
    avena_insularis_gca910574615v1cm
    avena_longiglumis_gca910589755v1cm
    avena_occidentalis_gca947310975v1cm
    avena_sativa_gca947310255v1cm
    avena_sativa_gca947310285v1cm
    avena_sativa_gca947310875v1cm
    avena_sativa_gca947311085v1cm
    avena_sativa_gca947311135v1cm
    avena_sativa_gca947311155v1cm
    avena_sativa_gca947311165v1cm
    avena_sativa_gca947311225v1cm
    avena_sativa_gca947311235v1cm
    avena_sativa_gca947311295v1cm
    avena_sativa_gca947311345v1cm
    avena_sativa_gca947311355v1cm
    avena_sativa_gca947311365v1cm
    avena_sativa_gca947311525v1cm
    avena_sativa_gca947311555v1cm
    avena_sativa_gca947311775v1cm
    avena_sativa_gca947311915v1cm
    avena_sativa_gca947311925v1cm
    avena_sativa_gca947312425v1cm
    avena_sativa_gca951802345v1cm
    avena_sativa_gca951802355v1cm
    avena_sativa_gca951802365v1cm
    avena_sterilis_gca947313225v1cm
    avena_sterilis_gca947313515v1cm
    lablab_purpureus_gca030347555v1cm
    pisum_sativum_gca024323335v2gb
    pisum_sativum_gca964186695v1gb
    )];

    push @SiteDefs::ENSEMBL_HTDOCS_DIRS, $SiteDefs::ENSEMBL_SERVERROOT. '/../biomarts/plants/biomart-perl/htdocs';
      
    $SiteDefs::DOCSEARCH_INDEX_DIR = $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-plants/data/docsearch';

    $SiteDefs::ENA_COLLECTION_ID = 224;

    $SiteDefs::ENA_SAMPLE_SEQ = "MDDCRFETSELQASVMISTPLFTDSWSSCNTANCNGSIKIHDIAGITYVAIPAVSMIQLGNLVGLPVTGDVLFPGLSSDEPLPMVDAAILKLFLQLKIKEGLELELLGKKLVVITGHSTGGALAAFTALWLLSQSSPPSFRVFCITFGSPLLGNQSLSTSISRSRLAHNFCHVVSIHDLVPRSSNEQFWPFGTYLFCSDKGGVCLDNAGSVRLMFNILNTTATQNTEEHQRYGHYVFTLSHMFLKSRSFLGGSIPDNSYQAGVALAVEALGFSNDDTSGVLVKECIETATRIVRAPILRSAELANELASVLPARLEIQWYKDRCDASEEQLGYYDFFKRYSLKRDFKVNMSRIRLAKFWDTVIKMVETNELPFDFHLGKKWIYASQFYQLLAEPLDIANFYKNRDIKTGGHYLEGNRPKRYEVIDKWQKGVKVPEECVRSRYASTTQDTCFWAKLEQAKEWLDEARKESSDPQRRSLLREKIVPFESYANTLVTKKEVSLDVKAKNSSYSVWEANLKEFKCKMGYENEIEMVVDESDAMET";

    $SiteDefs::GXA = 1;

    $SiteDefs::ENSEMBL_HMMER_ENABLED  = 1;

    $SiteDefs::REACTOME_URL = 'https://plantreactome.gramene.org';
    $SiteDefs::REACTOME_JS_LIBRARY = 'https://plantreactome.gramene.org/DiagramJs/diagram/diagram.nocache.js';

    $SiteDefs::Pathway = 1;

}

1;
