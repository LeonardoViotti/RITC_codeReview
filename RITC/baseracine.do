/*
Name: baseracine.do
Date: 27 sept 2018
Aim : Build a dataset with all products and prices
Input:
-Price18.dta (raw price database from DIME)
*/


*cd "C:\Users\wb535383\Desktop\construction_database_rwanda\output" // Wbank computer

cd "/Users/williamewane/Dropbox/IntraTradeCost_Rwanda/Data/construction_database_rwanda" //William Computer

clear all
use Price18.dta


**************************************************************************************************************************
                                        *STEP1 : PRICE DATA BY PRODUCT 
**************************************************************************************************************************

********************product:Goat**********************************
keep  market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time goat_q10_available goat_q14_price_1 goat_q20_source_1 goat_q14_price_2 goat_q20_source_2 goat_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="Goat" if product=="."
drop nproduct

*****manage source
gen origin1 = string( goat_q20_source_1)
drop goat_q20_source_1
gen origin2 = string( goat_q20_source_2)
drop goat_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename goat_q14_price_1 price1
 rename goat_q14_price_2 price2
 rename goat_q10_available availability
 rename goat_avg_price avg_price
 order product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save goat,replace
 


********************product:Rabbit**********************************
clear all
use Price18.dta
keep  market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time rabbit_q10_available rabbit_q14_price_1 rabbit_q20_source_1 rabbit_q14_price_2 rabbit_q20_source_2 rabbit_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="Rabbit" if product=="."
drop nproduct

*****manage source
gen origin1 = string( rabbit_q20_source_1)
drop rabbit_q20_source_1
gen origin2 = string( rabbit_q20_source_2)
drop rabbit_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 
 ***save goat
 rename rabbit_q14_price_1 price1
 rename rabbit_q14_price_2 price2
 rename rabbit_q10_available availability
 rename rabbit_avg_price avg_price 
 order product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save rabbit,replace
 


********************product:whole_chicken**********************************
clear all
use Price18.dta
keep  market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time whole_chicken_q10_available whole_chicken_q14_price_1 whole_chicken_q20_source_1 whole_chicken_q14_price_2 whole_chicken_q20_source_2 whole_chicken_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="whole_chicken" if product=="."
drop nproduct

*****manage source
gen origin1 = string(whole_chicken_q20_source_1)
drop whole_chicken_q20_source_1
gen origin2 = string(whole_chicken_q20_source_2)
drop whole_chicken_q20_source_2

 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename whole_chicken_q14_price_1 price1
 rename whole_chicken_q14_price_2 price2
 rename whole_chicken_q10_available availability
 rename whole_chicken_avg_price  avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save whole_chicken ,replace
 

 
 
 
 
 

 
 ********************product:beef**********************************
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time beef_q10_available beef_q14_price_1 beef_q20_source_1 beef_q14_price_2 beef_q20_source_2 beef_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="beef" if product=="."
drop nproduct

*****manage source
gen origin1 = string(beef_q20_source_1)
drop beef_q20_source_1
gen origin2 = string(beef_q20_source_2)
drop beef_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
 rename beef_q14_price_1 price1
 rename beef_q14_price_2 price2
 rename beef_q10_available availability
 rename beef_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save beef ,replace
 
 
 
********************product:amarante**********************************
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time amarante_q10_available amarante_q14_price_1 amarante_q20_source_1 amarante_q14_price_2 amarante_q20_source_2 amarante_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="amarante" if product=="."
drop nproduct

*****manage source
gen origin1 = string(amarante_q20_source_1)
drop amarante_q20_source_1
gen origin2 = string(amarante_q20_source_2)
drop amarante_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
 rename amarante_q14_price_1 price1
 rename amarante_q14_price_2 price2
 rename amarante_q10_available availability
 rename amarante_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save amarante ,replace
 
 
 
 
 
 
 
 ********************product:cabbage**********************************
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time cabbage_q10_available cabbage_q14_price_1 cabbage_q20_source_1 cabbage_q14_price_2 cabbage_q20_source_2 cabbage_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="cabbage" if product=="."
drop nproduct

*****manage source
gen origin1 = string(cabbage_q20_source_1)
drop cabbage_q20_source_1
gen origin2 = string(cabbage_q20_source_2)
drop cabbage_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source

 ***save goat
 rename cabbage_q14_price_1 price1
 rename cabbage_q14_price_2 price2
 rename cabbage_q10_available availability
  rename cabbage_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save cabbage ,replace
 
 
 
 
 
 ********************product:carrot**********************************
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time carrots_q10_available carrots_q14_price_1 carrots_q20_source_1 carrots_q14_price_2 carrots_q20_source_2 carrots_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="carrots" if product=="."
drop nproduct

*****manage source
gen origin1 = string(carrots_q20_source_1)
drop carrots_q20_source_1
gen origin2 = string(carrots_q20_source_2)
drop carrots_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 ***save goat
 rename carrots_q14_price_1 price1
 rename carrots_q14_price_2 price2
 rename carrots_q10_available availability
  rename carrots_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 
 save carrots,replace
 
 
 
 
 
 
 
 ********************product:cassava_leaves**********************************
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time cassava_leaves_q10_available cassava_leaves_q14_price_1 cassava_leaves_q20_source_1 cassava_leaves_q14_price_2 cassava_leaves_q20_source_2 cassava_leaves_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="cassava_leaves" if product=="."
drop nproduct

*****manage source
gen origin1 = string(cassava_leaves_q20_source_1)
drop cassava_leaves_q20_source_1
gen origin2 = string(cassava_leaves_q20_source_2)
drop cassava_leaves_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename cassava_leaves_q14_price_1 price1
 rename cassava_leaves_q14_price_2 price2
 rename cassava_leaves_q10_available availability
  rename cassava_leaves_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save cassava_leaves ,replace
 
 
 
  ********************product:celery**********************************
 
 clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  celery_q10_available  celery_q14_price_1 celery_q20_source_1 celery_q14_price_2 celery_q20_source_2 celery_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="celery" if product=="."
drop nproduct

*****manage source
gen origin1 = string(celery_q20_source_1)
drop  celery_q20_source_1
gen origin2 = string( celery_q20_source_2)
drop celery_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 *replace origin1="Kigali" if origin1=="4"
 *replace origin2="Kigali" if origin2=="4"
 ***save goat
 rename  celery_q14_price_1 price1
 rename  celery_q14_price_2 price2
 rename  celery_q10_available availability
  rename celery_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save   celery ,replace
 
 
 
 
 
 
  ********************product:garlic**********************************
 
 clear all
use Price18.dta
keep  market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  garlic_q10_available  garlic_q14_price_1 garlic_q20_source_1 garlic_q14_price_2 garlic_q20_source_2 garlic_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="garlic" if product=="."
drop nproduct

*****manage source
gen origin1 = string(garlic_q20_source_1)
drop  garlic_q20_source_1
gen origin2 = string(garlic_q20_source_2)
drop garlic_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
 ***save goat
 rename  garlic_q14_price_1 price1
 rename  garlic_q14_price_2 price2
 rename  garlic_q10_available availability
  rename garlic_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save  garlic ,replace
 
 
 
 
 
 
 ********************product:leek**********************************
 
 
 clear all
use Price18.dta
keep  market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  leek_q10_available  leek_q14_price_1 leek_q20_source_1 leek_q14_price_2 leek_q20_source_2 leek_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="leek" if product=="."
drop nproduct

*****manage source
gen origin1 = string(leek_q20_source_1)
drop  leek_q20_source_1
gen origin2 = string(leek_q20_source_2)
drop leek_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 *replace origin1="Kigali" if origin1=="4"
 *replace origin2="Kigali" if origin2=="4"
 ***save goat
 rename  leek_q14_price_1 price1
 rename  leek_q14_price_2 price2
 rename  leek_q10_available availability
 rename  leek_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save  leek ,replace
 
 
 
 
 
 
 
 
 
 ********************product:onion**********************************
 
 
 clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  onion_q10_available  onion_q14_price_1 onion_q20_source_1 onion_q14_price_2 onion_q20_source_2 onion_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="onion" if product=="."
drop nproduct

*****manage source
gen origin1 = string(onion_q20_source_1)
drop  onion_q20_source_1
gen origin2 = string(onion_q20_source_2)
drop onion_q20_source_2

********unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 
 ***save goat
 rename  onion_q14_price_1 price1
 rename  onion_q14_price_2 price2
 rename  onion_q10_available availability
 rename onion_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save onion ,replace
 
 
 
 
 
  ********************product:pepper**********************************
 
 
 
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  pepper_q10_available  pepper_q14_price_1 pepper_q20_source_1 pepper_q14_price_2 pepper_q20_source_2 pepper_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="pepper" if product=="."
drop nproduct

*****manage source
gen origin1 = string(pepper_q20_source_1)
drop  pepper_q20_source_1
gen origin2 = string(pepper_q20_source_2)
drop pepper_q20_source_2

********unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"

 ***save goat
 rename  pepper_q14_price_1 price1
 rename  pepper_q14_price_2 price2
 rename  pepper_q10_available availability
 rename  pepper_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save pepper ,replace
 
 
 
 
  ********************product:string_bean**********************************
 
 
 
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  string_bean_q10_available  string_bean_q14_price_1 string_bean_q20_source_1 string_bean_q14_price_2 string_bean_q20_source_2 string_bean_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="string_bean" if product=="."
drop nproduct

