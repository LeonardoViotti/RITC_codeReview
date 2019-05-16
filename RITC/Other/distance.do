/*
Aim: compute distance and remoteness for descripitves stats
date:  sept 25
output: bascell27sep
*/


///// do for distance base cell////////////////////////


clear all
//cd "C:\Users\wb357356\Dropbox\IntraTradeCost_Rwanda\data"
cd "C:\Users\wb357356\Dropbox\IntraTradeCost_Rwanda\data\construction_database_rwanda"

use .\temp\basecell27sept

// generate coordinates for origins

gen lat_origin1=.
gen lon_origin1=.
gen lat_origin2=.
gen lon_origin2=.

//coordinates for outside rwanda origin and in-village origin

** in-village
replace lat_origin1=market_loclatitude if origin1==marketname_str
replace lon_origin1=market_loclongitude if origin1==marketname_str
replace lat_origin2=market_loclatitude if origin2==marketname_str
replace lon_origin2=market_loclongitude if origin2==marketname_str

**outside rwanda

replace lat_origin1= -1.575886    if  origin1== "Byumba"
replace lon_origin1= 30.06837    if  origin1== "Byumba"

replace lat_origin1=-2.649627     if  origin1== "Rugalika"
replace lon_origin1= 29.60961   if  origin1== "Rugalika"

replace lat_origin1=  -1.833001   if  origin1== "Gisenyi"
replace lon_origin1= 30.35387     if  origin1== "Gisenyi"

replace lat_origin1=  -1.41867    if  origin1== "Butaro"
replace lon_origin1=  29.83616    if  origin1== "Butaro"





replace lat_origin2= -1.575886    if  origin2== "Byumba"
replace lon_origin2= 30.06837    if  origin2== "Byumba"

replace lat_origin2=-2.649627     if  origin2== "Rugalika"
replace lon_origin2= 29.60961   if  origin2== "Rugalika"

replace lat_origin2=  -1.833001   if  origin2== "Gisenyi"
replace lon_origin2= 30.35387     if  origin2== "Gisenyi"

replace lat_origin2=  -1.41867    if  origin2== "Butaro"
replace lon_origin2=  29.83616    if  origin2== "Butaro"



** outdistrict/indistrict (origin1)

replace lat_origin1= -2.23456     if origin1=="Bugesera"
replace lon_origin1=  30.14825    if origin1=="Bugesera"


replace lat_origin1= -1.47394     if origin1=="Burera"
replace lon_origin1= 29.83468     if origin1=="Burera"

replace lat_origin1=  -1.6891    if origin1=="Gakenke"
replace lon_origin1=  29.78543    if origin1=="Gakenke"

replace lat_origin1=  -1.59185    if origin1=="Gatsibo"
replace lon_origin1=  30.45535    if origin1=="Gatsibo"

replace lat_origin1=  -1.61647    if origin1=="Gicumbi"
replace lon_origin1=  30.12104    if origin1=="Gicumbi"

replace lat_origin1=  -2.61811    if origin1=="Gisagara"
replace lon_origin1=   29.85022   if origin1=="Gisagara"

replace lat_origin1=  -2.51701    if origin1=="Huye"
replace lon_origin1=   29.69603   if origin1=="Huye"

replace lat_origin1=   -2.1296   if origin1=="Karongi"
replace lon_origin1=  29.36172    if origin1=="Karongi"

replace lat_origin1=  -1.93912    if origin1=="Muhanga"
replace lon_origin1=  29.7185    if origin1=="Muhnaga"

replace lat_origin1=  -1.50763    if origin1=="Musanze"
replace lon_origin1=   29.60662   if origin1=="Musanze"

replace lat_origin1= -2.18532     if origin1=="Ngoma"
replace lon_origin1=   30.46961   if origin1=="Ngoma"

replace lat_origin1= -1.87822     if origin1=="Ngorero"
replace lon_origin1= 29.56904     if origin1=="Ngorero"

replace lat_origin1=   -1.65275   if origin1=="Nyabihu"
replace lon_origin1=  29.50684    if origin1=="Nyabihu"

replace lat_origin1=  -1.31455    if origin1=="Nyagatare"
replace lon_origin1=   30.37242   if origin1=="Nyagatare"

