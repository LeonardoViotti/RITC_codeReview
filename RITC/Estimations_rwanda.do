
/* *************************************************************************** *
*					Estimations Intra-national Trade costs Paper						   												   
*																 			   *
*  PURPOSE:  			Estimations							   		  
*  WRITEN BY:  			Ewane	   
*  Last time modified:  October 16 , 2018											   *
*																			   *
********************************************************************************
*/

*******************************************************************************
*						Set your own path directories 
********************************************************************************/


clear all
global Path "/Users/williamewane/Dropbox/IntraTradeCost_Rwanda/Data/construction_database_rwanda"
cd "$Path"



*******************************************************************************
* Baseline estimation : Price gap and distance (All pairs and trading pairs)
********************************************************************************/


*******************************Allpairs*****************************************




////////////First seller-allpairs///////////////////////////////////////////////
clear all
use allpair4regression

// generate fixed effects dimensions and some variables

egen product_time= group(product mdate)

/// convert prices in  us dollars (1us dollars= 806.25 on november 1)
gen priceA_us= priceA/806.25
gen priceB_us= priceB/806.25
gen abspricegap_allpairsus= abs(priceA_us-priceB_us)



// Estimations all pairs first seller


*** all distances
 eststo model1:reghdfe abspricegap_allpairsus lroaddistance , absorb(product_time) cluster(product_time) 
****Big distances        
eststo model2: reghdfe abspricegap_allpairsus lroaddistance if (lroaddistance>=1.6) , absorb(product_time) cluster(product_time) 
****Small distances 
eststo model3 :reghdfe abspricegap_allpairsus lroaddistance if (lroaddistance<1.6) , absorb(product_time) cluster(product_time) 

****merge the 3 estimations********

estfe model*,labels(product_time "product_time FE")

