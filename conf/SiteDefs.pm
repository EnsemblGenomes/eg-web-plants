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
      arabidopsis_lyrata
      arabidopsis_thaliana
      aegilops_tauschii
      amborella_trichopoda
      brachypodium_distachyon
      brassica_rapa
      chlamydomonas_reinhardtii
      chondrus_crispus
      corchorus_capsularis
      cyanidioschyzon_merolae
      galdieria_sulphuraria
      glycine_max
      hordeum_vulgare
      medicago_truncatula
      musa_acuminata
      oryza_brachyantha
      oryza_glaberrima
      oryza_indica
      oryza_sativa
      oryza_barthii
      oryza_glumaepatula
      oryza_meridionalis
      oryza_nivara
      oryza_punctata
      oryza_longistaminata
      physcomitrella_patens
      populus_trichocarpa
      prunus_persica
      selaginella_moellendorffii
      setaria_italica
      solanum_lycopersicum
      solanum_tuberosum
      sorghum_bicolor
      triticum_aestivum
      triticum_urartu
      vitis_vinifera
      zea_mays
      ostreococcus_lucimarinus
      brassica_oleracea
      oryza_rufipogon
      leersia_perrieri
      theobroma_cacao
      beta_vulgaris
      trifolium_pratense
      brassica_napus
      cucumis_sativus
      dioscorea_rotundata
      gossypium_raimondii
      helianthus_annuus
      lupinus_angustifolius
      manihot_esculenta
      nicotiana_attenuata
      phaseolus_vulgaris
    )];

    push @SiteDefs::ENSEMBL_HTDOCS_DIRS, $SiteDefs::ENSEMBL_SERVERROOT. '/../biomarts/plants/biomart-perl/htdocs';
      
    $SiteDefs::DOCSEARCH_INDEX_DIR = $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-plants/data/docsearch';

    $SiteDefs::ENA_COLLECTION_ID = 224;

    $SiteDefs::ENA_SAMPLE_SEQ = "MDDCRFETSELQASVMISTPLFTDSWSSCNTANCNGSIKIHDIAGITYVAIPAVSMIQLGNLVGLPVTGDVLFPGLSSDEPLPMVDAAILKLFLQLKIKEGLELELLGKKLVVITGHSTGGALAAFTALWLLSQSSPPSFRVFCITFGSPLLGNQSLSTSISRSRLAHNFCHVVSIHDLVPRSSNEQFWPFGTYLFCSDKGGVCLDNAGSVRLMFNILNTTATQNTEEHQRYGHYVFTLSHMFLKSRSFLGGSIPDNSYQAGVALAVEALGFSNDDTSGVLVKECIETATRIVRAPILRSAELANELASVLPARLEIQWYKDRCDASEEQLGYYDFFKRYSLKRDFKVNMSRIRLAKFWDTVIKMVETNELPFDFHLGKKWIYASQFYQLLAEPLDIANFYKNRDIKTGGHYLEGNRPKRYEVIDKWQKGVKVPEECVRSRYASTTQDTCFWAKLEQAKEWLDEARKESSDPQRRSLLREKIVPFESYANTLVTKKEVSLDVKAKNSSYSVWEANLKEFKCKMGYENEIEMVVDESDAMET";

    $SiteDefs::GXA = 1;

    $SiteDefs::ENSEMBL_HMMER_ENABLED  = 1;
}

1;