replace lat_origin1=  -2.36154    if origin1=="Nyamasheke"
replace lon_origin1=  29.14791    if origin1=="Nyamasheke"

replace lat_origin1=  -2.629845    if origin1=="Nyaruguru"
replace lon_origin1=  29.52369    if origin1=="Nyaruguru"

replace lat_origin1=   -1.68126   if origin1=="Rubavu"
replace lon_origin1=   29.32932   if origin1=="Rubavu"

replace lat_origin1=   -1.73828   if origin1=="Rulindo"
replace lon_origin1=  29.99794    if origin1=="Rulindo"

replace lat_origin1= -2.57016     if origin1=="Rusizi"
replace lon_origin1=  29.07535    if origin1=="Rusizi"

replace lat_origin1=   -1.9145   if origin1=="Rutsiro"
replace lon_origin1=   29.31507   if origin1=="Rutsiro"

replace lat_origin1=  -1.97281    if origin1=="Rwamagana"
replace lon_origin1=   30.35428   if origin1== "Rwamagana"

replace lat_origin1=  -2.25659    if origin1=="Kirehe"
replace lon_origin1=   30.72617   if origin1=="Kirehe"



** outdistrict/indistrict (origin1)

replace lat_origin2= -2.23456     if origin2=="Bugesera"
replace lon_origin2=  30.14825    if origin2=="Bugesera"


replace lat_origin2= -1.47394     if origin2=="Burera"
replace lon_origin2= 29.83468     if origin2=="Burera"

replace lat_origin2=  -1.6891    if origin2=="Gakenke"
replace lon_origin2=  29.78543    if origin2=="Gakenke"

replace lat_origin2=  -1.59185    if origin2=="Gatsibo"
replace lon_origin2=  30.45535    if origin2=="Gatsibo"

replace lat_origin2=  -1.61647    if origin2=="Gicumbi"
replace lon_origin2=  30.12104    if origin2=="Gicumbi"

replace lat_origin2=  -2.61811    if origin2=="Gisagara"
replace lon_origin2=   29.85022   if origin2=="Gisagara"

replace lat_origin2=  -2.51701    if origin2=="Huye"
replace lon_origin2=   29.69603   if origin2=="Huye"

replace lat_origin2=   -2.1296   if origin2=="Karongi"
replace lon_origin2=  29.36172    if origin2=="Karongi"

replace lat_origin2=  -1.93912    if origin2=="Muhanga"
replace lon_origin2=  29.7185    if origin2=="Muhnaga"

replace lat_origin2=  -1.50763    if origin2=="Musanze"
replace lon_origin2=   29.60662   if origin2=="Musanze"

replace lat_origin2= -2.18532     if origin2=="Ngoma"
replace lon_origin2=   30.46961   if origin2=="Ngoma"

replace lat_origin2= -1.87822     if origin2=="Ngorero"
replace lon_origin2= 29.56904     if origin2=="Ngorero"

replace lat_origin2=   -1.65275   if origin2=="Nyabihu"
replace lon_origin2=  29.50684    if origin2=="Nyabihu"

replace lat_origin2=  -1.31455    if origin2=="Nyagatare"
replace lon_origin2=   30.37242   if origin2=="Nyagatare"

replace lat_origin2=  -2.36154    if origin2=="Nyamasheke"
replace lon_origin2=  29.14791    if origin2=="Nyamasheke"

replace lat_origin2=  -2.629845    if origin2=="Nyaruguru"
replace lon_origin2=  29.52369    if origin2=="Nyaruguru"

replace lat_origin2=   -1.68126   if origin2=="Rubavu"
replace lon_origin2=   29.32932   if origin2=="Rubavu"

replace lat_origin2=   -1.73828   if origin2=="Rulindo"
replace lon_origin2=  29.99794    if origin2=="Rulindo"

replace lat_origin2= -2.57016     if origin2=="Rusizi"
replace lon_origin2=  29.07535    if origin2=="Rusizi"

replace lat_origin2=   -1.9145   if origin2=="Rutsiro"
replace lon_origin2=   29.31507   if origin2=="Rutsiro"

