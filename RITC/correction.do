
**correction for multiple province/district/cell per market// jidentifie ici les marches qui appararaissent dans plusieurs province/ district


replace province ="West" if (marketname_str=="Gasiza")
replace district="Nyabihu" if (marketname_str=="Gasiza")
*replace district_num="Nyabihu" if (marketname_str=="Gasiza")
replace sector="Rambura" if (marketname_str=="Gasiza")
*replace sector_num="Rambura" if (marketname_str=="Gasiza")
replace cell="Gasiza" if (marketname_str=="Gasiza")
*replace cell_num="Gasiza" if (marketname_str=="Gasiza")

replace province ="South" if (marketname_str=="Muganza")
replace district="Nyaraguru" if (marketname_str=="Muganza")
*replace district_num="Nyaraguru" if (marketname_str=="Muganza")
replace sector="Muganza" if (marketname_str=="Muganza")
*replace sector_num="Muganza" if (marketname_str=="Muganza")
replace cell="Muganza" if (marketname_str=="Muganza")
*replace cell_num="Muganza" if (marketname_str=="Muganza")







replace province="North" if (marketname_str=="Rutare")
replace district="Gicumbi" if (marketname_str=="Rutare")
*replace district_num="Gicumbi" if (marketname_str=="Rutare")
replace sector="Rutare" if (marketname_str=="Rutare")
*replace sector_num="Rutare" if (marketname_str=="Rutare")
replace cell="Gatwaro" if (marketname_str=="Rutare")
*replace cell_num="Gatwaro" if (marketname_str=="Rutare")





replace province="North" if (marketname_str=="Remera")
replace district="Rulindo" if (marketname_str=="Remera")
*replace district_num="Rulindo" if (marketname_str=="Remera")
replace cell="Ngoma" if (marketname_str=="Remera")
*replace cell_num="Ngoma" if (marketname_str=="Remera")
replace sector="Mugote" if (marketname_str=="Remera")
*replace sector_num="Mugote" if (marketname_str=="Remera")




replace province="North" if (marketname_str=="Gaseke")
replace district="Gicumbi" if (marketname_str=="Gaseke")
*replace district_num="Gicumbi" if (marketname_str=="Gaseke")
replace cell="Gaseke" if (marketname_str=="Gaseke")
*replace cell_num="Gaseke" if (marketname_str=="Gaseke")
replace sector="Mutete" if (marketname_str=="Gaseke")
*replace sector_num="Mutete" if (marketname_str=="Gaseke")

replace province="East" if (marketname_str=="Kabarore")
replace district="Gatsibo" if (marketname_str=="Kabarore")
*replace district_num="Gatsibo" if (marketname_str=="Kabarore")
replace cell="Kabarore" if (marketname_str=="Kabarore")
*replace cell_num="Kabarore" if (marketname_str=="Kabarore")
replace sector="Kabarore" if (marketname_str=="Kabarore")
*replace sector_num="Kabarore" if (marketname_str=="Kabarore")
