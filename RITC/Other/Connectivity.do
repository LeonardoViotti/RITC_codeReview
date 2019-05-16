clear all
global Path "/Users/williamewane/Dropbox/IntraTradeCost_Rwanda/Data/construction_database_rwanda"
cd "$Path"

//////////////////////////////First seller///////////////////////////////////////////
clear all
use finaldataset

********************assess the impact of connectivity on trade costs using interaction terms****************************
****generate interaction terms
gen interaction1= ldist1*fedroad1km
gen interaction2= ldist1*natroad1km
gen interaction3= ldist1*natroad1km*fedroad1km

 estimates clear
 eststo model1:reghdfe adj_pricegap_w1 ldist1    if adj_pricegap_w1 >0, absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w  )cluster(product_time)
 eststo model2:reghdfe adj_pricegap_w11 ldist1   if adj_pricegap_w11 >0 , absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 eststo model3:reghdfe adj_pricegap_w12 ldist1   if adj_pricegap_w12 >0, absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w ) cluster(product_time)
 eststo model4:reghdfe adj_pricegap_w13 ldist1   if adj_pricegap_w13 >0, absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w ) cluster(product_time)
 esttab model* , se ar2 indicate(`r(indicate_fe)') replace 
 
 
 
 
 
 estimates clear
 
 eststo model1:reghdfe adj_pricegap_w1 ldist1  interaction2 if adj_pricegap_w1 >0, absorb(product_time product_time#adj_rhohat1_w  Destination_FE#adj_rhohat1_w)cluster(product_time)
 eststo model2:reghdfe adj_pricegap_w11 ldist1  interaction2  if adj_pricegap_w11 >0 , absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 eststo model3:reghdfe adj_pricegap_w12 ldist1  interaction2 if adj_pricegap_w12 >0, absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 eststo model4:reghdfe adj_pricegap_w13 ldist1  interaction2 if adj_pricegap_w13 >0, absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)
 esttab model* , se ar2 indicate(`r(indicate_fe)') replace 
 
  estimates clear
 
 eststo model1:reghdfe adj_pricegap_w1 ldist1  interaction3  if adj_pricegap_w1 >0, absorb(product_time product_time#adj_rhohat1_w  Destination_FE#adj_rhohat1_w)cluster(product_time)
 eststo model2:reghdfe adj_pricegap_w11 ldist1  interaction3  if adj_pricegap_w11 >0 , absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 eststo model3:reghdfe adj_pricegap_w12 ldist1  interaction3 if adj_pricegap_w12 >0, absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
 eststo model4:reghdfe adj_pricegap_w13 ldist1  interaction3 if adj_pricegap_w13 >0, absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)
 esttab model* , se ar2 indicate(`r(indicate_fe)') replace  
 
 
 
 estimates clear
 eststo model1:reghdfe adj_pricegap_w1 ldist1  interaction1 interaction2  if adj_pricegap_w1 >0, absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w  )cluster(product_time)
 eststo model2:reghdfe adj_pricegap_w11 ldist1  interaction1  interaction2 if adj_pricegap_w11 >0 , absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 eststo model3:reghdfe adj_pricegap_w12 ldist1  interaction1 interaction2 if adj_pricegap_w12 >0, absorb(product_time product_time#adj_rhohat12_w  Destination_FE#adj_rhohat11_w) cluster(product_time)
 eststo model4:reghdfe adj_pricegap_w13 ldist1  interaction1  interaction2 if adj_pricegap_w13 >0, absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w ) cluster(product_time)
 esttab model* , se ar2 indicate(`r(indicate_fe)') replace 
 
 
 
 ********************assess the impact of connectivity on trade costs using subsambples***************************
 
 
 *winsor 0.2*********************
 estimates clear
 eststo model1:reghdfe adj_pricegap_w1 ldist1 if (fedroad1km==0|natroad1km==0 &  adj_pricegap_w1 >0), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 eststo model2:reghdfe adj_pricegap_w1 ldist1 if (fedroad1km==1 & natroad1km==1 &  adj_pricegap_w1 >0), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
  
estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat1_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 estimates clear
 eststo model1:reghdfe adj_pricegap_w11 ldist1 if  (fedroad1km==1 & natroad1km==0 &  adj_pricegap_w1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
  eststo model2:reghdfe adj_pricegap_w11 ldist1 if  (fedroad1km==0 | natroad1km==1 &  adj_pricegap_w1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
 esttab model* , se ar2 indicate(`r(indicate_fe)') replace
 
 
****************** National Road (MIDDLE connection)*********************************
 estimates clear
 eststo model1:reghdfe adj_pricegap_w1 ldist1 if ( natroad1km==1  & fedroad1km==0 &  adj_pricegap_w1 >0 ), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 eststo model2:reghdfe adj_pricegap_w1 ldist1 if ( natroad1km==1  | fedroad1km==0 &  adj_pricegap_w1 >0 ), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat1_w")
esttab model* , se ar2 indicate(`r(indicate_fe)') replace
  
 ****************** National Road (High connection)*********************************
 eststo model1:reghdfe adj_pricegap_w1 ldist1 if ( fedroad1km==1 & natroad1km==1  &  adj_pricegap_w1 >0), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 eststo model2:reghdfe adj_pricegap_w1 ldist1 if ( fedroad1km==0 | natroad1km==1  &  adj_pricegap_w1 >0), absorb(product_time product_time#adj_rhohat1_w Destination_FE#adj_rhohat1_w) cluster(product_time)
 
 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat1_w")
esttab model* , se ar2 indicate(`r(indicate_fe)') replace

****************winsor 0.4****************************************************

  
 *****************no connection********************************************************** 

  estimates clear
 eststo model1:reghdfe adj_pricegap_w11 ldist1 if  ( fedroad1km==0 | natroad1km==0   & pricegap_us1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
  eststo model2:reghdfe adj_pricegap_w11 ldist1 if  ( fedroad1km==1 | natroad1km==1 & pricegap_us1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat1_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

  
 *****************With feeder road (low connection)********************************************************** 
 estimates clear
 eststo model1:reghdfe adj_pricegap_w11 ldist1 if  (fedroad1km==1 & natroad1km==0 &  pricegap_us1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
  eststo model2:reghdfe adj_pricegap_w11 ldist1 if  (fedroad1km==0 | natroad1km==1 &  pricegap_us1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
esttab model* , se ar2 indicate(`r(indicate_fe)') replace 
  
 *****************With National road (middle connection)********************************************************** 
 estimates clear
 eststo model3:reghdfe adj_pricegap_w11 ldist1 if (natroad1km==1 & fedroad1km==0 &  pricegap_us1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
 eststo model4:reghdfe adj_pricegap_w11 ldist1 if (natroad1km==0 | fedroad1km==1 & pricegap_us1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
  estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat1_w FE")
esttab model* , se ar2 indicate(`r(indicate_fe)') replace 
   
  
 *****************With National and feeder road (High connection connection)********************************************************** 
  estimates clear
 eststo model3:reghdfe adj_pricegap_w11 ldist1 if (fedroad1km==1 & natroad1km==1 &  pricegap_us1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
   
 eststo model4:reghdfe adj_pricegap_w11 ldist1 if (fedroad1km==0 | natroad1km==0 &  pricegap_us1 >0), absorb(product_time product_time#adj_rhohat11_w Destination_FE#adj_rhohat11_w) cluster(product_time)
   
estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat1_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat1_w "Destination_FE#adj_rhohat11_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

   
   *****winsor at 0.6***********************************************************

estimates clear
 *******************No connection**********************************
 
 
 eststo model1:reghdfe adj_pricegap_w12 ldist1  if (adj_pricegap_w12>0), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)
eststo model2:reghdfe adj_pricegap_w12 ldist1  if (natroad1km==1 & fedroad1km==1), absorb(product_time product_time#adj_rhohat12_w Destination_FE) cluster(product_time)
estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat1_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat1_w "Destination_FE#adj_rhohat11_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

   
 *********************Feeder road only  (low connection)******************
 eststo model2:reghdfe adj_pricegap_w12 ldist1  if (fedroad1km==1), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)

 *********************National road only  (middle connection)******************
 eststo model3:reghdfe adj_pricegap_w12 ldist1  if (natroad1km==1 ), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)

 
 *********************National road and feeder road  (High connection)******************
 eststo model4:reghdfe adj_pricegap_w12 ldist1  if (natroad1km==1 &fedroad1km==1), absorb(product_time product_time#adj_rhohat12_w Destination_FE#adj_rhohat12_w) cluster(product_time)

 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat1_w "product_time#adj_rhohat12_w FE")
estfe model*, labels(Destination_FE#adj_rhohat1_w "Destination_FE#adj_rhohat12_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 *****winsor at 0.8*********************************************************************
 
 estimates clear
 
**************************No connection******************************************
 eststo model1:reghdfe adj_pricegap_w13 ldist1  if ( adj_pricegap_w13>0 ), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)

 **************************low connection****************************************
 eststo model2:reghdfe adj_pricegap_w13 ldist1  if ( fedroad1km==1 ), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)

 **************************middle connection****************************************
 eststo model3:reghdfe adj_pricegap_w13 ldist1  if ( natroad1km==1 ), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)

 **************************high connection****************************************
 eststo model4:reghdfe adj_pricegap_w13 ldist1  if ( natroad1km==1 & fedroad1km==1 ), absorb(product_time product_time#adj_rhohat13_w Destination_FE#adj_rhohat13_w) cluster(product_time)

 
 
estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat11_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat11_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 restore
 
 ///////////////////////////////seller 2////////////////////////////////////////////////////////
 
 preserve
 keep if pricegap_us2>0
 ******************winsor at 0.2**************************************************
 *********************************************************************************
 
 
 estimates clear
 **************************No connection******************************************
 *eststo model1:reghdfe adj_pricegap_w2 ldist2  if (natroad1km==0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat2_w Destination_FE#adj_rhohat2_w) cluster(product_time)

 **************************Low connection******************************************
 eststo model2:reghdfe adj_pricegap_w2 ldist2  if (natroad1km==0 & fedroad1km==1), absorb(product_time product_time#adj_rhohat2_w Destination_FE#adj_rhohat2_w) cluster(product_time)

 **************************Middle connection******************************************
 eststo model3:reghdfe adj_pricegap_w2 ldist2  if (natroad1km==1 & fedroad1km==0), absorb(product_time product_time#adj_rhohat2_w Destination_FE#adj_rhohat2_w) cluster(product_time)

 **************************High connection******************************************
 eststo model4:reghdfe adj_pricegap_w2 ldist2  if (natroad1km==1 & fedroad1km==1), absorb(product_time product_time#adj_rhohat2_w Destination_FE#adj_rhohat2_w) cluster(product_time)

 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat2_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat2_w")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 restore
 
 
 
 clear all
 use finaldataset
 *****winsor at 0.4***********************************************
 
  
  keep if  pricegap_us2>0
  estimates clear
 ***************************no connection**************************************************
 
 eststo model1:reghdfe adj_pricegap_w21 ldist2  if (natroad1km==0 | fedroad1km==0), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 
 eststo model11:reghdfe adj_pricegap_w21 ldist2  if (natroad1km==1 & fedroad1km==1), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 
 
 
 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat21_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat21_w FE")
esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


 *************************low connection**************************************************
 
 eststo model2:reghdfe adj_pricegap_w21 ldist2  if (natroad1km==0 & fedroad1km==1), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w ) cluster(product_time)
 eststo model21:reghdfe adj_pricegap_w21 ldist2  if (natroad1km==1 | fedroad1km==0), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w ) cluster(product_time)
 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat21_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat21_w FE")
esttab model* , se ar2 indicate(`r(indicate_fe)') replace 


 *************************Middle connexion**************************************************
 estimates clear
 eststo model3:reghdfe adj_pricegap_w21 ldist2  if (natroad1km==1 & fedroad1km==0), absorb(product_time  product_time#adj_rhohat21_w ) cluster(product_time)
 eststo model31:reghdfe adj_pricegap_w21 ldist2  if (natroad1km==0 | fedroad1km==1), absorb(product_time  product_time#adj_rhohat21_w ) cluster(product_time)
 estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat21_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat21_w FE")
esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 *************************High connexion**************************************************
 
 eststo model4:reghdfe adj_pricegap_w21 ldist2  if (natroad1km==1 & fedroad1km==1), absorb(product_time product_time#adj_rhohat21_w Destination_FE#adj_rhohat21_w) cluster(product_time)
 
 
estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat21_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat21_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

restore
 
 
 
 
 

 *****winsor at 0.6*********************************************************************
 ***************************************************************************************
 
 preserve
 keep if pricegap_us2>0
 estimates clear
 ******************no connexion*****************************************************
 
 eststo model1:reghdfe adj_pricegap_w22 ldist2  if (natroad1km==0 & fedroad1km==0), absorb(product_time product_time#adj_rhohat22_w Destination_FE#adj_rhohat22_w) cluster(product_time)
 
 ******************low connexion*****************************************************
 
 eststo model2:reghdfe adj_pricegap_w22 ldist2  if (natroad1km==0 & fedroad1km==1), absorb(product_time product_time#adj_rhohat22_w Destination_FE#adj_rhohat22_w) cluster(product_time)
 
 
 ******************middle connexion*****************************************************
 
 eststo model3:reghdfe adj_pricegap_w22 ldist2  if (natroad1km==1 & fedroad1km==0), absorb(product_time product_time#adj_rhohat22_w Destination_FE#adj_rhohat22_w) cluster(product_time)

 ******************highconnexion*****************************************************
 
 eststo model4:reghdfe adj_pricegap_w22 ldist2  if (natroad1km==1 & fedroad1km==1), absorb(product_time product_time#adj_rhohat22_w Destination_FE#adj_rhohat22_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat2_w "product_time#adj_rhohat22_w FE")
estfe model*, labels(Destination_FE#adj_rhohat2_w "Destination_FE#adj_rhohat22_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 
restore





 *****winsor at 0.8

  estimates clear
**** feeder
eststo model1:reghdfe adj_pricegap_w23 ldist2  if (natroad1km==1 &fedroad1km==1), absorb(product_time product_time#adj_rhohat23_w Destination_FE#adj_rhohat23_w) cluster(product_time)
 
***Non-feeder
eststo model2:reghdfe adj_pricegap_w23 ldist2  if (natroad1km==0 &fedroad1km==0), absorb(product_time product_time#adj_rhohat23_w Destination_FE#adj_rhohat23_w) cluster(product_time)
 

estfe model*,labels(product_time "product_time FE")  
estfe model*,labels (product_time#adj_rhohat23_w "product_time#adj_rhohat23_w FE")
estfe model*, labels(Destination_FE#adj_rhohat23_w "Destination_FE#adj_rhohat23_w FE")

esttab model* , se ar2 indicate(`r(indicate_fe)') replace 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