replace lat_origin2=  -1.97281    if origin2=="Rwamagana"
replace lon_origin2=   30.35428   if origin2== "Rwamagana"

replace lat_origin2=  -2.25659    if origin2=="Kirehe"
replace lon_origin2=   30.72617   if origin2=="Kirehe"



// compute distance origin/destination


 ****road distance to origin
 geodist market_loclatitude market_loclongitude lat_origin1 lon_origin1, gen (dist_orign1) miles
 
geodist market_loclatitude market_loclongitude lat_origin2 lon_origin2, gen (dist_orign2) miles
 
 
** great -circle distance to origin
 
 
  geodist market_loclatitude market_loclongitude lat_origin1 lon_origin1, gen (gcdist_orign1) sphere miles
    
  geodist market_loclatitude market_loclongitude lat_origin2 lon_origin2, gen (gcdist_orign2) sphere miles
   
 
 
 **** travel_time to origin
 
 
 
 **georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
 *rename travel_distance travel_origin1
 *drop georoute_diagnostic

 *georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)
 
 
 *rename travel_distance travel_origin2
 
 *drop georoute_diagnostic

 
**** remoteness : traveltime/traveldistance/roaddistance to kigali

//add kigali

gen Maintown ="Kigali"


gen lat_Kigali= -1.939662908

gen lon_Kigali= 30.05566444


// traveltime\travel distance to Kigali


*georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (lat_Kigali  lon_Kigali) endxy(lat_origin1 lon_origin1) time(timekigali_origin1)
 *rename travel_distance travelkikali_origin1
 *drop georoute_diagnostic

 *georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (lat_Kigali  lon_Kigali) endxy(lat_origin2 lon_origin2) time(timekigali_origin2)
 
 *rename travel_distance travelkigali_origin2
 
 *drop georoute_diagnostic
 
 
geodist market_loclatitude market_loclongitude lat_Kigali lon_Kigali, gen (distmarket_kigali) miles

 
geodist lat_origin1 lon_origin1  lat_Kigali lon_Kigali, gen (distorigin1_kigali) miles


geodist lat_origin2 lon_origin2  lat_Kigali lon_Kigali, gen (distorigin2_kigali) miles


save basecell_distance27sept,replace






//// do for distance base district////////////////////////


clear all
cd "C:\Users\wb357356\Dropbox\IntraTradeCost_Rwanda\data\construction_database_rwanda"

use .\temp\basedistrict27sept

// generate coordinates for origins

gen lat_origin1=.
gen lon_origin1=.
gen lat_origin2=.
gen lon_origin2=.

//coordinates for outside rwanda origin and in-village origin

** in-village
replace lat_origin1=market_loclatitude if origin1==marketname_str
replace lon_origin1=market_loclongitude if origin1==marketname_str
replace lat_origin2=market_loclatitude if origin2==marketname_str
replace lon_origin2=market_loclongitude if origin2==marketname_str

**outside rwanda

replace lat_origin1= -1.575886    if  origin1== "Byumba"
replace lon_origin1= 30.06837    if  origin1== "Byumba"

replace lat_origin1=-2.649627     if  origin1== "Rugalika"
replace lon_origin1= 29.60961   if  origin1== "Rugalika"

replace lat_origin1=  -1.833001   if  origin1== "Gisenyi"
replace lon_origin1= 30.35387     if  origin1== "Gisenyi"

replace lat_origin1=  -1.41867    if  origin1== "Butaro"
replace lon_origin1=  29.83616    if  origin1== "Butaro"





replace lat_origin2= -1.575886    if  origin2== "Byumba"
replace lon_origin2= 30.06837    if  origin2== "Byumba"

replace lat_origin2=-2.649627     if  origin2== "Rugalika"
replace lon_origin2= 29.60961   if  origin2== "Rugalika"

replace lat_origin2=  -1.833001   if  origin2== "Gisenyi"
replace lon_origin2= 30.35387     if  origin2== "Gisenyi"

replace lat_origin2=  -1.41867    if  origin2== "Butaro"
replace lon_origin2=  29.83616    if  origin2== "Butaro"



** outdistrict/indistrict (origin1)