esttab model* , se(%9.3f)  ar2 indicate(`r(indicate_fe)') replace 

********merge for latex************

esttab model* using allpairs_table.tex, se(%9.3f) ar2 indicate(`r(indicate_fe)') replace 

*addnotes(Standard errors clustered at product-time are in parentheses. \sym{*} \(p<0.05\), \sym{**} \(p<0.01\), \sym{***} \(p<0.001\)) nonotes
																				

////////////Second seller-allpairs///////////////////////////////////////////////

clear all
use allpair4regression2

// generate fixed effects dimensions and some variables

egen product_time= group(product mdate)

/// convert prices in  us dollars (1us dollars= 806.25 on november 1)
gen priceA_us= priceA/806.25
gen priceB_us= priceB/806.25
gen abspricegap_allpairsus= abs(priceA_us-priceB_us)

// Estimations all pairs second seller

*** all distances
 eststo model1:reghdfe abspricegap_allpairsus lroaddistance , absorb(product_time) cluster(product_time) 
****Big distances        
eststo model2: reghdfe abspricegap_allpairsus lroaddistance if (lroaddistance>1.6) , absorb(product_time) cluster(product_time) 
****Small distances 
 eststo model3 :reghdfe abspricegap_allpairsus lroaddistance if (lroaddistance<1.6) , absorb(product_time) cluster(product_time) 

****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 



 
 
******Trading pairs*************************************************************
clear all
use basecell4regression
use basecell03oct

/////////////////////////////////////////////////////First seller/////////////////////////////////////////////

// convert prices in  us dollars
gen price_dest1_us= price_dest1/806.25
gen price_origin1_us= price_origin1/806.25
gen pricegap_us1= price_dest1_us-price_origin1_us

// gen some variables for regressions
gen abspricegap_tradingpairs_us1= abs(price_dest1_us- price_origin1_us)
gen ldist1= ln(dist_orign1)

// genereate fixed effects dimensions

egen product_time= group(product mdate)

*keep if marketname_str!= origin1

// Estimation using absolute price gap 


*** all distances
eststo  model1: reghdfe abspricegap_tradingpairs_us1 ldist1 , absorb(product_time) cluster(product_time)

****Big distances        
eststo model2: reghdfe abspricegap_tradingpairs_us1 ldist1 if (ldist1>=1.6 ) , absorb(product_time) cluster(product_time)
  
****Small distances 
eststo model3 : reghdfe abspricegap_tradingpairs_us1 ldist1 if (ldist1<1.6 ) , absorb(product_time) cluster(product_time) 

****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 






//Estimation using pricegap
estimates clear
*** all distances
eststo model1:reghdfe pricegap_us1 ldist1  if (pricegap_us1>0) , absorb(product_time) cluster(product_time)  

****Big distances        

eststo model2 : reghdfe pricegap_us1 ldist1 if (ldist1>1.6 & pricegap_us1>0) , absorb(product_time) cluster(product_time)


****Small distances 

eststo model3: reghdfe pricegap_us1 ldist1 if (ldist1<1.6 & pricegap_us1>0) , absorb(product_time) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 



// Estimation of passs-through rates / relation  between adjusted price gap and distance




******generate variables that allow us to have sufficient  price observations(origin and destination) for ech coiple product-destination************************
egen numobs_dest1= count(price_dest1_us), by(panelid)
egen numobs_origin1= count(price_origin1_us), by(panelid)


****** We generate product-destinations couples with enough observations (15 min)****************************
egen couple1 = group(panelid) if numobs_dest1>15 & numobs_origin1>15
set more off
levelsof couple1, local(couple1s)
gen sigma_rhohat1= .
gen rhohat1 = .
foreach j of local couple1s {
  reghdfe price_dest1_us price_origin1_us if (couple1== `j')  , absorb(i.couple1 i.couple1#c.mdate) vce(robust)
  replace sigma_rhohat1 = _se[price_origin1_us] if couple1 == `j' 
  replace rhohat1 = _b[price_origin1_us] if couple1 == `j'
 
}
*** Descriptives stat on pass-through***
tabstat rhohat1, stat(mean, sd, p25 p50)


******relation between  pass-through rate et distance*****************************************

scatter rhohat1 ldist1 if (ldist1>=0 & rhohat1>=-5)

****** Non parametric relation between  pass-through rate and distance*************************

lpoly rhohat1 ldist1 if (ldist1>=0), bw(0.5) nosc ci

*********kdensity**************************************

kdensity rhohat1 , bw(0.5)
 kdensity rhohat2, bw(0.5)
 twoway (kdensity rhohat1 , bw(0.5)) kdensity rhohat2, bw(0.5)
************Winsorize value of pass-through to deal with values close to zero
*** for rhohat1 winsor =0,2
 gen rhohat1_w= rhohat1
 replace rhohat1_w=0.2 if rhohat1_w < 0.2
  replace rhohat1_w=0.2 if rhohat1_w == .
 
 *** for rhohat1 winsor =0,4
 gen rhohat11_w= rhohat1
 replace rhohat11_w=0.4 if rhohat1 < 0.4
 replace rhohat11_w=0.4 if rhohat1== .
 
 *** for rhohat1 winsor =0,6
 
 gen rhohat12_w= rhohat1
 replace rhohat12_w=0.6 if rhohat1 < 0.6
 replace rhohat12_w=0.6 if rhohat1== .
 
 *** for rhohat1 winsor =0,8
 
 gen rhohat13_w= rhohat1
 replace rhohat13_w=0.8 if rhohat1 < 0.8
 replace rhohat13_w=0.8 if rhohat1== .
 
   *****///   Adjusted price gap  and distance : nonparametric estimation 

 
 ******generate adjusted price gap and winsored adjusted price gap 

gen adj_pricegap1 =(price_dest1_us/rhohat1)-price_origin1_us
gen adj_pricegap_w1 =(price_dest1_us/rhohat1_w)-price_origin1_us
gen adj_pricegap_w11 =(price_dest1_us/rhohat11_w)-price_origin1_us   // for rhohat1 winsor =0,4
gen adj_pricegap_w12 =(price_dest1_us/rhohat12_w)-price_origin1_us  // for rhohat1 winsor =0,6
gen adj_pricegap_w13 =(price_dest1_us/rhohat13_w)-price_origin1_us  // for rhohat1 winsor =0,8
***** (adjusted price gap versus price gap)  & distance 

*lpoly adj_pricegap_w1 ldist1 if (ldist1>0),  bw(0.5) ci nosc 

 
 
 twoway (lpolyci adj_pricegap_w12 ldist1 if (pricegap_us1>0 &ldist1>0), bw(0.5)) (lpolyci pricegap_us1 ldist1 if  ( ldist1>0 & pricegap_us1>0), bw(0.5))

twoway (lpolyci adj_pricegap1 ldist1 if (ldist1>0 & pricegap_us1>0),bw(0.5)) (lpolyci pricegap_us1 ldist1 if  (ldist1>0 & pricegap_us1>0),bw(0.5))

 
 

****** ****Adjusted price gap  and distance : parametric estimation*******************


**********generate adjusted rhohat

gen adj_rhohat1 =(1-rhohat1)/rhohat1 // adjusted rhohat1
gen adj_rhohat1_w =(1-rhohat1_w)/rhohat1_w   // winsorize adjusted rhohat1
gen adj_rhohat11_w =(1-rhohat11_w)/rhohat11_w // for rhohat1 winsor =0,4
gen adj_rhohat12_w =(1-rhohat12_w)/rhohat12_w // for rhohat1 winsor =0,6
gen adj_rhohat13_w =(1-rhohat13_w)/rhohat13_w // for rhohat1 winsor =0,8
*********** generate group for destination fixed effects

egen Destination_FE=  group(market_uid)


 
*************estimation when rhohat is not winsorize
 
 estimates clear
** all distances
eststo model1:reghdfe adj_pricegap1 ldist1  if (pricegap_us1>0), absorb(product_time product_time#adj_rhohat1  Destination_FE#adj_rhohat1) cluster(product_time) 

****Big distances        

eststo model2 : reghdfe adj_pricegap1 ldist1  if (ldist1>1.6 & pricegap_us1>0  ), absorb(product_time product_time#adj_rhohat1  Destination_FE#adj_rhohat1) cluster(product_time) 


****Small distances 

eststo model3:reghdfe adj_pricegap1 ldist1 if (ldist1<1.6  &  pricegap_us1>0),absorb(product_time product_time#adj_rhohat1  Destination_FE#adj_rhohat1) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat1 "product_time#adj_rhohat1 FE")
estfe model*, labels(Destination_FE#adj_rhohat1 "Destination_FE#adj_rhohat1")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


///// estimation when rhohat1 is   winsorize at 0.4
 
 estimates clear
** all distances
reghdfe adj_pricegap_w11 ldist1 if (pricegap_us1>0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)


****Big distances        

eststo model2 : reghdfe adj_pricegap_w11 ldist1  if  (ldist1>1.6 & pricegap_us1>0 ), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat1_w) cluster(product_time)


****Small distances 

eststo model3: reghdfe adj_pricegap_w11 ldist1 if (ldist1<1.6 & pricegap_us1>0),absorb( product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat1_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat1_w "Destination_FE#adj_rhohat11_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 




///// estimation when rhohat1 is   winsorize at 0.6
 
 estimates clear
** all distances
 eststo model1:reghdfe adj_pricegap_w12 ldist1 if (pricegap_us1>0), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)


****Big distances        

eststo model2 : reghdfe adj_pricegap_w12 ldist1  if  (ldist1>1.6 & pricegap_us1>0 ), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)


****Small distances 

eststo model3: reghdfe adj_pricegap_w12 ldist1 if (ldist1<1.6 & pricegap_us1>0),absorb( product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat1_w "product_time#adj_rhohat12_w FE")
estfe model*, labels(Destination_FE#adj_rhohat1_w "Destination_FE#adj_rhohat12_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 




///// estimation when rhohat1 is   winsorize at 0.8
 
 estimates clear
** all distances
eststo model1:reghdfe adj_pricegap_w13 ldist1 if (pricegap_us1>0), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)


****Big distances        

eststo model2 : reghdfe adj_pricegap_w13 ldist1  if  (ldist1>1.6 & pricegap_us1>0 ), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)


****Small distances 

eststo model3: reghdfe adj_pricegap_w13 ldist1 if (ldist1<1.6 & pricegap_us1>0),absorb( product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat1_w "product_time#adj_rhohat13_w FE")
estfe model*, labels(Destination_FE#adj_rhohat1_w "Destination_FE#adj_rhohat13_w")

esttab model* , se r2 indicate(`r(indicate_fe)') replace 



/////compare all winsoring seller1 

preserve
keep if (pricegap_us1>0)
estimates clear
**winsor 0.2
eststo model1:reghdfe adj_pricegap_w1 ldist1 if (pricegap_us1>0) , absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)


**winsor 0.4
eststo model2:reghdfe adj_pricegap_w11 ldist1 if (pricegap_us1>0) , absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)


**winsor 0.6
eststo model3:reghdfe adj_pricegap_w12 ldist1 if (pricegap_us1>0), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)