*****manage source
gen origin1 = string(string_bean_q20_source_1)
drop  string_bean_q20_source_1
gen origin2 = string(string_bean_q20_source_2)
drop string_bean_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename string_bean_q14_price_1 price1
 rename  string_bean_q14_price_2 price2
 rename  string_bean_q10_available availability
 rename string_bean_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save string_bean ,replace
 
 
 
 
 
  ********************product:tomato**********************************
 
 
 
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  tomato_q10_available tomato_q14_price_1 tomato_q20_source_1 tomato_q14_price_2 tomato_q20_source_2 tomato_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="tomato" if product=="."
drop nproduct

*****manage source
gen origin1 = string(tomato_q20_source_1)
drop tomato_q20_source_1
gen origin2 = string(tomato_q20_source_2)
drop tomato_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename tomato_q14_price_1 price1
 rename  tomato_q14_price_2 price2
 rename  tomato_q10_available availability
  rename tomato_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save tomato ,replace
 
 
 
   ********************product:maggi**********************************
 
 
 
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  maggi_q10_available maggi_q14_price_1 maggi_q20_source_1 maggi_q14_price_2 maggi_q20_source_2 

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="maggi" if product=="."
drop nproduct

*****manage source
gen origin1 = string(maggi_q20_source_1)
drop maggi_q20_source_1
gen origin2 = string(maggi_q20_source_2)
drop maggi_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename maggi_q14_price_1 price1
 rename  maggi_q14_price_2 price2
 rename  maggi_q10_available availability
 gen maggi_avg_price= (price1 + price2)/2
  rename maggi_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save maggi ,replace
 
 
 
 
 
 
 
 
 
 
 
  ********************product:sandals**********************************
 
 
 
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  sandals_q10_available sandals_q14_price_1 sandals_q20_source_1 sandals_q14_price_2 sandals_q20_source_2 sandals_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="sandals" if product=="."
drop nproduct

*****manage source
gen origin1 = string(sandals_q20_source_1)
drop sandals_q20_source_1
gen origin2 = string(sandals_q20_source_2)
drop sandals_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename sandals_q14_price_1 price1
 rename sandals_q14_price_2 price2
 rename sandals_q10_available availability
  rename sandals_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  sandals,replace
 
 
 
 
 
 
 
  ********************product:tshirt**********************************
 
 
 
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  tshirt_q10_available tshirt_q14_price_1 tshirt_q20_source_1 tshirt_q14_price_2 tshirt_q20_source_2 tshirt_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="tshirt" if product=="."
drop nproduct

*****manage source
gen origin1 = string(tshirt_q20_source_1)
drop tshirt_q20_source_1
gen origin2 = string(tshirt_q20_source_2)
drop tshirt_q20_source_2
replace origin1="." if origin1=="-7"
replace origin2="." if origin2=="-7"
 rename tshirt_q14_price_1 price1
 rename tshirt_q14_price_2 price2
 rename tshirt_q10_available availability
 rename tshirt_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save tshirt,replace
 
 
 
 
 
 
 
 
 
 
 
  ********************product:panta_male**********************************
 
 
 
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  pants_male_q10_available pants_male_q14_price_1 pants_male_q20_source_1 pants_male_q14_price_2 pants_male_q20_source_2 pants_male_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="pants_male" if product=="."
drop nproduct

*****manage source
gen origin1 = string(pants_male_q20_source_1)
drop pants_male_q20_source_1
gen origin2 = string(pants_male_q20_source_2)
drop pants_male_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename pants_male_q14_price_1 price1
 rename pants_male_q14_price_2 price2
 rename pants_male_q10_available availability
 rename  pants_male_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save pants_male,replace
 
 

 
   ********************product:pants_female**********************************
 
 
 
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  pants_female_q10_available pants_female_q14_price_1 pants_female_q20_source_1 pants_female_q14_price_2 pants_female_q20_source_2 pants_female_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="pants_female" if product=="."
drop nproduct

*****manage source
gen origin1 = string(pants_female_q20_source_1)
drop pants_female_q20_source_1
gen origin2 = string(pants_female_q20_source_2)
drop pants_female_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename pants_female_q14_price_1 price1
 rename pants_female_q14_price_2 price2
 rename pants_female_q10_available availability
 rename pants_female_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save pants_female,replace
 
 
 
 
 
 ********************product:gitenge**********************************
 
 
 clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  gitenge_q10_available gitenge_q14_price_1 gitenge_q20_source_1 gitenge_q14_price_2 gitenge_q20_source_2 gitenge_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="gitenge" if product=="."
drop nproduct

*****manage source
gen origin1 = string(gitenge_q20_source_1)
drop gitenge_q20_source_1
gen origin2 = string(gitenge_q20_source_2)
drop gitenge_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename gitenge_q14_price_1 price1
 rename gitenge_q14_price_2 price2
 rename gitenge_q10_available availability
 rename gitenge_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save gitenge,replace
 
 
 
 
 
 
 
 
 
 ********************product:echarpe**********************************
 
 
 clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  echarpe_q10_available echarpe_q14_price_1 echarpe_q20_source_1 echarpe_q14_price_2 echarpe_q20_source_2 echarpe_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="echarpe" if product=="."
drop nproduct

*****manage source
gen origin1 = string(echarpe_q20_source_1)
drop echarpe_q20_source_1
gen origin2 = string(echarpe_q20_source_2)
drop echarpe_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename echarpe_q14_price_1 price1
 rename echarpe_q14_price_2 price2
 rename echarpe_q10_available availability
 rename echarpe_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save echarpe,replace
 
 
 
 
 
 ********************product:dress**********************************
 
 
 clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  dress_q10_available dress_q14_price_1 dress_q20_source_1 dress_q14_price_2 dress_q20_source_2 dress_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="dress" if product=="."
drop nproduct

*****manage source
gen origin1 = string(dress_q20_source_1)
drop dress_q20_source_1
gen origin2 = string(dress_q20_source_2)
drop dress_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename dress_q14_price_1 price1
 rename dress_q14_price_2 price2
 rename dress_q10_available availability
  rename dress_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price

 save dress,replace
 
 
  ********************product:toilte_paper**********************************
 
 
 clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  toilet_paper_q10_available toilet_paper_q14_price_1 toilet_paper_q20_source_1 toilet_paper_q14_price_2 toilet_paper_q20_source_2 toilet_paper_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="toilet_paper" if product=="."
drop nproduct

*****manage source
gen origin1 = string(toilet_paper_q20_source_1)
drop toilet_paper_q20_source_1
gen origin2 = string(toilet_paper_q20_source_2)
drop toilet_paper_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename toilet_paper_q14_price_1 price1
 rename toilet_paper_q14_price_2 price2
 rename toilet_paper_q10_available availability
 rename toilet_paper_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save toilet_paper,replace
 
 
 
 
 ********************product:sanitary_napkin**********************************
 
 
 
  clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  sanitary_napkin_q10_available sanitary_napkin_q14_price_1 sanitary_napkin_q20_source_1 sanitary_napkin_q14_price_2 sanitary_napkin_q20_source_2 sanitary_napkin_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="sanitary_napkin" if product=="."
drop nproduct

*****manage source
gen origin1 = string(sanitary_napkin_q20_source_1)
drop sanitary_napkin_q20_source_1
gen origin2 = string(sanitary_napkin_q20_source_2)
drop sanitary_napkin_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
 ***save goat
 rename sanitary_napkin_q14_price_1 price1
 rename sanitary_napkin_q14_price_2 price2
 rename sanitary_napkin_q10_available availability
 rename sanitary_napkin_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save sanitary_napkin,replace
 
 
  
 ********************product:mattress**********************************
 
 
 
  clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  mattress_q10_available mattress_q14_price_1 mattress_q20_source_1 mattress_q14_price_2 mattress_q20_source_2 mattress_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="mattress" if product=="."
drop nproduct

*****manage source
gen origin1 = string(mattress_q20_source_1)
drop mattress_q20_source_1
gen origin2 = string(mattress_q20_source_2)
drop mattress_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename mattress_q14_price_1 price1
 rename mattress_q14_price_2 price2
 rename mattress_q10_available availability
 rename mattress_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save mattress,replace
 
 
 
   
 ********************product:candle**********************************
 
 
 
  clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  candle_q10_available candle_q14_price_1 candle_q20_source_1 candle_q14_price_2 candle_q20_source_2 candle_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="candle" if product=="."
drop nproduct

*****manage source
gen origin1 = string(candle_q20_source_1)
drop candle_q20_source_1
gen origin2 = string(candle_q20_source_2)
drop candle_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename candle_q14_price_1 price1
 rename candle_q14_price_2 price2
 rename candle_q10_available availability
 rename candle_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save candle,replace
 

    
 ********************product:suitcase**********************************
 
  clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time  suitcase_q10_available suitcase_q14_price_1 suitcase_q20_source_1 suitcase_q14_price_2 suitcase_q20_source_2 suitcase_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="suitcase" if product=="."
drop nproduct

*****manage source
gen origin1 = string(suitcase_q20_source_1)
drop suitcase_q20_source_1
gen origin2 = string(suitcase_q20_source_2)
drop suitcase_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename suitcase_q14_price_1 price1
 rename suitcase_q14_price_2 price2
 rename suitcase_q10_available availability
 rename suitcase_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save suitcase ,replace
 
 
 ********************product:airtime**********************************
 
 
   clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time airtime_q10_available airtime_q14_price_1 airtime_q20_source_1 airtime_q14_price_2 airtime_q20_source_2 airtime_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="airtime" if product=="."
drop nproduct

