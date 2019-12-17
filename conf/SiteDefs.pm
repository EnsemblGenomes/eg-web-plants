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

    $SiteDefs::ENSEMBL_PRIMARY_SPECIES   = 'Oryza_sativa';
    $SiteDefs::ENSEMBL_SECONDARY_SPECIES = 'Arabidopsis_thaliana';

    $SiteDefs::ENSEMBL_BASE_URL          = 'http://plants.ensembl.org';
    # TODO dedup these if equivalent
    $SiteDefs::DIVISION         = 'plants';
    $SiteDefs::EG_DIVISION      = 'plants';
    $SiteDefs::SUBDOMAIN_DIR    = 'plants';
    $SiteDefs::ENSEMBL_SITETYPE = 'Ensembl Plants';
    $SiteDefs::SITE_NAME        = 'Ensembl Plants';
    $SiteDefs::SITE_FTP         = 'ftp://ftp.ensemblgenomes.org/pub/plants';

    @SiteDefs::ENSEMBL_PERL_DIRS =
      ( $SiteDefs::ENSEMBL_WEBROOT.'/perl',
        $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-common/perl',
        $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-plants/perl',
      );

    $SiteDefs::PRODUCTION_NAMES = [sort qw(
      actinidia_chinensis
      arabidopsis_halleri
      arabidopsis_lyrata
      arabidopsis_thaliana
      aegilops_tauschii
      amborella_trichopoda
      beta_vulgaris
      brachypodium_distachyon
      brassica_napus
      brassica_oleracea
      brassica_rapa
      capsicum_annuum
      chlamydomonas_reinhardtii
      chondrus_crispus
      citrus_clementina
      coffea_canephora
      corchorus_capsularis
      cucumis_sativus
      cyanidioschyzon_merolae
      cynara_cardunculus
      daucus_carota
      dioscorea_rotundata
      eragrostis_tef
      galdieria_sulphuraria
      glycine_max
      gossypium_raimondii
      helianthus_annuus
      hordeum_vulgare
      ipomoea_triloba
      leersia_perrieri
      lupinus_angustifolius
      manihot_esculenta
      marchantia_polymorpha
      medicago_truncatula
      musa_acuminata
      nicotiana_attenuata
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
      ostreococcus_lucimarinus
      panicum_hallii_fil2
      panicum_hallii_hal2
      phaseolus_vulgaris
      physcomitrella_patens
      populus_trichocarpa
      prunus_avium
      prunus_persica
      saccharum_spontaneum
      selaginella_moellendorffii
      setaria_italica
      solanum_lycopersicum
      solanum_tuberosum
      sorghum_bicolor
      theobroma_cacao
      trifolium_pratense
      triticum_aestivum
      triticum_dicoccoides
      triticum_turgidum 
      triticum_urartu
      vigna_angularis
      vigna_radiata
      vitis_vinifera
      zea_mays
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
