/*
Name: descripitives.do
Aim: compute some statititics
date: 28 sept
input :basecell_distance27sept
*/

///////////// Desciptives basecell///////////////////////////////////////////////////

clear all
cd "/Users/williamewane/Desktop/dossierbase"

*use  basecell_distance27sept
use  baseremoveoutlier
//// Descriptives statistics for seller 1

drop if price_origin1==.  // keep if the origin price exist
count

g pricegap1= price_dest1-price_origin1

tabstat dist_orign1 distmarket_kigali  price_origin1 price_dest1 pricegap, stat( mean sd N)


//// Descriptives statistics for seller 2

clear all
cd "/Users/williamewane/Desktop/dossierbase"

*use  basecell_distance27sept
 use baseremoveoutlier
drop if price_origin2==.  // keep if the origin price exist
count

g pricegap2= price_dest2-price_origin2

tabstat dist_orign2 distmarket_kigali  price_origin2 price_dest2 pricegap2,stat( mean sd N)


//////////// Desciptives basedistrict///////////////////////////////////////////////////

clear all
cd "/Users/williamewane/Desktop/dossierbase"

*use  basedistrict_distance27sept

//// Descriptives statistics for seller 1

drop if price_origin1==.  // keep if the origin price exist
count

g pricegap1= price_dest1-price_origin1

tabstat dist_orign1 distmarket_kigali  price_origin1 price_dest1 pricegap, stat( mean sd N)


//// Descriptives statistics for seller 2

clear all
cd "/Users/williamewane/Desktop/dossierbase"

use  basedistrict_distance27sept

drop if price_origin2==.  // keep if the origin price exist
count

g pricegap2= price_dest2-price_origin2

tabstat dist_orign2 distmarket_kigali  price_origin2 price_dest2 pricegap2,stat( mean sd N)

///list of products (mean / sd)


bys product: tabstat price_origin1 price_dest1  price_origin2  price_dest2 pricegap  pricegap2, stat (mean, sd)