*****manage source
gen origin1 = string(airtime_q20_source_1)
drop airtime_q20_source_1
gen origin2 = string(airtime_q20_source_2)
drop airtime_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename airtime_q14_price_1 price1
 rename airtime_q14_price_2 price2
 rename airtime_q10_available availability
  rename airtime_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save airtime ,replace
 

 
  
 ********************product:egg**********************************
 
 
   clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time egg_q10_available egg_q14_price_1 egg_q20_source_1 egg_q14_price_2 egg_q20_source_2 egg_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="egg" if product=="."
drop nproduct

*****manage source
gen origin1 = string(egg_q20_source_1)
drop egg_q20_source_1
gen origin2 = string(egg_q20_source_2)
drop egg_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename egg_q14_price_1 price1
 rename egg_q14_price_2 price2
 rename egg_q10_available availability
 rename egg_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save egg ,replace
 

 ********************product:brochette**********************************
 
 
   clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time brochette_q10_available  brochette_q14_price_1  brochette_q20_source_1  brochette_q14_price_2  brochette_q20_source_2 brochette_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="brochette" if product=="."
drop nproduct

*****manage source
gen origin1 = string( brochette_q20_source_1)
drop  brochette_q20_source_1
gen origin2 = string( brochette_q20_source_2)
drop  brochette_q20_source_2
********unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename  brochette_q14_price_1 price1
 rename  brochette_q14_price_2 price2
 rename  brochette_q10_available availability
  rename brochette_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  brochette ,replace
 

 ********************product:mineral_water**********************************
 
 
   clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time mineral_water_q10_available mineral_water_q14_price_1  mineral_water_q20_source_1 mineral_water_q14_price_2  mineral_water_q20_source_2 mineral_water_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="mineral_water" if product=="."
drop nproduct

*****manage source
gen origin1 = string( mineral_water_q20_source_1)
drop  mineral_water_q20_source_1
gen origin2 = string( mineral_water_q20_source_2)
drop  mineral_water_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename mineral_water_q14_price_1 price1
 rename mineral_water_q14_price_2 price2
 rename  mineral_water_q10_available availability
 rename mineral_water_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  mineral_water ,replace
 

     
 ********************product:softdrink**********************************
 
 
   clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time softdrink_q10_available softdrink_q14_price_1  softdrink_q20_source_1 softdrink_q14_price_2  softdrink_q20_source_2 softdrink_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="softdrink" if product=="."
drop nproduct

*****manage source
gen origin1 = string(softdrink_q20_source_1)
drop softdrink_q20_source_1
gen origin2 = string( softdrink_q20_source_2)
drop softdrink_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename softdrink_q14_price_1 price1
 rename softdrink_q14_price_2 price2
 rename  softdrink_q10_available availability
  rename softdrink_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save  softdrink ,replace
      
 ********************product:comm_beer**********************************
 
 
   clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time comm_beer_q10_available comm_beer_q14_price_1  comm_beer_q20_source_1 comm_beer_q14_price_2  comm_beer_q20_source_2 comm_beer_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="comm_beer" if product=="."
drop nproduct

*****manage source
gen origin1 = string(comm_beer_q20_source_1)
drop comm_beer_q20_source_1
gen origin2 = string( comm_beer_q20_source_2)
drop comm_beer_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename comm_beer_q14_price_1 price1
 rename comm_beer_q14_price_2 price2
 rename comm_beer_q10_available availability
 rename comm_beer_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save  comm_beer ,replace
 
   
 ********************product:milk**********************************
 
 
   clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time milk_q10_available milk_q14_price_1  milk_q20_source_1 milk_q14_price_2  milk_q20_source_2 milk_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="milk" if product=="."
drop nproduct

*****manage source
gen origin1 = string(milk_q20_source_1)
drop milk_q20_source_1
gen origin2 = string(milk_q20_source_2)
drop milk_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename milk_q14_price_1 price1
 rename milk_q14_price_2 price2
 rename milk_q10_available availability
  rename milk_avg_price avg_price
 
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save  milk ,replace
 

 
 
  ********************product:shampoo**********************************
 
   
   clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time shampoo_q10_available shampoo_q14_price_1  shampoo_q20_source_1 shampoo_q14_price_2  shampoo_q20_source_2 shampoo_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="shampoo" if product=="."
drop nproduct

*****manage source
gen origin1 = string(shampoo_q20_source_1)
drop shampoo_q20_source_1
gen origin2 = string(shampoo_q20_source_2)
drop shampoo_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename shampoo_q14_price_1 price1
 rename shampoo_q14_price_2 price2
 rename shampoo_q10_available availability
  rename shampoo_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save  shampoo ,replace
 

 
 
  ********************product:cook_oil**********************************
 
 
 
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time cook_oil_q10_available cook_oil_q14_price_1  cook_oil_q20_source_1 cook_oil_q14_price_2  cook_oil_q20_source_2 cook_oil_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="cook_oil" if product=="."
drop nproduct

*****manage source
gen origin1 = string(cook_oil_q20_source_1)
drop cook_oil_q20_source_1
gen origin2 = string(cook_oil_q20_source_2)
drop cook_oil_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename cook_oil_q14_price_1 price1
 rename cook_oil_q14_price_2 price2
 rename cook_oil_q10_available availability
  rename cook_oil_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price

 save  cook_oil ,replace
 
 
 
 
  ********************product:nails**********************************
 
 
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time nails_q10_available nails_q14_price_1  nails_q20_source_1 nails_q14_price_2  nails_q20_source_2 nails_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="nails" if product=="."
drop nproduct

*****manage source
gen origin1 = string(nails_q20_source_1)
drop nails_q20_source_1
gen origin2 = string(nails_q20_source_2)
drop nails_q20_source_2
********unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename nails_q14_price_1 price1
 rename nails_q14_price_2 price2
 rename nails_q10_available availability
  rename nails_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  nails ,replace
 

 
 ********************product:hair_dye**********************************
 
  
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time hair_dye_q10_available hair_dye_q14_price_1  hair_dye_q20_source_1 hair_dye_q14_price_2  hair_dye_q20_source_2 hair_dye_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="hair_dye" if product=="."
drop nproduct

*****manage source
gen origin1 = string(hair_dye_q20_source_1)
drop hair_dye_q20_source_1
gen origin2 = string(hair_dye_q20_source_2)
drop hair_dye_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename hair_dye_q14_price_1 price1
 rename hair_dye_q14_price_2 price2
 rename hair_dye_q10_available availability
  rename hair_dye_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  hair_dye ,replace
 
 
 
 
 ********************product:detergent**********************************
 
 
   
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time detergent_q10_available detergent_q14_price_1  detergent_q20_source_1 detergent_q14_price_2  detergent_q20_source_2 detergent_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="detergent" if product=="."
drop nproduct

*****manage source
gen origin1 = string(detergent_q20_source_1)
drop detergent_q20_source_1
gen origin2 = string(detergent_q20_source_2)
drop detergent_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename detergent_q14_price_1 price1
 rename detergent_q14_price_2 price2
 rename detergent_q10_available availability
 rename detergent_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  detergent ,replace
 

 
 ********************product:spaghetti**********************************
 
    
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time spaghetti_q10_available spaghetti_q14_price_1  spaghetti_q20_source_1 spaghetti_q14_price_2  spaghetti_q20_source_2 spaghetti_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="spaghetti" if product=="."
drop nproduct

*****manage source
gen origin1 = string(spaghetti_q20_source_1)
drop spaghetti_q20_source_1
gen origin2 = string(spaghetti_q20_source_2)
drop spaghetti_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename spaghetti_q14_price_1 price1
 rename spaghetti_q14_price_2 price2
 rename spaghetti_q10_available availability
  rename spaghetti_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  spaghetti,replace
 
 
 
 
 ********************product:tea-local**********************************
 
 
     
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time tea_local_q10_available tea_local_q14_price_1  tea_local_q20_source_1 tea_local_q14_price_2  tea_local_q20_source_2 tea_local_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="tea_local" if product=="."
drop nproduct

*****manage source
gen origin1 = string(tea_local_q20_source_1)
drop tea_local_q20_source_1
gen origin2 = string(tea_local_q20_source_2)
drop tea_local_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename tea_local_q14_price_1 price1
 rename tea_local_q14_price_2 price2
 rename tea_local_q10_available availability
  rename tea_local_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  tea_local,replace
 
 
 
 
 
 ********************product:toothpaste**********************************
 
 
      
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time toothpaste_q10_available toothpaste_q14_price_1  toothpaste_q20_source_1 toothpaste_q14_price_2 toothpaste_q20_source_2 toothpaste_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="toothpaste" if product=="."
drop nproduct

*****manage source
gen origin1 = string(toothpaste_q20_source_1)
drop toothpaste_q20_source_1
gen origin2 = string(toothpaste_q20_source_2)
drop toothpaste_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename toothpaste_q14_price_1 price1
 rename toothpaste_q14_price_2 price2
 rename toothpaste_q10_available availability
 rename toothpaste_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  toothpaste,replace
 
 
 
 
 
 
  ********************product:imported_rice**********************************
 
 
      
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time imported_rice_q10_available imported_rice_q14_price_1  imported_rice_q20_source_1 imported_rice_q14_price_2 imported_rice_q20_source_2 imported_rice_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="imported_rice" if product=="."
drop nproduct

*****manage source
gen origin1 = string(imported_rice_q20_source_1)
drop imported_rice_q20_source_1
gen origin2 = string(imported_rice_q20_source_2)
drop imported_rice_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename imported_rice_q14_price_1 price1
 rename imported_rice_q14_price_2 price2
 rename imported_rice_q10_available availability
  rename imported_rice_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  imported_rice,replace
 
 
 
 
  ********************product:sugar**********************************
 
 
       
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time sugar_q10_available sugar_q14_price_1  sugar_q20_source_1 sugar_q14_price_2 sugar_q20_source_2 sugar_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="sugar" if product=="."
drop nproduct