**winsor 0.8
eststo model4:reghdfe adj_pricegap_w13 ldist1 if (pricegap_us1>0), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

restore

////kdensity rhohat1


twoway (kdensity rhohat1  if (rhohat1<2 &rhohat1>0 ), bw(0.5) xlabel(0(0.2)2)) (kdensity rhohat2 if (rhohat2<2 &rhohat2>0 ), xlabel(0(0.2)2)  bw(0.5)  )


twoway (kdensity rhohat1, bw(0.5))(kdensity rhohat2, bw(0.5))


 
///// estimation when rhohat1 is   not  winsorize

estimates clear
** all distances
eststo model1:reghdfe adj_pricegap_w1 ldist1 if (pricegap_us1>0), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)


****Big distances        

eststo model2 : reghdfe adj_pricegap_w1 ldist1  if  (ldist1>3 & pricegap_us1>0 ), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)


****Small distances 

eststo model3: reghdfe adj_pricegap_w1 ldist1 if (ldist1<3 & pricegap_us1>0),absorb( product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat1_w "product_time#adj_rhohat1_w FE")
estfe model*, labels(Destination_FE#adj_rhohat1_w "Destination_FE#adj_rhohat1_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 










////////// Second seller///////////////////////////////////////////////////////////



// Estimation using absolute price gap 

 estimates clear 
*** all distances
eststo  model1: reghdfe abspricegap_tradingpairs_us2 ldist2  , absorb(product_time) cluster(product_time)

****Big distances        
eststo model2: reghdfe abspricegap_tradingpairs_us1 ldist2 if (ldist2>1.6 ) , absorb(product_time) cluster(product_time)
  
****Small distances 
eststo model3 : reghdfe abspricegap_tradingpairs_us2 ldist2 if (ldist2<1.6 ) , absorb(product_time) cluster(product_time) 

****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 






//Estimation using pricegap
 estimates clear
*** all distances
eststo model1:reghdfe pricegap_us2 ldist2  if (pricegap_us2>0) , absorb(product_time) cluster(product_time)  

****Big distances        

eststo model2 : reghdfe pricegap_us2 ldist2 if (ldist2>1.6 & pricegap_us2>0) , absorb(product_time) cluster(product_time)


****Small distances 

eststo model3: reghdfe pricegap_us2 ldist2 if (ldist2<1.6 & pricegap_us2>0) , absorb(product_time) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")

esttab model* , se r2 indicate(`r(indicate_fe)') replace 



********** Estimation of passs-through rates / relation  between adjusted price gap and distance********************



// convert prices in  us dollars


gen price_dest2_us= price_dest2/806.25
gen price_origin2_us= price_origin2/806.25
gen pricegap_us2=price_dest2_us-price_origin2_us

// gen some variables for regressions

gen abspricegap_tradingpairs_us2= abs(price_dest2_us- price_origin2_us)
gen ldist2= ln(dist_orign2)


******generate variables that allow us to have sufficient  price observations(origin and destination) for ech coiple product-destination************************

egen numobs_dest2_us= count(price_dest2), by(panelid)
egen numobs_origin2_us= count(price_origin2), by(panelid)

**** on genere les couples produits-destinations avec suffisament d'observations(15 minimum)*****

egen couple2 = group(panelid) if numobs_dest2>15 & numobs_origin2>15                                                                 
 
set more off
levelsof couple2, local(couple2s)
gen sigma_rhohat2= .
gen rhohat2 = .
foreach j of local couple2s {
  reghdfe price_dest2_us price_origin2_us if couple2== `j'  , absorb(i.couple2 i.couple2#c.mdate) vce(robust)
  replace sigma_rhohat2 = _se[price_origin2_us] if couple2 == `j' 
  replace rhohat2 = _b[price_origin2_us] if couple2 == `j'
 
}
****************quelques stats descriptives de rhohat2***********************************************************
tabstat rhohat2, stat(mean, sd, p25 p10 p50, N)
twoway (kdensity rhohat2) (kdensity rhohat1)
******ttwoway rhohat and dist **********************************************************************************

scatter rhohat2 ldist2    if (ldist2>=0& rhohat2>=-5), ylabel(-6(2) 6,nogrid)


****** Non-parametric relation between pass-through and distance*************************************************

  lpoly rhohat2 ldist2 if ldist2>=0 
 
 
**********regression of pass-through on distance first and second seller
eststo model1:reghdfe rhohat2 ldist2 , absorb(product_time) cluster(product_time Destination_FE)
 eststo model2: reghdfe rhohat1 ldist1 , absorb(product_time) cluster(product_time Destination_FE)
 estfe model*,labels(product_time "product_time FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


******************Winsorized rhohat at 0.2 to deal with negatives values

gen rhohat2_w= rhohat2
replace rhohat2_w=0.2 if rhohat2_w < 0.2


*** for rhohat2 winsor =0,4
 gen rhohat21_w= rhohat2
 replace rhohat21_w=0.4 if rhohat2 < 0.4
 replace rhohat21_w=0.4 if rhohat2== .
 
 *** for rhohat1 winsor =0,6
 
 gen rhohat22_w= rhohat2
 replace rhohat22_w=0.6 if rhohat2 < 0.6
 replace rhohat22_w=0.6 if rhohat2== .
 
 *** for rhohat1 winsor =0,8
 
 gen rhohat23_w= rhohat2
 replace rhohat23_w=0.8 if rhohat2 < 0.8
 replace rhohat23_w=0.8 if rhohat2== .
 
    
 
 ******generate adjusted price gap and winsored adjusted price gap 

gen adj_pricegap2 =(price_dest2_us/rhohat2)-price_origin2_us
gen adj_pricegap_w2 =(price_dest2_us/rhohat2_w)-price_origin2_us
gen adj_pricegap_w21 =(price_dest2_us/rhohat21_w)-price_origin2_us
gen adj_pricegap_w22 =(price_dest2_us/rhohat22_w)-price_origin2_us
gen adj_pricegap_w23 =(price_dest2_us/rhohat23_w)-price_origin2_us







**********generate adjusted rhohat2

gen adj_rhohat2 =(1-rhohat2)/rhohat2 // adjusted rhohat2
gen adj_rhohat2_w =(1-rhohat2_w)/rhohat2_w   // winsorize adjusted rhohat2 =0.2
gen adj_rhohat21_w =(1-rhohat21_w)/rhohat21_w // for rhohat2 winsor =0,4
gen adj_rhohat22_w =(1-rhohat22_w)/rhohat22_w // for rhohat2 winsor =0,6
gen adj_rhohat23_w =(1-rhohat23_w)/rhohat23_w // for rhohat2 winsor =0,8

***** (adjusted price gap versus price gap)  & distance 




twoway (lpolyci adj_pricegap_w22 ldist2 if (ldist2>0 & pricegap_us2>0),bw(0.5)) (lpolyci pricegap_us2 ldist2 if (ldist2>0 & pricegap_us2>0),bw(0.5))


 ******** estimation when rhohat is not winsorize
 
 estimates clear
** all distances
eststo model1:reghdfe adj_pricegap2 ldist2  if (pricegap_us2>0), absorb(product_time Destination_FE) cluster(product_time)

****Big distances        

eststo model2 : reghdfe adj_pricegap2 ldist2  if (ldist1>=3 & pricegap_us2>0), absorb(product_time  Destination_FE) cluster(product_time)


****Small distances 

eststo model3:reghdfe adj_pricegap2 ldist2 if (ldist1<3 & pricegap_us2>0),absorb(product_time Destination_FE ) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2 "product_time#adj_rhohat2 FE")
estfe model*, labels(Destination_FE#adj_rhohat2 "Destination_FE#adj_rhohat2")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


///// estimation when rhohat is   winsorize
 
 *****winsor rhohat2=0.2
 estimates clear
** all distances
eststo model1:reghdfe adj_pricegap_w2 ldist2  if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat2_w  Destination_FE#adj_rhohat2_w) cluster(product_time)
 


****Big distances        

eststo model2 : reghdfe adj_pricegap_w2 ldist2  if (ldist2>=3 & pricegap_us2>0), absorb(product_time product_time#adj_rhohat2_w  Destination_FE#adj_rhohat2_w) cluster(product_time)


****Small distances 

eststo model3: reghdfe adj_pricegap_w2 ldist2 if (ldist2<3 & pricegap_us2>0 ),absorb(product_time product_time#adj_rhohat2_w  Destination_FE#adj_rhohat2_w) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat2_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat2_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


 
 *****winsor rhohat2=0.4
 estimates clear
** all distances
eststo model1:reghdfe adj_pricegap_w21 ldist2  if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat21_w  Destination_FE#adj_rhohat21_w) cluster(product_time)
 


****Big distances        

eststo model2 : reghdfe adj_pricegap_w21 ldist2  if (ldist2>=3 & pricegap_us2>0), absorb(product_time product_time#adj_rhohat21_w  Destination_FE#adj_rhohat21_w) cluster(product_time)


****Small distances 

eststo model3: reghdfe adj_pricegap_w21 ldist2 if (ldist2<3 & pricegap_us2>0 ),absorb(product_time product_time#adj_rhohat21_w  Destination_FE#adj_rhohat21_w) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat21_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat21_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 




 *****winsor rhohat2=0.6
 estimates clear
** all distances
reghdfe adj_pricegap_w22 ldist2  if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat22_w  Destination_FE#adj_rhohat22_w) cluster(product_time)
 


****Big distances        

eststo model2 : reghdfe adj_pricegap_w22 ldist2  if (ldist2>1.6 & pricegap_us2>0), absorb(product_time product_time#adj_rhohat22_w  Destination_FE#adj_rhohat21_w) cluster(product_time)


****Small distances 

*eststo model3: reghdfe adj_pricegap_w22 ldist2 if (ldist2<1.6 & pricegap_us2>0 ),absorb(product_time product_time#adj_rhohat22_w  Destination_FE#adj_rhohat21_w) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat22_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat22_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 






 *****winsor rhohat2=0.8
 estimates clear
** all distances
reghdfe adj_pricegap_w23 ldist2  if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat23_w  Destination_FE#adj_rhohat23_w) cluster(product_time)
 


****Big distances        

eststo model2 : reghdfe adj_pricegap_w23 ldist2  if (ldist2>=3 & pricegap_us2>0), absorb(product_time product_time#adj_rhohat23_w  Destination_FE#adj_rhohat23_w) cluster(product_time)


****Small distances 

eststo model3: reghdfe adj_pricegap_w23 ldist2 if (ldist2<3 & pricegap_us2>0 ),absorb(product_time product_time#adj_rhohat23_w  Destination_FE#adj_rhohat23_w) cluster(product_time) 


****merge the 3 estimations

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat22_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat22_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 








/////compare all winsoring seller2


estimates clear
**winsor 0.2
eststo model1:reghdfe adj_pricegap_w2 ldist2 if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat2_w Destination_FE#adj_rhohat2_w) cluster(product_time)


**winsor 0.4
eststo model2:reghdfe adj_pricegap_w21 ldist2 if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)


**winsor 0.6
eststo model3:reghdfe adj_pricegap_w22 ldist2 if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat22_w Destination_FE#adj_rhohat22_w) cluster(product_time)

**winsor 0.8
eststo model4:reghdfe adj_pricegap_w23 ldist2 if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat23_w Destination_FE#adj_rhohat23_w) cluster(product_time)

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


save  basewithpassthrough,replace

 ******manfactured****************************************************************************************

 // adding manufactured information 
 
clear all
use product
save product,replace
merge 1:m product using  basewithpassthrough
drop _merge
sort product year month district cell


//////////////////////seller 1//////////////////////////////////////////////////////////////////////////////// 
 
 /////// estimation manufactured/non-manufactured
 
 *******rhohat1 winsor at 0.2********
  estimates clear
**** Manufactured
eststo model1:reghdfe adj_pricegap_w1 ldist1  if (pricegap_us1>0 & manufactured=="Yes"), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 
***Non-manufactured 
eststo model2:reghdfe adj_pricegap_w1 ldist1  if (pricegap_us1>0 & manufactured=="No"), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat1_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 *******rhohat1 winsor at 0.4********
  estimates clear
**** Manufactured
eststo model1:reghdfe adj_pricegap_w11 ldist1  if (pricegap_us1>0 & manufactured=="Yes"), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 
***Non-manufactured 
eststo model2:reghdfe adj_pricegap_w11 ldist1  if (pricegap_us1>0 & manufactured=="No"), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
  *******rhohat1 winsor at 0.6********
  estimates clear
**** Manufactured
eststo model1:reghdfe adj_pricegap_w12 ldist1  if (pricegap_us1>0 & manufactured=="Yes"), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 
***Non-manufactured 
eststo model2:reghdfe adj_pricegap_w12 ldist1  if (pricegap_us1>0 & manufactured=="No"), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat12_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat12_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
  *******rhohat1 winsor at 0.8********
  estimates clear
**** Manufactured
eststo model1:reghdfe adj_pricegap_w13 ldist1  if (pricegap_us1>0 & manufactured=="Yes"), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)
 
***Non-manufactured 
eststo model2:reghdfe adj_pricegap_w13 ldist1  if (pricegap_us1>0 & manufactured=="No"), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat13_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat13_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 
 
 
 // feeder road
 
 ****winsor at 0.2
 preserve 
 keep if (pricegap_us1>0)
 
 estimates clear
 ****************No connection*********************************
 eststo model1:reghdfe adj_pricegap_w1 ldist1 if (pricegap_us1>0 & fedroad1km==0 & natroad1km==0), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 
******************** FEEDER ROAD ONLY (low connection)*********************************
 eststo model2:reghdfe adj_pricegap_w1 ldist1 if (pricegap_us1>0 & fedroad1km==1 & natroad1km==0), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 
****************** National Road (MIDDLE connection)*********************************
 eststo model3:reghdfe adj_pricegap_w1 ldist1 if (pricegap_us1>0 & fedroad1km==0 & natroad1km==1), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
  
 ****************** National Road (High connection)*********************************
 eststo model4:reghdfe adj_pricegap_w1 ldist1 if (pricegap_us1>0 & fedroad1km==1 & natroad1km==1), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 
 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat1_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 restore
 
 ********************************************************************************************************
 **********************************************************************************************************
 
 
  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w1 ldist1 if (pricegap_us1>0 &fedroad1km==1), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w1 ldist1  if (pricegap_us1>0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat1_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 *****winsor at 0.4
preserve
keep if  (pricegap_us1>0)
 estimates clear
  
 *****************no connection********************************************************** 
 eststo model1:reghdfe adj_pricegap_w11 ldist1 if  ( fedroad1km==0 & natroad1km==0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
  
  
 *****************With feeder road (low connection)********************************************************** 
 eststo model2:reghdfe adj_pricegap_w11 ldist1 if ( fedroad1km==1 & natroad1km==0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
  
  
 *****************With National road (middle connection)********************************************************** 
 eststo model3:reghdfe adj_pricegap_w11 ldist1 if (fedroad1km==0 & natroad1km==1), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
  
  
 *****************With National and feeder road (High connection connection)********************************************************** 
 eststo model4:reghdfe adj_pricegap_w11 ldist1 if (fedroad1km==1 & natroad1km==1), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
   
  
  estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

  
 restore
  
  
  
  
  
  
  
  
  
  
  
  
**** feeder
eststo model1:reghdfe adj_pricegap_w11 ldist1 if (pricegap_us1>0 &fedroad1km==1), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w11 ldist1  if (pricegap_us1>0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 *****winsor at 0.6
preserve
keep if pricegap_us1>0
estimates clear
 *******************No connection**********************************
 eststo model1:reghdfe adj_pricegap_w12 ldist1  if (natroad1km==0 &fedroad1km==0), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)

 *********************Feeder road only  (low connection)******************
 eststo model2:reghdfe adj_pricegap_w12 ldist1  if (natroad1km==0 &fedroad1km==1), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)

 *********************National road only  (middle connection)******************
 eststo model3:reghdfe adj_pricegap_w12 ldist1  if (natroad1km==1 &fedroad1km==0), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)

 
 *********************National road and feeder road  (High connection)******************
 eststo model4:reghdfe adj_pricegap_w12 ldist1  if (natroad1km==1 &fedroad1km==1), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)

 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 restore
 
 
 
 
 
  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w12 ldist1  if (pricegap_us1>0 &fedroad1km==1), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w12 ldist1  if (pricegap_us1>0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


 *****winsor at 0.8
 preserve
 keep if pricegap_us1>0
 estimates clear
 
**************************No connection******************************************
 eststo model1:reghdfe adj_pricegap_w13 ldist1  if ( natroad1km==0 & fedroad1km==0 ), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)

 **************************low connection****************************************
 eststo model2:reghdfe adj_pricegap_w13 ldist1  if ( natroad1km==0 & fedroad1km==1 ), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)

 **************************middle connection****************************************
 eststo model3:reghdfe adj_pricegap_w13 ldist1  if ( natroad1km==1 & fedroad1km==0), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)

 **************************high connection****************************************
 eststo model4:reghdfe adj_pricegap_w13 ldist1  if ( natroad1km==1 & fedroad1km==1 ), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)

 
 
estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 restore
 
 
 
 
  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w13 ldist1  if (pricegap_us1>0 & fedroad1km==0 ), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w13 ldist1  if (pricegap_us1>0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
  
 // National road
 
 *****winsor at 0.2

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w1 ldist1  if (pricegap_us1>0 &natroad1km==1), absorb(product_time Destination_FE) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w1 ldist1  if (pricegap_us1>0 & natroad1km==0), absorb(product_time  Destination_FE) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat1_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 *****winsor at 0.4

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w11 ldist1  if (pricegap_us1>0 &natroad1km==1), absorb(product_time Destination_FE) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w11 ldist1  if (pricegap_us1>0 & natroad1km==0), absorb(product_time Destination_FE) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 *****winsor at 0.6

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w12 ldist1  if (pricegap_us1>0 & natroad1km==1), absorb(product_time  Destination_FE) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w12 ldist1  if (pricegap_us1>0 & natroad1km==0), absorb(product_time  Destination_FE) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 




 twoway (lpolyci adj_pricegap_w13 ldist1 if (pricegap_us1>0 &ldist1>0), bw(0.5)) (lpolyci pricegap_us1 ldist1 if  ( ldist1>0 & pricegap_us1>0), bw(0.5))

 *****winsor at 0.8

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w13 ldist1  if (pricegap_us1>0 & natroad1km==1), absorb(product_time Destination_FE) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w13 ldist1  if (pricegap_us1>0 & natroad1km==0), absorb(product_time  Destination_FE) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 
 /////national road and feeder road (winsor at 0.4)
 
 
 
  estimates clear

eststo model1:reghdfe adj_pricegap_w12 ldist1  if (pricegap_us1>0 & natroad1km==1 & fedroad1km==1 ), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 

eststo model2:reghdfe adj_pricegap_w12 ldist1  if (pricegap_us1>0 & natroad1km==1 & fedroad1km==0 ), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 

eststo model3:reghdfe adj_pricegap_w12 ldist1  if (pricegap_us1>0 & natroad1km==0 & fedroad1km==1 ), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 

eststo model4:reghdfe adj_pricegap_w12 ldist1 if (pricegap_us1>0 & natroad1km==0 & fedroad1km==0 ), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat11_w "product_time#adj_rhohat12_w FE")
estfe model*, labels(Destination_FE#adj_rhohat12_w "Destination_FE#adj_rhohat12_w FE")

esttab model* , se r2 indicate(`r(indicate_fe)') replace 


 
 ///////////////////////////////////////seller 2/////////////////////////////////////////
  
 /////// estimation manufactured/non-manufactured
 
 *******rhohat2 winsor at 0.2********
  estimates clear
**** Manufactured
eststo model1:reghdfe adj_pricegap_w21 ldist2  if (pricegap_us2>0 & manufactured=="Yes"), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 
***Non-manufactured 
eststo model2:reghdfe adj_pricegap_w21 ldist2  if (pricegap_us2>0 & manufactured=="No"), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat21_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat21_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 *******rhohat2 winsor at 0.4********
  estimates clear
**** Manufactured
eststo model1:reghdfe adj_pricegap_w21 ldist2  if (pricegap_us2>0 & manufactured=="Yes"), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 
***Non-manufactured 
eststo model2:reghdfe adj_pricegap_w21 ldist2  if (pricegap_us2>0 & manufactured=="No"), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat21_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat21_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
  *******rhohat2 winsor at 0.6********
  estimates clear
**** Manufactured
eststo model1:reghdfe adj_pricegap_w22 ldist2  if (pricegap_us2>0 & manufactured=="Yes"), absorb(product_time product_time#adj_rhohat22_w Destination_FE#adj_rhohat22_w) cluster(product_time)
 
***Non-manufactured 
eststo model2:reghdfe adj_pricegap_w22 ldist2  if (pricegap_us2>0 & manufactured=="No"), absorb(product_time product_time#adj_rhohat22_w Destination_FE#adj_rhohat22_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat22_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat22_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
  *******rhohat2 winsor at 0.8********
  estimates clear
**** Manufactured
eststo model1:reghdfe adj_pricegap_w23 ldist2  if (pricegap_us2>0 & manufactured=="Yes"), absorb(product_time product_time#adj_rhohat23_w Destination_FE#adj_rhohat23_w) cluster(product_time)
 
***Non-manufactured 
eststo model2:reghdfe adj_pricegap_w23 ldist2  if (pricegap_us2>0 & manufactured=="No"), absorb(product_time product_time#adj_rhohat23_w Destination_FE#adj_rhohat23_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat23_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat23_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 
 
 
 // feeder road
 
 *****winsor at 0.2

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w2 ldist2  if (pricegap_us2>0 &fedroad1km==1), absorb(product_time product_time#adj_rhohat2_w Destination_FE#adj_rhohat2_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w2 ldist2  if (pricegap_us2>0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat2_w Destination_FE#adj_rhohat2_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat2_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat2_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 *****winsor at 0.4

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w21 ldist2  if (pricegap_us2>0 &fedroad1km==1), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w21 ldist2  if (pricegap_us2>0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat21_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat21_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 *****winsor at 0.6

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w22 ldist2  if (pricegap_us2>0 &fedroad1km==1), absorb(product_time product_time#adj_rhohat22_w Destination_FE#adj_rhohat22_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w22 ldist2  if (pricegap_us2>0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat22_w Destination_FE#adj_rhohat22_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat22_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat22_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


 *****winsor at 0.8

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w23 ldist2  if (pricegap_us2>0 &fedroad1km==1), absorb(product_time product_time#adj_rhohat23_w Destination_FE#adj_rhohat23_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w23 ldist2  if (pricegap_us2>0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat23_w Destination_FE#adj_rhohat23_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat23_w "product_time#adj_rhohat23_w FE")
estfe model*, labels(Destination_FE#adj_rhohat23_w "Destination_FE#adj_rhohat23_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 *************TERME D'INTERCATION**************************
 gen interaction= ldist2*fedroad1km
 reghdfe adj_pricegap_w23  interaction if (pricegap_us2>0 &fedroad1km==1), absorb(product_time product_time#adj_rhohat23_w Destination_FE#adj_rhohat23_w) cluster(product_time)
 
  
 // National road
 
 *****winsor at 0.2

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w2 ldist2  if (pricegap_us2>0 &natroad1km==1 ), absorb(product_time product_time#adj_rhohat2_w Destination_FE#adj_rhohat2_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w2 ldist2  if (pricegap_us2>0 & natroad1km==0), absorb(product_time product_time#adj_rhohat2_w Destination_FE#adj_rhohat2_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat2_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat2_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 *****winsor at 0.4

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w21 ldist2  if (pricegap_us2>0 &natroad1km==1 ), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w21 ldist2  if (pricegap_us2>0 & natroad1km==0 ), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat21_w "product_time#adj_rhohat21_w FE")
estfe model*, labels(Destination_FE#adj_rhohat21_w "Destination_FE#adj_rhohat21_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 *****winsor at 0.6

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w22 ldist2  if (pricegap_us2>0 & natroad1km==1), absorb(product_time  Destination_FE) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w22 ldist2  if (pricegap_us2>0 & natroad1km==0), absorb(product_time  Destination_FE) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat22_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat22_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


 *****winsor at 0.8

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w23 ldist2  if (pricegap_us2>0 & natroad1km==1), absorb(product_time  Destination_FE) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w23 ldist2  if (pricegap_us2>0 & natroad1km==0), absorb(product_time  Destination_FE) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat23_w "product_time#adj_rhohat23_w FE")
estfe model*, labels(Destination_FE#adj_rhohat23_w "Destination_FE#adj_rhohat23_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 
 /////national road and feeder road (winsor at 0.4)
 
 
 
 
 //////////////// avalaibility competitiveness and distance////////////////////////////////////////////
 
 clear all
 
 use basecell03oct
 
egen destination_FE =group(market_uid)

gen competitiveness= ln(q9_number_traders_see)

///nonparametric relation
lpoly av ldistkigali , nosc ci bw (0.5) ylab (0.74 (0.02) 0.84, nogrid)
lpoly competitiveness ldistkigali , nosc ci bw (0.5) 

//parametric estimation
eststo model1:reghdfe av ldistkigali,abs(product_time destination_FE) cluster (product_time )
eststo model2:reghdfe competitiveness  ldistkigali,abs(product_time destination_FE) cluster (product_time)

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat22_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat22_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


 scatter av   dist_orign1  
  
 
 
 ///////////////////////////////////////////////Robuteness//////////////////////////////////////////////
 
 
 
 ////////firt seller/////////////////
 
 
**destination fixed effects

reghdfe adj_pricegap_w12 ldist1 if (pricegap_us1>0), absorb( product_time product_time#adj_rhohat12_w Destination_FE) cluster(product_time)


*****destination-year fixed effects and pass-through controls


egen destination_yr = group(market_uid year)

reghdfe adj_pricegap_w12 ldist1 if (pricegap_us1>0), absorb( product_time product_time#adj_rhohat12_w destination_yr#adj_rhohat12_w) cluster(product_time)


**** destination-time fixed effect and passthrough controls
 
 egen destination_time= group(market_uid mdate)
  
reghdfe adj_pricegap_w12 ldist1 if (pricegap_us1>0), absorb(product_time product_time#adj_rhohat12_w destination_time#adj_rhohat12_w) cluster(product_time)


 
  ////////Second seller/////////////////
 
 **destination fixed effects

reghdfe adj_pricegap_w22 ldist2 if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat22_w Destination_FE) cluster(product_time)

 **** destination-time fixed effect
 
 reghdfe adj_pricegap_w22 ldist2 if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat22_w destination_time) cluster(product_time)

 *****destination-year fixed effects and pass-through controls
 reghdfe adj_pricegap_w22 ldist2 if (pricegap_us2>0), absorb(product_time product_time#adj_rhohat22_w destination_yr#adj_rhohat22_w) cluster(product_time)

 
 
 
 
 
 
 
 *** compute travel time and travel distance
 
 
  
 
 **** travel_time to origin
 
 
 
 georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (market_loclatitude market_loclongitude) endxy(lat_origin1 lon_origin1) time(time_origin1)
 rename travel_distance travel_origin1
 drop georoute_diagnostic

 georoute, hereid (fAOEdCXIXaHuZosJyUJw) herecode(XpymzZmp3hrrke6nJiXFUw) startxy (market_loclatitude market_loclongitude) endxy(lat_origin2 lon_origin2) time(time_origin2)
 
 
 rename travel_distance travel_origin2
 
 drop georoute_diagnostic

 
 
 
 ///////// price gaps and  distance////////////////////
 
 
 
twoway (lpoly abspricegap_tradingpairs_us1 ldist1 if (ldist1>0 & pricegap_us1>0), bw(0.5)) (lpoly abspricegap_tradingpairs_us2 ldist2 if (ldist2>0 &pricegap_us2>0), bw(0.5))


 
 (lpoly abspricegap_tradingpairs_us1 ldist1 if (ldist1>0 & pricegap_us1>0), bw(0.5))
 
 (lpoly abspricegap_tradingpairs_us1 ldist1 if (ldist1>0 & pricegap_us1>0), bw(0.5))
 
 
 ////// save de last version of dataset
 clear all
 use finaldataset
 
 
 
 
 
 
 
 
 
 
