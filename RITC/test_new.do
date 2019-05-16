
//*****Solving the out-district origin prices

clear all
clear
set memory 1g
set more off

cd "C:\Users\wb357356\Dropbox\IntraTradeCost_Rwanda"

//17 septembre
//ajouterles  prix dorigines des produits etrangers ()


use ".\data\construction_database_rwanda\base13sept.dta", clear


///****Change the strategy*////

***create a temporary table that will record 
tab str_origin1
tab availability if str_origin1=="3"


preserve

use ".\data\construction_database_rwanda\base13sept.dta", clear

keep province product marketname_str sector_num district_num market_uid availability cell_num month year price_dest1 price_dest2 str_origin1 str_origin2
sort product province district_num sector_num cell_num market_uid year month  
save ".\data\construction_database_rwanda\temp\destination.dta", replace

restore


preserve

use ".\data\construction_database_rwanda\base13sept.dta", clear

keep province product marketname_str sector_num district_num market_uid availability cell_num month year price_dest1 price_dest2 str_origin1 str_origin2 origin1 origin2
sort product province district_num sector_num cell_num market_uid year month  
save ".\data\construction_database_rwanda\temp\origin.dta", replace


restore



/**creates prices origin for out of district product  **/

*saler 1
clear
use ".\data\construction_database_rwanda\temp\destination.dta", clear
order product province district_num sector_num cell_num market_uid year month availability str_origin1 
*sort district cell product year month  
count
gen origin1=district_num
sort product province origin1 sector_num cell_num market_uid year month  

merge m:1 product province district_num sector_num cell_num market_uid year month  using ".\data\construction_database_rwanda\temp\origin.dta"
drop _merge

keep if str_origin1=="3"
**gen origin price equal destination price  for merge origin and destination location 
gen price_origin1 = price_dest1 
sort year month product district cell market_uid 
count
save ".\data\construction_database_rwanda\temp\price1_origin_outdistrict.dta", replace

clear 

**
*saler 2
clear
use ".\data\construction_database_rwanda\temp\destination.dta", replace