*****manage source
gen origin1 = string(sugar_q20_source_1)
drop sugar_q20_source_1
gen origin2 = string(sugar_q20_source_2)
drop sugar_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename sugar_q14_price_1 price1
 rename sugar_q14_price_2 price2
 rename sugar_q10_available availability
  rename sugar_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  sugar,replace
 
 
 
  ********************product:sorghum_flour**********************************
 
 
       
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time sorghum_flour_q10_available sorghum_flour_q14_price_1  sorghum_flour_q20_source_1 sorghum_flour_q14_price_2 sorghum_flour_q20_source_2 sorghum_flour_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="sorghum_flour" if product=="."
drop nproduct

*****manage source
gen origin1 = string(sorghum_flour_q20_source_1)
drop sorghum_flour_q20_source_1
gen origin2 = string(sorghum_flour_q20_source_2)
drop sorghum_flour_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 *replace origin1="Kigali" if origin1=="4"
 *replace origin2="Kigali" if origin2=="4"
 ***save goat
 rename sorghum_flour_q14_price_1 price1
 rename sorghum_flour_q14_price_2 price2
 rename sorghum_flour_q10_available availability
  rename sorghum_flour_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  sorghum_flour,replace
 
 
 
 
 
 
   ********************product:cassava_flour**********************************
 
 
       
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time cassava_flour_q10_available cassava_flour_q14_price_1  cassava_flour_q20_source_1 cassava_flour_q14_price_2 cassava_flour_q20_source_2 cassava_flour_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="cassava_flour" if product=="."
drop nproduct

*****manage source
gen origin1 = string(cassava_flour_q20_source_1)
drop cassava_flour_q20_source_1
gen origin2 = string(cassava_flour_q20_source_2)
drop cassava_flour_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 *replace origin1="Kigali" if origin1=="4"
 *replace origin2="Kigali" if origin2=="4"
 ***save goat
 rename cassava_flour_q14_price_1 price1
 rename cassava_flour_q14_price_2 price2
 rename cassava_flour_q10_available availability
  rename cassava_flour_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  cassava_flour,replace
 
 
 
 
 
 
 
 
  
   ********************product:maize**********************************
 
 
       
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time maize_q10_available maize_q14_price_1  maize_q20_source_1 maize_q14_price_2 maize_q20_source_2 maize_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="maize" if product=="."
drop nproduct

*****manage source
gen origin1 = string(maize_q20_source_1)
drop maize_q20_source_1
gen origin2 = string(maize_q20_source_2)
drop maize_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 *replace origin1="Kigali" if origin1=="4"
 *replace origin2="Kigali" if origin2=="4"
 ***save goat
 rename maize_q14_price_1 price1
 rename maize_q14_price_2 price2
 rename maize_q10_available availability
  rename maize_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  maize,replace
 
 
 
 
 
 
 
 
    ********************product:maize_flour**********************************
 
 
       
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time maize_flour_q10_available maize_flour_q14_price_1  maize_flour_q20_source_1 maize_flour_q14_price_2 maize_flour_q20_source_2 maize_flour_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="maize_flour" if product=="."
drop nproduct

*****manage source
gen origin1 = string(maize_flour_q20_source_1)
drop maize_flour_q20_source_1
gen origin2 = string(maize_flour_q20_source_2)
drop maize_flour_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 

 rename maize_flour_q14_price_1 price1
 rename maize_flour_q14_price_2 price2
 rename maize_flour_q10_available availability
  rename maize_flour_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  maize_flour,replace
 
 

 
************************product:grnd_nut_flr**********************************
 
 
       
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time grnd_nut_flr_q10_available grnd_nut_flr_q14_price_1  grnd_nut_flr_q20_source_1 grnd_nut_flr_q14_price_2 grnd_nut_flr_q20_source_2 grnd_nut_flr_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="grnd_nut_flr" if product=="."
drop nproduct

*****manage source
gen origin1 = string(grnd_nut_flr_q20_source_1)
drop grnd_nut_flr_q20_source_1
gen origin2 = string(grnd_nut_flr_q20_source_2)
drop grnd_nut_flr_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 *replace origin1="Kigali" if origin1=="4"
 *replace origin2="Kigali" if origin2=="4"
 ***save goat
 rename grnd_nut_flr_q14_price_1 price1
 rename grnd_nut_flr_q14_price_2 price2
 rename grnd_nut_flr_q10_available availability
  rename grnd_nut_flr_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  grnd_nut_flr,replace
 
 
 
 
 
 
 
 
  
  ********************product:ground_nut**********************************
 
 
       
    clear all
use Price18.dta
keep  market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time ground_nut_q10_available ground_nut_q14_price_1  ground_nut_q20_source_1 ground_nut_q14_price_2 ground_nut_q20_source_2 ground_nut_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="ground_nut" if product=="."
drop nproduct

*****manage source
gen origin1 = string(ground_nut_q20_source_1)
drop ground_nut_q20_source_1
gen origin2 = string(ground_nut_q20_source_2)
drop ground_nut_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename ground_nut_q14_price_1 price1
 rename ground_nut_q14_price_2 price2
 rename ground_nut_q10_available availability
  rename ground_nut_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save  ground_nut,replace
 
 
 
 
 
 
 
  ********************product:dry_beans**********************************
 
 
       
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time dry_beans_q10_available dry_beans_q14_price_1  dry_beans_q20_source_1 dry_beans_q14_price_2 dry_beans_q20_source_2 dry_beans_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="dry_beans" if product=="."
drop nproduct

*****manage source
gen origin1 = string(dry_beans_q20_source_1)
drop dry_beans_q20_source_1
gen origin2 = string(dry_beans_q20_source_2)
drop dry_beans_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename dry_beans_q14_price_1 price1
 rename dry_beans_q14_price_2 price2
 rename dry_beans_q10_available availability
  rename dry_beans_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save dry_beans,replace
 
 
   ********************sweet_potato**********************************
 
 
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time sweet_potato_q10_available sweet_potato_q14_price_1  sweet_potato_q20_source_1 sweet_potato_q14_price_2 sweet_potato_q20_source_2 sweet_potato_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="sweet_potato" if product=="."
drop nproduct

*****manage source
gen origin1 = string(sweet_potato_q20_source_1)
drop sweet_potato_q20_source_1
gen origin2 = string(sweet_potato_q20_source_2)
drop sweet_potato_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename sweet_potato_q14_price_1 price1
 rename sweet_potato_q14_price_2 price2
 rename sweet_potato_q10_available availability
  rename sweet_potato_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save sweet_potato,replace
 
 
 
 
 
   ********************sorghum**********************************
 
 
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time sorghum_q10_available sorghum_q14_price_1  sorghum_q20_source_1 sorghum_q14_price_2 sorghum_q20_source_2 sorghum_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="sorghum" if product=="."
drop nproduct

*****manage source
gen origin1 = string(sorghum_q20_source_1)
drop sorghum_q20_source_1
gen origin2 = string(sorghum_q20_source_2)
drop sorghum_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename sorghum_q14_price_1 price1
 rename sorghum_q14_price_2 price2
 rename sorghum_q10_available availability
 rename sorghum_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 
 

 save sorghum,replace
 
  
   ********************charcoal**********************************
 
 
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time charcoal_q10_available charcoal_q14_price_1  charcoal_q20_source_1 charcoal_q14_price_2 charcoal_q20_source_2 charcoal_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="charcoal" if product=="."
drop nproduct

*****manage source
gen origin1 = string(charcoal_q20_source_1)
drop charcoal_q20_source_1
gen origin2 = string(charcoal_q20_source_2)
drop charcoal_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename charcoal_q14_price_1 price1
 rename charcoal_q14_price_2 price2
 rename charcoal_q10_available availability
  rename charcoal_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save charcoal ,replace
 
 
 
 
   ********************cassava_root**********************************
 
 
 
  
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time cassava_root_q10_available cassava_root_q14_price_1  cassava_root_q20_source_1 cassava_root_q14_price_2 cassava_root_q20_source_2 cassava_root_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="cassava_root" if product=="."
drop nproduct

*****manage source
gen origin1 = string(cassava_root_q20_source_1)
drop cassava_root_q20_source_1
gen origin2 = string(cassava_root_q20_source_2)
drop cassava_root_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename cassava_root_q14_price_1 price1
 rename cassava_root_q14_price_2 price2
 rename cassava_root_q10_available availability
  rename cassava_root_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save cassava_root ,replace
 
 
 
 
 
 
  ********************irish_potato**********************************
 
 
 
  
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time irish_potato_q10_available irish_potato_q14_price_1  irish_potato_q20_source_1 irish_potato_q14_price_2 irish_potato_q20_source_2 irish_potato_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="irish_potato" if product=="."
drop nproduct

*****manage source
gen origin1 = string(irish_potato_q20_source_1)
drop irish_potato_q20_source_1
gen origin2 = string(irish_potato_q20_source_2)
drop irish_potato_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
****outside  Rwanda source
 *replace origin1="Kigali" if origin1=="4"
 *replace origin2="Kigali" if origin2=="4"
 ***save goat
 rename irish_potato_q14_price_1 price1
 rename irish_potato_q14_price_2 price2
 rename irish_potato_q10_available availability
 rename irish_potato_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2 avg_price 

 save irish_potato,replace
 
 
 
 
 
 
 
 
  ********************mandarine**********************************
 
 
 
  
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time mandarine_q10_available mandarine_q14_price_1  mandarine_q20_source_1 mandarine_q14_price_2 mandarine_q20_source_2 mandarine_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="mandarine" if product=="."
drop nproduct

