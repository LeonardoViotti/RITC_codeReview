
//*****Solving the out-district origin prices

clear all
clear
set memory 1g
set more off

cd "C:\Users\wb357356\Dropbox\IntraTradeCost_Rwanda"

//17 septembre
//ajouterles  prix dorigines des produits etrangers ()


use ".\data\construction_database_rwanda\base13sept.dta", clear

/*
*local prod "Goat xxxx"

preserve
//foreach x of local prod"{
keep if product=="Goat"
//keep if product==`x'

tab str_origin1
bys availability: tab str_origin1 
sort province district cell availability year month price_dest1
destring price_origin1, replace 
list if str_origin1=="3" 
count if price_origin1==. & str_origin1=="3" 
bys district cell year month: egen av_distrprice=mean(price_dest1)
replace price_origin1 = av_distrprice if str_origin1=="3" 
*replace price_origin1 = price_dest1 if str_origin1=="3" & price_origin1==. & str_origin1=="3" & (origin1=="Kirehe" | origin1=="Musanze")
list if str_origin1=="3" 
keep av_distrprice district cell year month marketname_str origin1
//save origin_`x'
restore
*/


///****Chaneg the strategy*////

***create a new variable and replace value if month, location, and market are similar, or replace by mean/median district values

tab str_origin1
tab availability if str_origin1=="3"


preserve
use ".\data\construction_database_rwanda\base13sept.dta", clear

keep product marketname_str district availability cell month year price_dest1 price_dest2 str_origin1 str_origin2
sort district cell product year month  
save ".\data\construction_database_rwanda\destination.dta", replace

restore


preserve

keep product marketname_str district availability cell month year price_dest1 price_dest2 origin1 origin2 str_origin1 str_origin2
sort origin1 product year month 

save ".\data\construction_database_rwanda\origin.dta", replace


restore



/**creates prices origin for out of district product  **/

*saler 1
clear
use ".\data\construction_database_rwanda\destination.dta", clear
order product marketname_str district availability str_origin1 
*sort district cell product year month  
gen origin1=district
sort origin1 product year month 

merge m:m origin1 product year month using ".\data\construction_database_rwanda\origin.dta"
drop _merge

keep if str_origin1=="3"
**gen origin price equal destination price  for merge origin and destination location 
gen price_origin1 = price_dest1 
sort district product year month
save ".\data\construction_database_rwanda\price1_origin_outdistrict.dta", replace
clear 

**
*saler 2
clear
use ".\data\construction_database_rwanda\destination.dta", replace
order product marketname_str district availability str_origin2 
*sort district cell product year month  
gen origin2=district
sort origin2 product year month 

merge m:m origin2 product year month using ".\data\construction_database_rwanda\origin.dta"
drop _merge
keep if str_origin2=="3"

**gen origin price equal destination price for merge origin and destination location 
gen price_origin2 = price_dest2 
sort district product year month
save ".\data\construction_database_rwanda\price2_origin_outdistrict.dta", replace
clear 

*merge  the two datasets

use ".\data\construction_database_rwanda\price1_origin_outdistrict.dta", clear

merge m:m district product year month using ".\data\construction_database_rwanda\price2_origin_outdistrict.dta"
sort district product year month

save ".\data\construction_database_rwanda\price_origin_outdistrict.dta", replace

/**merge wit the main data set and replace missing price_origin **/

clear

use ".\data\construction_database_rwanda\base13sept.dta", clear
sort district product year month
merge m:m district product year month using ".\data\construction_database_rwanda\price_origin_outdistrict.dta"