replace lat_origin1= -2.23456     if origin1=="Bugesera"
replace lon_origin1=  30.14825    if origin1=="Bugesera"


replace lat_origin1= -1.47394     if origin1=="Burera"
replace lon_origin1= 29.83468     if origin1=="Burera"

replace lat_origin1=  -1.6891    if origin1=="Gakenke"
replace lon_origin1=  29.78543    if origin1=="Gakenke"

replace lat_origin1=  -1.59185    if origin1=="Gatsibo"
replace lon_origin1=  30.45535    if origin1=="Gatsibo"

replace lat_origin1=  -1.61647    if origin1=="Gicumbi"
replace lon_origin1=  30.12104    if origin1=="Gicumbi"

replace lat_origin1=  -2.61811    if origin1=="Gisagara"
replace lon_origin1=   29.85022   if origin1=="Gisagara"

replace lat_origin1=  -2.51701    if origin1=="Huye"
replace lon_origin1=   29.69603   if origin1=="Huye"

replace lat_origin1=   -2.1296   if origin1=="Karongi"
replace lon_origin1=  29.36172    if origin1=="Karongi"

replace lat_origin1=  -1.93912    if origin1=="Muhanga"
replace lon_origin1=  29.7185    if origin1=="Muhnaga"

replace lat_origin1=  -1.50763    if origin1=="Musanze"
replace lon_origin1=   29.60662   if origin1=="Musanze"

replace lat_origin1= -2.18532     if origin1=="Ngoma"
replace lon_origin1=   30.46961   if origin1=="Ngoma"

replace lat_origin1= -1.87822     if origin1=="Ngorero"
replace lon_origin1= 29.56904     if origin1=="Ngorero"

replace lat_origin1=   -1.65275   if origin1=="Nyabihu"
replace lon_origin1=  29.50684    if origin1=="Nyabihu"

replace lat_origin1=  -1.31455    if origin1=="Nyagatare"
replace lon_origin1=   30.37242   if origin1=="Nyagatare"

replace lat_origin1=  -2.36154    if origin1=="Nyamasheke"
replace lon_origin1=  29.14791    if origin1=="Nyamasheke"

replace lat_origin1=  -2.629845    if origin1=="Nyaruguru"
replace lon_origin1=  29.52369    if origin1=="Nyaruguru"

replace lat_origin1=   -1.68126   if origin1=="Rubavu"
replace lon_origin1=   29.32932   if origin1=="Rubavu"

replace lat_origin1=   -1.73828   if origin1=="Rulindo"
replace lon_origin1=  29.99794    if origin1=="Rulindo"

replace lat_origin1= -2.57016     if origin1=="Rusizi"
replace lon_origin1=  29.07535    if origin1=="Rusizi"

replace lat_origin1=   -1.9145   if origin1=="Rutsiro"
replace lon_origin1=   29.31507   if origin1=="Rutsiro"

replace lat_origin1=  -1.97281    if origin1=="Rwamagana"
replace lon_origin1=   30.35428   if origin1== "Rwamagana"

replace lat_origin1=  -2.25659    if origin1=="Kirehe"
replace lon_origin1=   30.72617   if origin1=="Kirehe"



** outdistrict/indistrict (origin1)

replace lat_origin2= -2.23456     if origin2=="Bugesera"
replace lon_origin2=  30.14825    if origin2=="Bugesera"


replace lat_origin2= -1.47394     if origin2=="Burera"
replace lon_origin2= 29.83468     if origin2=="Burera"

replace lat_origin2=  -1.6891    if origin2=="Gakenke"
replace lon_origin2=  29.78543    if origin2=="Gakenke"

replace lat_origin2=  -1.59185    if origin2=="Gatsibo"
replace lon_origin2=  30.45535    if origin2=="Gatsibo"

replace lat_origin2=  -1.61647    if origin2=="Gicumbi"
replace lon_origin2=  30.12104    if origin2=="Gicumbi"

replace lat_origin2=  -2.61811    if origin2=="Gisagara"
replace lon_origin2=   29.85022   if origin2=="Gisagara"

replace lat_origin2=  -2.51701    if origin2=="Huye"
replace lon_origin2=   29.69603   if origin2=="Huye"