*****manage source
gen origin1 = string(mandarine_q20_source_1)
drop mandarine_q20_source_1
gen origin2 = string(mandarine_q20_source_2)
drop mandarine_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 
 rename mandarine_q14_price_1 price1
 rename mandarine_q14_price_2 price2
 rename mandarine_q10_available availability
 rename mandarine_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save mandarine,replace
 
 
 
 ********************banana**********************************
 
 
  
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time banana_q10_available banana_q14_price_1  banana_q20_source_1 banana_q14_price_2 banana_q20_source_2  banana_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="banana" if product=="."
drop nproduct

*****manage source
gen origin1 = string(banana_q20_source_1)
drop banana_q20_source_1
gen origin2 = string(banana_q20_source_2)
drop banana_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename banana_q14_price_1 price1
 rename banana_q14_price_2 price2
 rename banana_q10_available availability
  rename banana_avg_price       avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save banana,replace
 
   
 ********************cook_banana**********************************
 
 
 
  
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time cook_banana_q10_available cook_banana_q14_price_1  cook_banana_q20_source_1 cook_banana_q14_price_2 cook_banana_q20_source_2 cook_banana_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="cook_banana" if product=="."
drop nproduct

*****manage source
gen origin1 = string(cook_banana_q20_source_1)
drop cook_banana_q20_source_1
gen origin2 = string(cook_banana_q20_source_2)
drop cook_banana_q20_source_2
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename cook_banana_q14_price_1 price1
 rename cook_banana_q14_price_2 price2
 rename cook_banana_q10_available availability
  rename cook_banana_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save cook_banana,replace
 
 
 ********************green_pea**********************************
 
 
 
  
    clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time green_pea_q10_available green_pea_q14_price_1  green_pea_q20_source_1 green_pea_q14_price_2 green_pea_q20_source_2 green_pea_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="green_pea" if product=="."
drop nproduct

*****manage source
gen origin1 = string(green_pea_q20_source_1)
drop green_pea_q20_source_1
gen origin2 = string(green_pea_q20_source_2)
drop green_pea_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename green_pea_q14_price_1 price1
 rename green_pea_q14_price_2 price2
 rename green_pea_q10_available availability
 rename green_pea_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save green_pea,replace
 
 
  ********************soap**********************************

  
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time soap_q10_available soap_q14_price_1  soap_q20_source_1 soap_q14_price_2 soap_q20_source_2  soap_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="soap" if product=="."
drop nproduct

*****manage source
gen origin1 = string(soap_q20_source_1)
drop soap_q20_source_1
gen origin2 = string(soap_q20_source_2)
drop soap_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename soap_q14_price_1 price1
 rename soap_q14_price_2 price2
 rename soap_q10_available availability
  rename soap_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2  avg_price 

 save soap,replace
 
 
 ********************pepper**********************************

clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time pepper_q10_available pepper_q14_price_1  pepper_q20_source_1 pepper_q14_price_2 pepper_q20_source_2  pepper_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="pepper" if product=="."
drop nproduct

*****manage source
gen origin1 = string(pepper_q20_source_1)
drop pepper_q20_source_1
gen origin2 = string(pepper_q20_source_2)
drop pepper_q20_source_2
*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename pepper_q14_price_1 price1
 rename pepper_q14_price_2 price2
 rename pepper_q10_available availability
 rename pepper_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2   avg_price 

 save pepper,replace

 *******************fish**********************************
 
clear all
use Price18.dta
keep market_loclatitude market_loclongitude starttime district district_num q9_number_traders_see sector sector_num cell cell_num market_name marketname_str market_uid visit_n province q3_market_days q3_market_days_1 q3_market_days_2 q3_market_days_3 q3_market_days_4 q3_market_days_5 q3_market_days_6 q4_open_time q5_close_time q6_peakbegin_time q7_peakend_time fish_q10_available fish_q14_price_1  fish_q20_source_1 fish_q14_price_2 fish_q20_source_2  fish_avg_price

**generate a variable for product
gen nproduct=.
gen product=string(nproduct)
replace product="fish" if product=="."
drop nproduct

*****manage source
gen origin1 = string(fish_q20_source_1)
drop fish_q20_source_1
gen origin2 = string(fish_q20_source_2)
drop fish_q20_source_2

*******unknow source
 replace origin1="." if origin1=="-7"
 replace origin2="." if origin2=="-7"
 rename fish_q14_price_1 price1
 rename fish_q14_price_2 price2
 rename fish_q10_available availability
 rename fish_avg_price avg_price
 order  product marketname_str availability price1  origin1 price2 origin2   avg_price 

 save fish,replace
 
 
*************************************************************************************************************************
*                                        STEP2 : append ALL products
**************************************************************************************************************************
clear all
use goat 
append using beef fish amarante cabbage maggi carrots cassava_leaves celery leek onion pepper tomato string_bean green_pea banana cook_banana mandarine irish_potato cassava_root charcoal soap sorghum sweet_potato dry_beans ground_nut grnd_nut_flr maize_flour maize cassava_flour sorghum_flour sugar imported_rice garlic toothpaste tea_local spaghetti detergent hair_dye nails cook_oil shampoo milk comm_beer softdrink mineral_water rabbit whole_chicken brochette egg airtime suitcase candle mattress sanitary_napkin toilet_paper dress echarpe gitenge pants_male pants_female tshirt sandals 


***dulpicates origin 1 et 2//(string of origin)*****************
 
 gen str_origin1=origin1
 
 gen str_origin2=origin2
 
**** solve for origin=5*******************************************
replace str_origin1="." if str_origin1=="5"
replace str_origin2="." if str_origin2=="5"
replace origin1="." if origin1=="5"
replace origin2="." if origin2=="5"
*************************************************************************************************************************
*                                        STEP3 : solve  out -district source
**************************************************************************************************************************


/*
fill all out district source using marketlisting database
for a marketplace many district sources can exist. 
We chose the most frequent one.
*/


****origin1:origin for first seller*******************

replace origin1="Gakenke" if (origin1=="3" & marketname_str=="Shyorongi")
 
replace origin1="Rusizi" if (origin1=="3" & marketname_str=="Mwezi")
 
replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Birembo")
 
replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Rambura")
 
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Butaro")
 
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Nyagahinga")
  
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Gahunga")
 
replace origin1="Gicumbi" if (origin1=="3" & marketname_str=="Kivuye")
 
replace origin1="Burera" if (origin1=="3" & marketname_str=="Kamubuga")
 
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Gasange")
 
replace origin1="Nyagatare" if (origin1=="3" & marketname_str=="Mugera")
  
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Kinteyo")

replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Kabarore")
 
replace origin1="Nyagatare" if (origin1=="3" & marketname_str=="Marimba")
 
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Gisiza")
 
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Kimaruzi")
 
replace origin1="Rwamangana" if (origin1=="3" & marketname_str=="Muhura_Taba")
 
replace origin1="" if (origin1=="3" & marketname_str=="Rugogwe")
  
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Gisenyi")
 
replace origin1="Nyagatare" if (origin1=="3" & marketname_str=="Ngarama")
 
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Remera")
 
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Rwikiniro")
  
replace origin1="Rulindo" if (origin1=="3" & marketname_str=="Gaseke")
 
replace origin1="Gatsibo" if (origin1=="3" & marketname_str=="Burimbi")
 
replace origin1="Huye" if (origin1=="3" & marketname_str=="Migina")

replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Gakoma")
 
replace origin1="Huye" if (origin1=="3" & marketname_str=="Ndora")
 
replace origin1="Nyanza" if (origin1=="3" & marketname_str=="Rwanza")
 
 replace origin1="Nyanza" if (origin1=="3" & marketname_str=="Gako")
 
replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Rambura")
 
replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Muyogoro")
  
replace origin1="Ruhango" if (origin1=="3" & marketname_str=="Gasenyi")
 
replace origin1="Gicumbi" if (origin1=="3" & marketname_str=="Kivuye")
 
replace origin1="Nyabihu" if (origin1=="3" & marketname_str=="Byangabo")
 
replace origin1="Gakenke" if (origin1=="3" & marketname_str=="Musanze")
 
replace origin1="Nyagatare" if (origin1=="3" & marketname_str=="Mugera")
  
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Rurama")

 replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Mutenderi")
 
 replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Nyamagana")
 
 replace origin1="Gatega" if (origin1=="3" & marketname_str=="Zaza")
 
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Gatega")
 
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Kabaya")
 
replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Mutake")
  
replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Kazabe")
 
replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Nyange")
 
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Vunga")
 
replace origin1="Gicumbi" if (origin1=="3" & marketname_str=="Karama")
  
replace origin1="Rwamagana" if (origin1=="3" & marketname_str=="Gatunda")
 
 replace origin1="Gatsibo" if (origin1=="3" & marketname_str=="Nyagashanga")
 
  replace origin1="Gatsibo" if (origin1=="3" & marketname_str=="Gihengeli")

  replace origin1="Rusizi" if (origin1=="3" & marketname_str=="Akagera")
 
 replace origin1="Rusizi" if (origin1=="3" & marketname_str=="Buhinga")
 
 replace origin1="Kamembe" if (origin1=="3" & marketname_str=="Gataka")
 
replace origin1="Rusizi" if (origin1=="3" & marketname_str=="Rugarama")
  
replace origin1="Ruzizi" if (origin1=="3" & marketname_str=="Tyazo")
  
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Gahunga")
 
replace origin1="Ruvabu" if (origin1=="3" & marketname_str=="Karengera")
 
