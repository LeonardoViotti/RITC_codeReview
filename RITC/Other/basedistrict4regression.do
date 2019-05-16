*04 octobre
*Name: basedistrict4regression.do
*Aim: database using mean prices of district for regression

*output: basedistrict4regression
//traitement des in district 
*clear
*cd "C:\Users\wb535383\Desktop\construction_database_rwanda"

clear all
cd "/Users/williamewane/Desktop/dossierbase"
use baseforeign



//////deal with the fact that in the same month enumerators can visit a market 2 times.


sort product marketname_str district cell year month visit_n

count if (month==month[_n+1] &  year==year[_n+1]&  market_uid==market_uid[_n+1])

replace month= month-1 if (month==month[_n+1]  &  year==year[_n+1]& month!=1 &  market_uid==market_uid[_n+1] & month[_n-1] != month-1 )

replace month= month+1 if (month==month[_n-1]   & year==year[_n-1]& month!=12 &  month[_n+1] != month+1) 

count if (month==month[_n+1] &  year==year[_n+1]&  market_uid==market_uid[_n+1])

drop  if (month==month[_n+1] &  year==year[_n+1]&  market_uid==market_uid[_n+1])



*****indistrict for origin1
tab str_origin1
bys availability: tab str_origin1 
sort province district sector availability year month price_dest1
destring price_origin1, replace 
count if price_origin1==. & str_origin1=="2" 
bys product district year month: egen av_distrprice1=mean(price_dest1)
replace price_origin1 = av_distrprice1 if str_origin1=="2"
order product av_distrprice1 price_dest1 price_origin1 availability district cell year month marketname_str origin1 str_origin1 sector
sort product year month district cell




*****indistrict for origin 2*********************

tab str_origin2
bys availability: tab str_origin2 
sort province district sector availability year month price_dest2
destring price_origin1, replace 
 
count if price_origin2==. & str_origin2=="2" 
bys product district year month: egen av_distrprice2=mean(price_dest2)
replace price_origin2 = av_distrprice2 if str_origin2=="2"
order product av_distrprice1 price_dest1 price_origin1 origin1  str_origin1  av_distrprice2 price_dest2 price_origin2 origin2 str_origin2 availability district cell year month  sector
sort product year month district cell



// price for in-village source
replace price_origin1 = price_dest1 if str_origin1=="1"
replace price_origin2=price_dest2  if str_origin1=="2"
sort product year month district cell

save basedistrict, replace // base qui utilise la moyenne des prix dans le district

//traitement des out of district

****outdistrict pour vendeur1*************



*creer une base qui isole les prix outdistrict du premier vendeur (moyenne des prix par district)

clear all
use basedistrict


keep product district  month year av_distrprice1
duplicates drop
rename district origin1 
rename av_distrprice1 priceoutdistrict1

save outdistrict1,replace





* merger avec la basse mere pour avoir les prix outdistrict1 
clear all
use basedistrict

merge m:1 product origin1 year month using outdistrict1 ,keep(master match)

drop _merge
sort product year month district
replace price_origin1=priceoutdistrict1  if  str_origin1=="3"
order product marketname_str district cell availability month year price_dest1 priceoutdistrict1  origin1 price_origin1

save basedistrict1,replace


****outdistrict pour vendeur2*************
clear all
use basedistrict

keep product district  month year av_distrprice2
duplicates drop
rename district origin2 
rename av_distrprice2 priceoutdistrict2

save outdistrict2,replace

* merger avec la basse mere pour avoir les prix outdistrict2**********
clear all
use basedistrict1

merge m:1 product origin2 year month using outdistrict2,keep(master match) 

drop _merge
sort product year month district
replace price_origin2=priceoutdistrict2  if  str_origin2=="3"
order product marketname_str district cell availability month year price_dest2 priceoutdistrict2  origin1 price_origin2


**************merger  avec  la base feeder road**********************************************

merge m:1 market_uid using feeder_road,keep(master match)


drop _merge
sort product year month district cell year month visit_n
order product marketname_str district cell availability month year price_dest1 priceoutdistrict1  origin1 price_origin1 price_dest2 priceoutdistrict2  origin1 price_origin2


//////deal with the fact that in the same month enumerators can visit a market 2 times.


sort product marketname_str district cell year month visit_n

count if (month==month[_n+1] &  year==year[_n+1]&  market_uid==market_uid[_n+1])

replace month= month-1 if (month==month[_n+1]  &  year==year[_n+1]& month!=1 &  market_uid==market_uid[_n+1] & month[_n-1] != month-1 )

replace month= month+1 if (month==month[_n-1]   & year==year[_n-1]& month!=12 &  month[_n+1] != month+1) 

count if (month==month[_n+1] &  year==year[_n+1]&  market_uid==market_uid[_n+1])
count if (month==month[_n-1] &  year==year[_n-1]&  market_uid==market_uid[_n-1])
drop  if (month==month[_n+1] &  year==year[_n+1]&  market_uid==market_uid[_n+1])
drop if (month==month[_n-1] &  year==year[_n-1]&  market_uid==market_uid[_n-1])
count if (month==month[_n-1] &  year==year[_n-1]&  market_uid==market_uid[_n-1])
                             

							 
/// declare panel data 

**genererate  dates (time component)
gen mdate = ym(year, month)

** generates individual component (products and destinations)

egen panelid = group(product market_uid)

duplicates report panelid mdate
duplicates list panelid mdate

duplicates drop panelid mdate,force

count

xtset panelid mdate

sort product   year month  marketname_str







save basedistrict03oct,replace




