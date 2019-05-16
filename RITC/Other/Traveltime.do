
/* *************************************************************************** *
*					compute travel time Intra-national Trade costs Paper						   												   
*																 			   *
*  PURPOSE:  									   		  
*  WRITEN BY:  			Ewane	   
*  Last time modified:  November 20 , 2018											   *
*																			   *
********************************************************************************
*/

*******************************************************************************
*						Set your own path directories 
********************************************************************************/


clear all
global Path "/Users/williamewane/Dropbox/IntraTradeCost_Rwanda/Data/construction_database_rwanda"
cd "$Path"

//////////compute travel time and travel distance/////////////////////////

clear
use finaldataset

keep if product=="Goat"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time1


clear
use finaldataset

keep if product=="Rabbit"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time2



clear all
use finaldataset

keep if product=="airtime"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time3





clear all
use finaldataset

keep if product=="amarante"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time4



clear all
use finaldataset

keep if product=="banana"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time5



clear all
use finaldataset

keep if product=="beef"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time6


clear all
use finaldataset

keep if product=="brochette"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time7


clear all
use finaldataset

keep if product=="cabbage"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time8

clear all
use finaldataset

keep if product=="candle"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time9


clear all
use finaldataset

keep if product=="carrots"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time10

clear all
use finaldataset

keep if product=="cassava_flour"
//travel time seller1
georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time11

clear all
use finaldataset

keep if product=="cassava_leaves"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time12


clear all
use finaldataset

keep if product=="cassava_root"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time13

clear all
use finaldataset

keep if product=="celery"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time14

clear all
use finaldataset

keep if product=="charcoal"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time15


clear all
use finaldataset

keep if product=="comm_beer"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time16

clear all
use finaldataset

keep if product=="cook_banana"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time17

clear all
use finaldataset

keep if product=="cook_oil"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time18

clear all
use finaldataset

keep if product=="detergent"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time19

clear all
use finaldataset

keep if product=="dress"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time20

clear all
use finaldataset

keep if product=="dry_beans"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time21
clear all
use finaldataset

keep if product=="echarpe"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time22

clear all
use finaldataset

keep if product=="egg"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time23

clear all
use finaldataset

keep if product=="fish"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time24

clear all
use finaldataset

keep if product=="garlic"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time25

clear all
use finaldataset

keep if product=="gitenge"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time26

clear all
use finaldataset

keep if product=="green_pea"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time27

clear all
use finaldataset

keep if product=="grnd_nut_flr"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time28

clear all
use finaldataset

keep if product=="ground_nut"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time29

clear all
use finaldataset

keep if product=="hair_dye"
//travel time seller1
georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time30

clear all
use finaldataset

keep if product=="imported_rice"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time31

clear all
use finaldataset

keep if product=="irish_potato"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time32

clear all
use finaldataset

keep if product=="leek"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time33


clear all
use finaldataset

keep if product=="maggi"
//travel time seller1
georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time34
clear all
use finaldataset

keep if product=="maize"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time35

clear all
use finaldataset

keep if product=="maize_flour"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time36

clear all
use finaldataset

keep if product=="mandarine"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time37



clear all
use finaldataset

keep if product=="mattress"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time38




clear all
use finaldataset

keep if product=="milk"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time39

clear all
use finaldataset

keep if product=="mineral_water"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time40

clear all
use finaldataset

keep if product=="nails"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time41

clear all
use finaldataset

keep if product=="onion"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time42

clear all
use finaldataset

keep if product=="pants_female"
//travel time seller1
georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time43

clear all
use finaldataset

keep if product=="pants_male"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time44

clear all
use finaldataset

keep if product=="pepper"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time45

clear all
use finaldataset


clear all
use finaldataset

keep if product=="sandals"
//travel time seller1
georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time46

clear all
use finaldataset

keep if product=="sanitary_napkin"
//travel time seller1
georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time47


keep if product=="shampoo"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time48

clear all
use finaldataset

keep if product=="soap"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A)startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time49

clear all
use finaldataset

keep if product=="softdrink"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time50

clear all
use finaldataset

keep if product=="sorghum"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time51

clear all
use finaldataset

keep if product=="sorghum_flour"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time52

clear all
use finaldataset

keep if product=="spaghetti"
//travel time seller1
georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time53

clear all
use finaldataset

keep if product=="string_bean"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time54

clear all
use finaldataset

keep if product=="sugar"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time55

clear all
use finaldataset

keep if product=="suitcase"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time56

clear all
use finaldataset

keep if product=="sweet_potato"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time57

clear all
use finaldataset

keep if product=="tea_local"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time58

clear all
use finaldataset

keep if product=="toilet_paper"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time59

clear all
use finaldataset

keep if product=="tomato"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time60

clear all
use finaldataset

keep if product=="toothpaste"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time61

clear all
use finaldataset

keep if product=="tshirt"
//travel time seller1
georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time62

clear all
use finaldataset

keep if product=="whole_chicken"
//travel time seller1
georoute,hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
rename travel_distance travel_origin1
drop georoute_diagnostic
//travel time seller2 

georoute, hereid (UDWLl1BeQJe7iDF3c5sV) herecode(mWhwI8W8dDNHbMAVsVOb6A) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)

save time63



///////

append using time62 time61 time60 time59 time58 time57 time56 time55 time54 time53 //
 
time52 time51 time50 time49 time48 time47 time46 time45 time44 time43 //

time42 time41 time40 time39 time38 time37 time36 time35 time34 time33 time32//

time31 time30 time29 time28 time27 time26 time25 time24 time23 time22 //

time21 time20 time19 time18 time17 time16 time15 time14 time13 time12 //

time11 time10 time9 time8 time7 time6 time5 time4 time3 time2 time1


/////////some changes///////////////////////////////////////////////////



 drop georoute_diagnostic




