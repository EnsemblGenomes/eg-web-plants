Ensembl.LayoutManager = Ensembl.LayoutManager.extend({
  
  externalDbUrls: function () {
    var superUrls = this.base();
    var myUrls = {
      "Arabidopsis_lyrata" : {
        "Phytozome" : "http://www.phytozome.net/cgi-bin/gbrowse/lyrata/?name=scaffold_###CHR###%3A###START###..###END###"
      },
      "Arabidopsis_thaliana" : {
        "TAIR" : "http://gbrowse.arabidopsis.org/cgi-bin/gbrowse/arabidopsis/?name=chr###CHR###%3A###START###..###END###",
        "Phytozome" : "http://www.phytozome.net/cgi-bin/gbrowse/arabi/?name=chr###CHR###%3A###START###..###END###"
      },
      "Oryza_sativa" : {
        "Phytozome" : "http://www.phytozome.net/cgi-bin/gbrowse/rice/?name=Chr###CHR###%3A###START###..###END###"
      },
      "Physcomitrella_patens" : {
        "Phytozome": "http://www.phytozome.net/cgi-bin/gbrowse/physcomitrella/?name=chr###CHR###%3A###START###..###END###"
      },
      "Populus_trichocarpa" : {
        "Phytozome": "http://www.phytozome.net/cgi-bin/gbrowse/poplar/?name=scaffold_###CHR###%3A###START###..###END###"
      },
      "Sorghum_bicolor" : {
        "Phytozome": "http://www.phytozome.net/cgi-bin/gbrowse/sorghum/?name=chromosome_###CHR###%3A###START###..###END###"
      },
      "Vitis_vinifera" : {
        "Phytozome": "http://www.phytozome.net/cgi-bin/gbrowse/grape/?name=chr###CHR###%3A###START###..###END###"
      },
      "Zea_mays" : {
        "Phytozome": "http://www.phytozome.net/cgi-bin/gbrowse/maize/?name=chr###CHR###%3A###START###..###END###"
      }
    };
    var merged = $.extend(superUrls, myUrls);
    return merged;
  }
  
});