replace origin1="Rusizi" if (origin1=="3" & marketname_str=="Mugonero")
 
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Gasange")
 
replace origin1="Rusizi" if (origin1=="3" & marketname_str=="Market in Kanazi")
  
replace origin1="Rusizi" if (origin1=="3" & marketname_str=="Bushenge")

 replace origin1="Nyanza" if (origin1=="3" & marketname_str=="Busanze")
 
 replace origin1="Nyanza" if (origin1=="3" & marketname_str=="Ndago")
 
 replace origin1="Nyanza" if (origin1=="3" & marketname_str=="Muganza")
 
replace origin1="Huye" if (origin1=="3" & marketname_str=="Ngarurira")
 
replace origin1="Rwamangana" if (origin1=="3" & marketname_str=="Muhura_Taba")
 
replace origin1="Nyamagabe" if (origin1=="3" & marketname_str=="Ruramba")
  
replace origin1="Huye" if (origin1=="3" & marketname_str=="Rugarika")
 
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Kabumba")
 
replace origin1="Nyabihu" if (origin1=="3" & marketname_str=="Mpuzamahanga")
 
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Mahoko")
  
replace origin1="Gicumbi" if (origin1=="3" & marketname_str=="Kiyanza")
 
replace origin1="Gicumbi" if (origin1=="3" & marketname_str=="Kajevuba")
 
replace origin1="Rubavu" if (origin1=="3" & marketname_str=="Kabahima")

replace origin1="Rubavu" if (origin1=="3" & marketname_str=="Nkora")
 
replace origin1="Rubavu" if (origin1=="3" & marketname_str=="Nyagahinika")
 
replace origin1="Nyanza" if (origin1=="3" & marketname_str=="Rwanza")
 
replace origin1="Gicumbi" if (origin1=="3" & marketname_str=="Manishya")
 
replace origin1="Gasabo" if (origin1=="3" & marketname_str=="Nyagasumbu Center")
 
replace origin1="Kayonza" if (origin1=="3" & marketname_str=="Nsinda")
  
replace origin1="Nyanza" if (origin1=="3" & marketname_str=="Cyili")
 
replace origin1="Huye" if (origin1=="3" & marketname_str=="Nyagahuru")
 
replace origin1="Huye" if (origin1=="3" & marketname_str=="Mbumarazi")
 
replace origin1="Nyanza" if (origin1=="3" & marketname_str=="kizi")
 
replace origin1="Nyanza" if (origin1=="3" & marketname_str=="Rurogwe")
  
replace origin1="Nyanza" if (origin1=="3" & marketname_str=="Kinazi")

replace origin1="Muhanga" if (origin1=="3" & marketname_str=="shyembe")
 
replace origin1="Nyamagabe" if (origin1=="3" & marketname_str=="Mukungu")
 
replace origin1="Rutsiro" if (origin1=="3" & marketname_str=="Gitikinini")
 
replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Gahunduguru")
 
replace origin1="Muhanga" if (origin1=="3" & marketname_str=="Gisovo")
 
replace origin1="Rubavu" if (origin1=="3" & marketname_str=="Kora")
  
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Mukamira")
 
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Rubaya")
 
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Gashyushya")
 
replace origin1="Gatsibo" if (origin1=="3" & marketname_str=="Rwimiyaga")
  
replace origin1="Musanze" if (origin1=="3" & marketname_str=="Buhuru")
 
replace origin1="Rubavu" if (origin1=="3" & marketname_str=="Terimbere")

replace origin1="Rubavu" if (origin1== "3" & marketname_str=="Gakeri")
  
replace origin1="Kirehe" if (origin1== "3" & marketname_str=="Kigabiro")


replace origin1="Kirehe" if (origin1== "3" & marketname_str=="Kigabiro")
replace origin1="" if (origin1== "3" & marketname_str=="Rango")
replace origin1="" if (origin1== "3" & marketname_str=="Bambiro")
replace origin1="Muhanga" if (origin1== "3" & marketname_str=="Birambo")
replace origin1="" if (origin1== "3" & marketname_str=="Buguma")
replace origin1="Musanze" if (origin1== "3" & marketname_str=="Gasiza")
replace origin1="" if (origin1== "3" & marketname_str=="Gishwati")
replace origin1="" if (origin1== "3" & marketname_str=="Inteko")
replace origin1="" if (origin1== "3" & marketname_str=="Kagarama")
replace origin1="Kayonzo" if (origin1== "3" & marketname_str=="Katabagemu")
replace origin1="Ruhengeli" if (origin1== "3" & marketname_str=="Kibuye")
replace origin1="Gatsibo" if (origin1== "3" & marketname_str=="Matimba")
replace origin1="Huye" if (origin1== "3" & marketname_str=="Mburamazi")
replace origin1="" if (origin1== "3" & marketname_str=="Musheli")
replace origin1="" if (origin1== "3" & marketname_str=="Ndatemwa")
replace origin1="Gatsibo" if (origin1== "3" & marketname_str=="Nyagatare")
replace origin1="" if (origin1== "3" & marketname_str=="Nyamata")
replace origin1="" if (origin1== "3" & marketname_str=="Rugari")
replace origin1="Kayonza" if (origin1== "3" & marketname_str=="Rukomo")
replace origin1="Nyabihu" if (origin1== "3" & marketname_str=="Ryabizige")
replace origin1="Muhanga" if (origin1== "3" & marketname_str=="Shyembe")
replace origin1="" if (origin1== "3" & marketname_str=="Cyiri")
replace origin1="" if (origin1== "3" & marketname_str=="Kibirizi")
replace origin1="Kayonza" if (origin1== "3" & marketname_str=="Kiramuruzi")
replace origin1="" if (origin1== "3" & marketname_str=="Nzige")
replace origin1="" if (origin1== "3" & marketname_str=="Rutare")
replace origin1="Rusizi" if (origin1== "3" & marketname_str=="Kanazi")
replace origin1="" if (origin1== "3" & marketname_str=="Mukabuga")
replace origin1="" if (origin1== "3" & marketname_str=="Rilima Center")
replace origin1="Musanze" if (origin1== "3" & marketname_str=="Ruhuha")
replace origin1="" if (origin1== "3" & marketname_str=="Rubona")
replace origin1="Nyanza" if (origin1== "3" & marketname_str=="Kizi")
replace origin1="" if (origin1== "3" & marketname_str=="Byumba")
replace origin1="" if (origin1== "3" & marketname_str=="Shangasha")
replace origin1="" if (origin1== "3" & marketname_str=="Kageyo")
replace origin1="" if (origin1== "3" & marketname_str=="Biziba")
replace origin1="" if (origin1== "3" & marketname_str=="Kagenge")
replace origin1="" if (origin1== "3" & marketname_str=="Gikokwe")
replace origin1="" if (origin1== "3" & marketname_str=="Base")
replace origin1="" if (origin1== "3" & marketname_str=="Ruli")
replace origin1="Rubavu" if (origin1== "3" & marketname_str=="Bugabo")
replace origin1="Gasabo" if (origin1== "3" & marketname_str=="Nyagasambu Center")
replace origin1="" if (origin1== "3" & marketname_str=="Rubagabaga")
replace origin1="" if (origin1== "3" & marketname_str=="Rugerero")
replace origin1="" if (origin1== "3" & marketname_str=="Kabari")
replace origin1="" if (origin1== "3" & marketname_str=="Bazirete")
replace origin1="" if (origin1== "3" & marketname_str=="Mucaca")
replace origin1="" if (origin1== "3" & marketname_str=="Gitega")
replace origin1="" if (origin1== "3" & marketname_str=="Muhondo")
replace origin1="" if (origin1== "3" & marketname_str=="Muvumba")
replace origin1="" if (origin1== "3" & marketname_str=="Muhura Taba")
replace origin1="" if (origin1== "3" & marketname_str=="Karambo")
replace origin1="" if (origin1== "3" & marketname_str=="Muhurire")
replace origin1="" if (origin1== "3" & marketname_str=="Busoro")
replace origin1="" if (origin1== "3" & marketname_str=="Congo_Nil")
replace origin1="" if (origin1== "3" & marketname_str=="Rupango")
replace origin1="" if (origin1== "3" & marketname_str=="Viro")
replace origin1="" if (origin1== "3" & marketname_str=="Gikombe")
replace origin1="Musanze" if (origin1== "3" & marketname_str=="Rurembo")
replace origin1="" if (origin1== "3" & marketname_str=="Kinkanga")




****origin2 : origin for second seller**********************************



replace origin2="Muhanga" if (origin2== "3" & marketname_str=="Birambo")
replace origin2="Gakenke" if (origin2=="3" & marketname_str=="Shyorongi")
 
replace origin2="Rusizi" if (origin2=="3" & marketname_str=="Mwezi")
 
replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Birembo")
 
replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Rambura")
 
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Butaro")
 
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Nyagahinga")
  
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Gahunga")
 
replace origin2="Gicumbi" if (origin2=="3" & marketname_str=="Kivuye")
 
replace origin2="Burera" if (origin2=="3" & marketname_str=="Kamubuga")
 
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Gasange")
 
replace origin2="Nyagatare" if (origin2=="3" & marketname_str=="Mugera")
  
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Kinteyo")

replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Kabarore")
 
replace origin2="Nyagatare" if (origin2=="3" & marketname_str=="Marimba")
 
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Gisiza")
 
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Kimaruzi")
 
replace origin2="Rwamangana" if (origin2=="3" & marketname_str=="Muhura_Taba")
 
replace origin2="" if (origin2=="3" & marketname_str=="Rugogwe")
  
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Gisenyi")
 
