*******found other district source and outside rwanda source*******

clear all
cd "/Users/williamewane/Desktop/Rwanda"
use 2016_market_listing_raw 
keep market_name product_sourcetwo product_source_other district_source country_source country_source_other
gen source = string(product_sourcetwo)
keep if (source== "6" | source== "7")
save  foundsource, replace

