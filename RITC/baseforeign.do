
/*
Name: baseforeign.do
Date: 27 sept 2018
Aim : Build a dataset correct origin prices from outside rwanda
Input:
-baseracine 
*/

cd "C:\Users\wb535383\Desktop\construction_database_rwanda"
clear all
*cd "/Users/williamewane/Desktop/dossierbase"

use baseracine

** change origin rusumo to butaro (the nearest market from rusumo in our database)

replace origin1="Butaro" if origin1=="Rusumo"
replace origin2="Butaro" if origin2=="Rusumo"
save baseracine, replace

****** create a new database with foreign prices for the first seller
clear all
use baseracine

keep if marketname_str =="Byumba" |marketname_str =="Rugalika" |marketname_str =="Gisenyi" |marketname_str =="Butaro"
drop origin1

keep product marketname_str  month year price_dest1 

rename marketname_str origin1 
rename price_dest1 priceforeign1

save foreign1,replace


** merge with baseracine to compute priceorigin1
 
 
clear all
use baseracine
count // 162855
merge m:m product origin1 year month using foreign1, keep(master match)
count // count observations for verification (162867)

gen observation1 =_n
drop if observation1 > 162855 // the merge works well but adds 12 observations on the bottom of the database, so i drop these useless observations
count
drop _merge observation1
sort product year month marketname_str 

replace price_origin1=priceforeign1  if str_origin1== "4" // fill origin price missing for the first seller (outside rwanda)
drop priceforeign1
order product marketname_str district cell availability month year price_dest1 origin1 price_origin1
save baseorigine1,replace


************ create a new database with foreign prices for the second seller
clear all
use baseracine
count // 162855
keep if marketname_str =="Byumba" |marketname_str =="Rugalika" |marketname_str =="Gisenyi" |marketname_str =="Butaro"

keep product marketname_str  month year price_dest2

rename marketname_str origin2 
rename price_dest2 priceforeign2
save foreign2,replace


*** merge with baseorigine1 to compute priceorigin2 (second seller)

clear all
use baseorigine1
count
merge m:m product origin2 year month using foreign2,keep(master match)
count // 162864
gen observation2 =_n
drop if observation2 > 162855 // the merge works well but adds 9 observations on the bottom of the database, so i drop these useless observations
replace price_origin2=priceforeign2  if str_origin2== "4" // fill origin price missing for the second seller (outside rwanda)
drop priceforeign2
drop _merge observation2
sort product year month marketname_str 

order product marketname_str district cell availability month year price_dest1 origin1 price_origin1   price_dest2 origin2 price_origin2
save baseforeign,replace