replace origin2="Nyagatare" if (origin2=="3" & marketname_str=="Ngarama")
 
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Remera")
 
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Rwikiniro")
  
replace origin2="Rulindo" if (origin2=="3" & marketname_str=="Gaseke")
 
replace origin2="Gatsibo" if (origin2=="3" & marketname_str=="Burimbi")
 
replace origin2="Huye" if (origin2=="3" & marketname_str=="Migina")

replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Gakoma")
 
replace origin2="Huye" if (origin2=="3" & marketname_str=="Ndora")
 
replace origin2="Nyanza" if (origin2=="3" & marketname_str=="Rwanza")
 
 replace origin2="Nyanza" if (origin2=="3" & marketname_str=="Gako")
 
replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Rambura")
 
replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Muyogoro")
  
replace origin2="Ruhango" if (origin2=="3" & marketname_str=="Gasenyi")
 
replace origin2="Gicumbi" if (origin2=="3" & marketname_str=="Kivuye")
 
replace origin2="Nyabihu" if (origin2=="3" & marketname_str=="Byangabo")
 
replace origin2="Gakenke" if (origin2=="3" & marketname_str=="Musanze")
 
replace origin2="Nyagatare" if (origin2=="3" & marketname_str=="Mugera")
  
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Rurama")

 replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Mutenderi")
 
 replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Nyamagana")
 
 replace origin2="Gatega" if (origin2=="3" & marketname_str=="Zaza")
 
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Gatega")
 
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Kabaya")
 
replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Mutake")
  
replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Kazabe")
 
replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Nyange")
 
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Vunga")
 
replace origin2="Gicumbi" if (origin2=="3" & marketname_str=="Karama")
  
replace origin2="Rwamagana" if (origin2=="3" & marketname_str=="Gatunda")
 
 replace origin2="Gatsibo" if (origin2=="3" & marketname_str=="Nyagashanga")
 
  replace origin2="Gatsibo" if (origin2=="3" & marketname_str=="Gihengeli")

  replace origin2="Rusizi" if (origin2=="3" & marketname_str=="Akagera")
 
 replace origin2="Rusizi" if (origin2=="3" & marketname_str=="Buhinga")
 
 replace origin2="Kamembe" if (origin2=="3" & marketname_str=="Gataka")
 
replace origin2="Rusizi" if (origin2=="3" & marketname_str=="Rugarama")
  
replace origin2="Ruzizi" if (origin2=="3" & marketname_str=="Tyazo")
  
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Gahunga")
 
replace origin2="Ruvabu" if (origin2=="3" & marketname_str=="Karengera")
 
replace origin2="Rusizi" if (origin2=="3" & marketname_str=="Mugonero")
 
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Gasange")
 
replace origin2="Rusizi" if (origin2=="3" & marketname_str=="Market in Kanazi")
  
replace origin2="Rusizi" if (origin2=="3" & marketname_str=="Bushenge")

 replace origin2="Nyanza" if (origin2=="3" & marketname_str=="Busanze")
 
 replace origin2="Nyanza" if (origin2=="3" & marketname_str=="Ndago")
 
 replace origin2="Nyanza" if (origin2=="3" & marketname_str=="Muganza")
 
replace origin2="Huye" if (origin2=="3" & marketname_str=="Ngarurira")
 
replace origin2="Rwamangana" if (origin2=="3" & marketname_str=="Muhura_Taba")
 
replace origin2="Nyamagabe" if (origin2=="3" & marketname_str=="Ruramba")
  
replace origin2="Huye" if (origin2=="3" & marketname_str=="Rugarika")
 
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Kabumba")
 
replace origin2="Nyabihu" if (origin2=="3" & marketname_str=="Mpuzamahanga")
 
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Mahoko")
  
replace origin2="Gicumbi" if (origin2=="3" & marketname_str=="Kiyanza")
 
replace origin2="Gicumbi" if (origin2=="3" & marketname_str=="Kajevuba")
 
replace origin2="Rubavu" if (origin2=="3" & marketname_str=="Kabahima")

replace origin2="Rubavu" if (origin2=="3" & marketname_str=="Nkora")
 
replace origin2="Rubavu" if (origin2=="3" & marketname_str=="Nyagahinika")
 
replace origin2="Nyanza" if (origin2=="3" & marketname_str=="Rwanza")
 
replace origin2="Gicumbi" if (origin2=="3" & marketname_str=="Manishya")
 
replace origin2="Gasabo" if (origin2=="3" & marketname_str=="Nyagasumbu Center")
 
replace origin2="Kayonza" if (origin2=="3" & marketname_str=="Nsinda")
  
replace origin2="Nyanza" if (origin2=="3" & marketname_str=="Cyili")
 
replace origin2="Huye" if (origin2=="3" & marketname_str=="Nyagahuru")
 
replace origin2="Huye" if (origin2=="3" & marketname_str=="Mbumarazi")
 
replace origin2="Nyanza" if (origin2=="3" & marketname_str=="kizi")
 
replace origin2="Nyanza" if (origin2=="3" & marketname_str=="Rurogwe")
  
replace origin2="Nyanza" if (origin2=="3" & marketname_str=="Kinazi")

replace origin2="Muhanga" if (origin2=="3" & marketname_str=="shyembe")
 
replace origin2="Nyamagabe" if (origin2=="3" & marketname_str=="Mukungu")
 
replace origin2="Rutsiro" if (origin2=="3" & marketname_str=="Gitikinini")
 
replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Gahunduguru")
 
replace origin2="Muhanga" if (origin2=="3" & marketname_str=="Gisovo")
 
replace origin2="Rubavu" if (origin2=="3" & marketname_str=="Kora")
  
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Mukamira")
 
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Rubaya")
 
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Gashyushya")
 
replace origin2="Gatsibo" if (origin2=="3" & marketname_str=="Rwimiyaga")
  
replace origin2="Musanze" if (origin2=="3" & marketname_str=="Buhuru")
 
replace origin2="Rubavu" if (origin2=="3" & marketname_str=="Terimbere")

replace origin2="Rubavu" if (origin2== "3" & marketname_str=="Gakeri")
  
replace origin2="Kirehe" if (origin2== "3" & marketname_str=="Kigabiro")

replace origin2="Kirehe" if (origin2== "3" & marketname_str=="Kigabiro")
replace origin2="" if (origin2== "3" & marketname_str=="Rango")
replace origin2="" if (origin2== "3" & marketname_str=="Bambiro")
replace origin2="Muhanga" if (origin2== "3" & marketname_str=="Birambo")
replace origin2="" if (origin2== "3" & marketname_str=="Buguma")
replace origin2="Musanze" if (origin2== "3" & marketname_str=="Gasiza")
replace origin2="" if (origin2== "3" & marketname_str=="Gishwati")
replace origin2="" if (origin2== "3" & marketname_str=="Inteko")
replace origin2="" if (origin2== "3" & marketname_str=="Kagarama")
replace origin2="Kayonzo" if (origin2== "3" & marketname_str=="Katabagemu")
replace origin2="Ruhengeli" if (origin2== "3" & marketname_str=="Kibuye")
replace origin2="Gatsibo" if (origin2== "3" & marketname_str=="Matimba")
replace origin2="Huye" if (origin2=="3" & marketname_str=="Mburamazi")
replace origin2="" if (origin2== "3" & marketname_str=="Musheli")
replace origin2="" if (origin2== "3" & marketname_str=="Ndatemwa")
replace origin2="Gatsibo" if (origin2== "3" & marketname_str=="Nyagatare")
replace origin2="" if (origin2== "3" & marketname_str=="Nyamata")
replace origin2="" if (origin2== "3" & marketname_str=="Rugari")
replace origin2="Kayonza" if (origin2== "3" & marketname_str=="Rukomo")
replace origin2="Nyabihu" if (origin2== "3" & marketname_str=="Ryabizige")
replace origin2="Muhanga" if (origin2== "3" & marketname_str=="Shyembe")
replace origin2="" if (origin2== "3" & marketname_str=="Cyiri")
replace origin2="" if (origin2== "3" & marketname_str=="Kibirizi")
replace origin2="Kayonza" if (origin2== "3" & marketname_str=="Kiramuruzi")
replace origin2="" if (origin2== "3" & marketname_str=="Nzige")
replace origin2="" if (origin2== "3" & marketname_str=="Rutare")
replace origin2="Rusizi" if (origin2== "3" & marketname_str=="Kanazi")
replace origin2="" if (origin2== "3" & marketname_str=="Mukabuga")
replace origin2="" if (origin2== "3" & marketname_str=="Rilima Center")
replace origin2="Musanze" if (origin2== "3" & marketname_str=="Ruhuha")
replace origin2="" if (origin2== "3" & marketname_str=="Rubona")
replace origin2="Nyanza" if (origin2== "3" & marketname_str=="Kizi")
replace origin2="" if (origin2== "3" & marketname_str=="Byumba")
replace origin2="" if (origin2== "3" & marketname_str=="Shangasha")
replace origin2="" if (origin2== "3" & marketname_str=="Kageyo")
replace origin2="" if (origin2=="3" & marketname_str=="Biziba")
replace origin2="" if (origin2== "3" & marketname_str=="Kagenge")
replace origin2="" if (origin2== "3" & marketname_str=="Gikokwe")
replace origin2="" if (origin2== "3" & marketname_str=="Base")
replace origin2="" if (origin2== "3" & marketname_str=="Ruli")
replace origin2="Rubavu" if (origin2== "3" & marketname_str=="Bugabo")
replace origin2="Gasabo" if (origin2=="3" & marketname_str=="Nyagasambu Center")
replace origin2="" if (origin2== "3" & marketname_str=="Rubagabaga")
replace origin2="" if (origin2== "3" & marketname_str=="Rugerero")
replace origin2="" if (origin2== "3" & marketname_str=="Kabari")
replace origin2="" if (origin2== "3" & marketname_str=="Bazirete")
replace origin2="" if (origin2== "3" & marketname_str=="Mucaca")
replace origin2="" if (origin2== "3" & marketname_str=="Gitega")
replace origin2="" if (origin2== "3" & marketname_str=="Muhondo")
replace origin2="" if (origin2== "3" & marketname_str=="Muvumba")
replace origin2="" if (origin2== "3" & marketname_str=="Muhura Taba")
replace origin2="" if (origin2== "3" & marketname_str=="Karambo")
replace origin2="" if (origin2== "3" & marketname_str=="Muhurire")
replace origin2="" if (origin2== "3" & marketname_str=="Busoro")
replace origin2="" if (origin2== "3" & marketname_str=="Congo_Nil")
replace origin2="" if (origin2== "3" & marketname_str=="Rupango")
replace origin2="" if (origin2== "3" & marketname_str=="Viro")
replace origin2="" if (origin2== "3" & marketname_str=="Gikombe")
replace origin2="Musanze" if (origin2== "3" & marketname_str=="Rurembo")
replace origin2="" if (origin2== "3" & marketname_str=="Kinkanga")


