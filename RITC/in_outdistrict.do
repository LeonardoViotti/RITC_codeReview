*19 SEPTEMBRE
*Name: in_outpricedistrict
*Aim: Compare with theo output and start descriptive stats
//traitement des in district (on prend la moyenne ds le district car la moyenne dans le cell ou dans le secteur est equivalent au prix dans le village)
clear
cd "C:\Users\wb535383\Desktop\construction_database_rwanda"

use base13sept

*****indistrict pour origin1
tab str_origin1
bys availability: tab str_origin1 
sort province district sector availability year month price_dest1
destring price_origin1, replace 

bys product district year month: egen av_distrprice1=mean(price_dest1)
replace price_origin1 = av_distrprice1 if str_origin1=="2"
order product av_distrprice1 price_dest1 price_origin1 availability district cell year month marketname_str origin1 str_origin1 sector
sort product year month district




*****indistrict pour origin 2*********************

tab str_origin2
bys availability: tab str_origin2 
sort province district sector availability year month price_dest2
destring price_origin1, replace 

count if price_origin2==. & str_origin2=="2" 
bys product district year month: egen av_distrprice2=mean(price_dest2)
replace price_origin2 = av_distrprice2 if str_origin2=="2"

order product av_distrprice1 price_dest1 price_origin1 origin1  str_origin1  av_distrprice2 price_dest2 price_origin2 origin2 str_origin2 availability district cell year month  sector

sort product year month district



// traitement des in-village
replace price_origin1 = price_dest1 if str_origin1=="1"
replace price_origin2=price_dest2  if str_origin1=="2"

save baseindistrict, replace


//traitement des out of district

****outdistrict pour vendeur1*************



*creer une base qui isole les prix outdistrict du premier vendeur (moyenne des prix par district)

clear all
use baseindistrict


keep product district  month year av_distrprice1
duplicates drop
rename district origin1 
rename av_distrprice1 priceoutdistrict1

save outdistrict1,replace





* merger avec la basse mere pour avoir les prix outdistrict1 
clear all
use baseindistrict

merge m:1 product origin1 year month using outdistrict1,keep(master match) 

drop _merge
sort product year month district
replace price_origin1=priceoutdistrict1  if  str_origin1=="3"
order product marketname_str district cell availability month year price_dest1 priceoutdistrict1  origin1 price_origin1

save baseindistrict2,replace


****outdistrict pour vendeur2*************
clear all
use baseindistrict2

keep product district  month year av_distrprice2
duplicates drop
rename district origin2 
rename av_distrprice2 priceoutdistrict2

save outdistrict2,replace

* merger avec la basse mere pour avoir les prix outdistrict2**********
clear all
use baseindistrict2

merge m:1 product origin2 year month using outdistrict2,keep(master match) 

drop _merge
sort product year month district
replace price_origin2=priceoutdistrict2  if  str_origin2=="3"
order product marketname_str district cell availability month year price_dest2 priceoutdistrict2  origin1 price_origin2


save base19sept,replace




