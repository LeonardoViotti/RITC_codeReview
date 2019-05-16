/*03 octobre
*Name: basecell4regression.do
*Aim:  dataset for regression (fill indistrict and outdistrict origin)
*output: basecell4regression
*/


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
count if (month==month[_n-1] &  year==year[_n-1]&  market_uid==market_uid[_n-1])
drop  if (month==month[_n+1] &  year==year[_n+1]&  market_uid==market_uid[_n+1])
drop if (month==month[_n-1] &  year==year[_n-1]&  market_uid==market_uid[_n-1])
count if (month==month[_n-1] &  year==year[_n-1]&  market_uid==market_uid[_n-1])
                             
/////deal with indistrict origin(we use the mean prices in the cells to  fill indistrict origin prices)



*****indistrict origin prices for first seller

tab str_origin1
bys availability: tab str_origin1 

sort province district sector availability year month price_dest1
count if price_origin1==. & str_origin1=="2" 
bys product cell year month : egen av_distrprice1=mean(price_dest1)
replace price_origin1 = av_distrprice1 if str_origin1=="2" // price for origin indistrict equal to the mean price in the cell
order product av_distrprice1 price_dest1 price_origin1 availability district cell year month marketname_str origin1 str_origin1 sector

sort product marketname_str district cell year month visit_n
sort product year month district cell



*****indistrict origin prices for  second seller*********************

tab str_origin2
bys availability: tab str_origin2 
sort province district sector availability year month price_dest2
destring price_origin1, replace 
 
count if price_origin2==. & str_origin2=="2" 
bys product cell year month: egen av_distrprice2=mean(price_dest2)
replace price_origin2 = av_distrprice2 if str_origin2=="2"
order product av_distrprice1 price_dest1 price_origin1 origin1  str_origin1  av_distrprice2 price_dest2 price_origin2 origin2 str_origin2 availability district cell year month  sector
sort product year month district cell


// in village treatment
replace price_origin1 = price_dest1 if str_origin1=="1"
replace price_origin2=price_dest2  if str_origin1=="2"
sort product year month district cell

save basecell, replace // database using mean price in cells





//treatment of   out of district

****outdistrict for  seller 1*************



* create a database for price out of district

clear all
use basecell
sort product year month district cell

keep product district cell month year av_distrprice1 
rename district origin1 
rename cell cellorigin1
// ici je prend le prix le plus bas parmi les prix moyens dans les cells appartenant a un meme district. 
//Mon origin outdisrict me precise juste un district et non un cell.
//Jai donc plusieurs possiblites de prix possibles a lintrieur dun district
// Je fais le choix de prendre le minimum

bys  product origin1  month year: egen priceoutdistrict1= min(av_distrprice1)
sort product year month origin1 cellorigin1 
drop av_distrprice1
drop cellorigin1
duplicates drop
save outdistrict3,replace





* merger avec la base mere pour avoir les prix outdistrict1 
clear all
use basecell

merge m:1 product origin1 year month using outdistrict3,keep(master match) 

drop _merge
sort product year month district
replace price_origin1=priceoutdistrict1  if  str_origin1=="3"
order product marketname_str district cell availability month year price_dest1 priceoutdistrict1  origin1 price_origin1

save basecell2,replace


****outdistrict pour vendeur2*************
clear all
use basecell2

keep product district cell month year av_distrprice2
rename district origin2
bys  product origin2 month year: egen priceoutdistrict2= min(av_distrprice2)
sort product year month origin2 cell
drop cell av_distrprice2
duplicates drop

save outdistrict4,replace

* merger avec la base mere pour avoir les prix outdistrict2**********
clear all
use basecell2

merge m:1 product origin2 year month using outdistrict4,keep(master match) 

drop _merge
sort product year month district
replace price_origin2=priceoutdistrict2  if  str_origin2=="3"
order product marketname_str district cell availability month year price_dest1 priceoutdistrict1  origin1 price_origin1 price_dest2 priceoutdistrict2  origin1 price_origin2



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







save basecell03oct,replace