/// define time variable

*clear all
*use pricefinal

g s = string(starttime,"%tc")
g year=substr(s,6,4)
g month= substr(s,3,3)
destring year,replace
replace month = "1" if  month =="jan" 
replace month = "2" if  month == "feb" 
replace month = "3" if  month == "mar" 
replace month = "4" if  month == "apr" 
replace month = "5" if  month == "may" 
replace month = "6" if  month == "jun" 
replace month = "7" if  month == "jul" 
replace month = "8" if  month == "aug" 
replace month = "9" if  month == "sep" 
replace month = "10" if  month == "oct" 
replace month = "11" if  month == "nov" 
replace month = "12" if  month == "dec" 
destring month,replace
///arrange data
sort product year month marketname_str
order product marketname_str  district  sector cell availability   month year price1 origin1




////// price orgin and destination

rename (price1 price2) (price_dest1 price_dest2)

g price_origin1=.

g price_origin2=.

replace price_origin1=price_dest1 if origin1==marketname_str
replace price_origin2=price_dest2 if origin2==marketname_str

order product marketname_str district sector cell availability   month year price_dest1  origin1 price_origin1 price_dest2  origin2 price_origin2



// Manage errors in markets names /district/cell (12 septembre 2018)



*province
gen prov= string(province)
drop province
replace prov ="Kigali Town" if prov=="1"
replace prov ="South" if prov=="2"
replace prov ="West" if prov=="3"
replace prov ="North" if prov=="4"
replace prov ="East" if prov=="5"
rename prov province
replace province ="South" if (district=="Gisagara"|district=="Nyaruguru"|district=="Huye"|district=="Muhanga")
replace province ="West" if (district=="Karongi"|district=="Ngororero"|district=="Nyabihu"|district=="Nyamasheke"|district=="Rubavu"|district=="Rusizi"|district=="Rutsiro")
replace province ="North" if (district=="Burera"|district=="Gakenke"|district=="Gicumbi"|district=="Musanze"|district=="Rulindo")
replace province ="East" if (district=="Bugesera"|district=="Gatsibo"|district=="Ngoma"|district=="Nyagatare"|district=="Rwamagana")


* Markets
replace marketname_str="Muhura Taba" if marketname_str=="Muhura_Taba"

replace marketname_str="Congo Nil" if marketname_str=="Congo_Nil"

replace marketname_str="Gasiza" if marketname_str=="Gisiza"

replace marketname_str="Rugalika" if marketname_str=="Rugarika"

*replace marketname_st="Birembo" if marketname_st=="Birambo"


*Cell

replace cell="Congo Nil" if cell=="Congo_Nil"
replace cell="Rango" if cell=="Rango A"
*replace cell="Birembo" if cell=="Birambo"
replace cell="Gasiza" if cell=="Gisiza"

* origin1

replace origin1="Congo Nil" if origin1=="Congo_Nil"
replace origin1="Muhura Taba" if origin1=="Muhura_Taba"
replace origin1= "Rwamagana" if origin1=="Rwamangana"
replace origin1= "Rusizi" if origin1=="Rusiza"
replace origin1= "Rusizi" if origin1=="Ruzizi"
*replace origin1="Birembo" if origin1=="Birambo"
replace origin1="Gasiza" if origin1=="Gisiza"
replace origin1="Rugalika" if origin1=="Rugarika"

* origin2

replace origin2="Congo Nil" if origin2=="Congo_Nil"
replace origin2="Muhura Taba" if origin2=="Muhura_Taba"
replace origin2= "Rwamagana" if origin2=="Rwamangana"
replace origin2= "Rusizi" if origin2=="Rusiza"
replace origin2= "Rusizi" if origin2=="Ruzizi"
*replace origin2="Birembo" if origin2=="Birambo"
replace origin2="Gasiza" if origin2=="Gisiza"
replace origin2="Rugalika" if origin2=="Rugarika"




// managethe origin of foreign product( RDC= Gisenyi, Tanzanie=Rusumo (Byumba), Uganda=Byumba, Burundi=Rugalika)

*origin1
replace origin1="Gisenyi" if (origin1=="4" & marketname_str=="Butaro")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Nyagahinga")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Gahunga")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Kivuye")

replace origin1="Rusumo" if (origin1=="4" & marketname_str=="Mugera")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Byumba")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Karama")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Matimba")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Musheli")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Nyagatare")

replace origin1="Rugalika" if (origin1=="4" & marketname_str=="Busanze")

replace origin1="Gisenyi" if (origin1=="4" & marketname_str=="Mpuzamahanga")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Mahoko")

replace origin1="Gisenyi" if (origin1=="4" & marketname_str=="Muganza")

replace origin1="Gisenyi" if (origin1=="4" & marketname_str=="Bambiro")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Nkora")

replace origin1="Byumba" if (origin1=="4" & marketname_str=="Kibagiro")

replace origin1="Gisenyi" if (origin1=="4" & marketname_str=="Rurogwe")

replace origin1="Gisenyi" if (origin1=="4" & marketname_str=="Gasiza")

replace origin1="Gisenyi" if (origin1=="4" & marketname_str=="Kora")

replace origin1="Buymba" if (origin1=="4" & marketname_str=="Rwimiyiga")

replace origin1="Gisenyi" if (origin1=="4" & marketname_str=="Kabumba")

replace origin1="Gisenyi" if (origin1=="4" & marketname_str=="Buhuru")


*origin2

replace origin2="Gisenyi" if (origin2=="4" & marketname_str=="Butaro")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Nyagahinga")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Gahunga")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Kivuye")

replace origin2="Rusumo" if (origin2=="4" & marketname_str=="Mugera")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Byumba")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Karama")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Matimba")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Musheli")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Nyagatare")

replace origin2="Rugalika" if (origin2=="4" & marketname_str=="Busanze")

replace origin2="Gisenyi" if (origin2=="4" & marketname_str=="Mpuzamahanga")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Mahoko")

replace origin2="Gisenyi" if (origin2=="4" & marketname_str=="Muganza")

replace origin2="Gisenyi" if (origin2=="4" & marketname_str=="Bambiro")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Nkora")

replace origin2="Byumba" if (origin2=="4" & marketname_str=="Kibagiro")

replace origin2="Gisenyi" if (origin2=="4" & marketname_str=="Rurogwe")

replace origin2="Gisenyi" if (origin2=="4" & marketname_str=="Gasiza")

replace origin2="Gisenyi" if (origin2=="4" & marketname_str=="Kora")

replace origin2="Buymba" if (origin2=="4" & marketname_str=="Rwimiyiga")

replace origin2="Gisenyi" if (origin2=="4" & marketname_str=="Kabumba")

replace origin2="Gisenyi" if (origin2=="4" & marketname_str=="Buhuru")


***non-identified ouside rwanda( the origin country is  the nearest border  country)


replace origin1="Byumba" if (origin1=="4" & province=="North")
replace origin1="Rugalika" if (origin1=="4" & province=="South")
replace origin1="Gisenyi" if (origin1=="4" & province=="West")
replace origin1="Rusumo" if (origin1=="4" & province=="East")
replace origin2="Byumba" if (origin2=="4" & province=="North")
replace origin2="Rugalika" if (origin2=="4" & province=="South")
replace origin2="Gisenyi" if (origin2=="4" & province=="West")
replace origin2="Rusumo" if (origin2=="4" & province=="East")


// manage origin in the village and in the district

replace origin1=district if origin1=="2"
replace origin1=marketname_str if origin1=="1"
replace origin2=district if origin2=="2"
replace origin2=marketname_str if origin2=="1"

/// variable foreign_country

gen country1="."
gen country2="."
replace country1="Uganda" if (origin1=="Byumba" & str_origin1=="4")
replace country1="Burundi" if (origin1=="Rugalika"& str_origin1=="4" )
replace country1="RDC" if (origin1=="Gisenyi"& str_origin1=="4")
replace country1="Tanzania" if (origin1=="Rusumo"& str_origin1=="4")
replace country2="Uganda" if (origin2=="Byumba"& str_origin2=="4" )
replace country2="Burundi" if (origin2=="Rugalika" & str_origin2=="4" )
replace country2="RDC" if (origin2=="Gisenyi" & str_origin2=="4")
replace country2="Tanzania" if (origin2=="Rusumo" & str_origin2=="4")




save baseracine,replace



 




























 