replace lat_origin2=   -2.1296   if origin2=="Karongi"
replace lon_origin2=  29.36172    if origin2=="Karongi"

replace lat_origin2=  -1.93912    if origin2=="Muhanga"
replace lon_origin2=  29.7185    if origin2=="Muhnaga"

replace lat_origin2=  -1.50763    if origin2=="Musanze"
replace lon_origin2=   29.60662   if origin2=="Musanze"

replace lat_origin2= -2.18532     if origin2=="Ngoma"
replace lon_origin2=   30.46961   if origin2=="Ngoma"

replace lat_origin2= -1.87822     if origin2=="Ngorero"
replace lon_origin2= 29.56904     if origin2=="Ngorero"

replace lat_origin2=   -1.65275   if origin2=="Nyabihu"
replace lon_origin2=  29.50684    if origin2=="Nyabihu"

replace lat_origin2=  -1.31455    if origin2=="Nyagatare"
replace lon_origin2=   30.37242   if origin2=="Nyagatare"

replace lat_origin2=  -2.36154    if origin2=="Nyamasheke"
replace lon_origin2=  29.14791    if origin2=="Nyamasheke"

replace lat_origin2=  -2.629845    if origin2=="Nyaruguru"
replace lon_origin2=  29.52369    if origin2=="Nyaruguru"

replace lat_origin2=   -1.68126   if origin2=="Rubavu"
replace lon_origin2=   29.32932   if origin2=="Rubavu"

replace lat_origin2=   -1.73828   if origin2=="Rulindo"
replace lon_origin2=  29.99794    if origin2=="Rulindo"

replace lat_origin2= -2.57016     if origin2=="Rusizi"
replace lon_origin2=  29.07535    if origin2=="Rusizi"

replace lat_origin2=   -1.9145   if origin2=="Rutsiro"
replace lon_origin2=   29.31507   if origin2=="Rutsiro"

replace lat_origin2=  -1.97281    if origin2=="Rwamagana"
replace lon_origin2=   30.35428   if origin2== "Rwamagana"

replace lat_origin2=  -2.25659    if origin2=="Kirehe"
replace lon_origin2=   30.72617   if origin2=="Kirehe"



// compute distance origin/destination


 ****road distance to origin
 geodist market_loclatitude market_loclongitude lat_origin1 lon_origin1, gen (dist_orign1) miles
 
geodist market_loclatitude market_loclongitude lat_origin2 lon_origin2, gen (dist_orign2) miles
 
 
** great -circle distance to origin
 
 
  geodist market_loclatitude market_loclongitude lat_origin1 lon_origin1, gen (gcdist_orign1) sphere miles
    
  geodist market_loclatitude market_loclongitude lat_origin2 lon_origin2, gen (gcdist_orign2) sphere miles
   
 
 
 **** travel_time to origin
 clear
 
 use "basecell4regression"
georoute if province=="East" , hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
 
 **georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
 *rename travel_distance travel_origin1
 *drop georoute_diagnostic

 *georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)
 
 
 *rename travel_distance travel_origin2
 
 *drop georoute_diagnostic

 
**** remoteness : traveltime/traveldistance/roaddistance to kigali

//add kigali

gen Maintown ="Kigali"


gen lat_Kigali= -1.939662908

gen lon_Kigali= 30.05566444


// traveltime\travel distance to Kigali


*georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (lat_Kigali  lon_Kigali) endxy(lat_origin1 lon_origin1) time(timekigali_origin1)
 *rename travel_distance travelkikali_origin1
 *drop georoute_diagnostic

 *georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (lat_Kigali  lon_Kigali) endxy(lat_origin2 lon_origin2) time(timekigali_origin2)
 
 *rename travel_distance travelkigali_origin2
 
 *drop georoute_diagnostic
 
 
geodist market_loclatitude market_loclongitude lat_Kigali lon_Kigali, gen (distmarket_kigali) miles

 
geodist lat_origin1 lon_origin1  lat_Kigali lon_Kigali, gen (distorigin1_kigali) miles


geodist lat_origin2 lon_origin2  lat_Kigali lon_Kigali, gen (distorigin2_kigali) miles


save basedistrict_distance27sept,replace




