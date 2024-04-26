=head1 LICENSE

Copyright [2009-2024] EMBL-European Bioinformatics Institute

Licensed under the Apache License,  Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,  software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,  either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut

package EnsEMBL::Web::ConfigPacker;
use strict;
use warnings;


sub _alignment_mlss_is_suppressed {
    my ($self, $mlss_id) = @_;
    # Suppress Wheat Cactus multiple and pairwise alignment MLSSes.
    return $mlss_id >= 313160 && $mlss_id <= 313280 ? 1 : 0;
}

1;
