*! Version 1.7 Sékou KONE 		 09Sep2019
*! Version 1.6 Sékou KONE 		 23Sep2018
*! Version 1.4 Christopher Boyer 23nov2016
*! Version 1.0 Christopher Boyer 01aug2016

/* This file cleans raw indicator csv-files 
   for two infographic posters summarizing the 
   performance of 349 municipal governments in 
   Burkina Faso. */ 
   
clear
version 13

/* =================================================== 
   =================== Identifiers =================== 
   =================================================== */

* Raw data files
local f1 `""CEB""'
local f2 `""Directeur Ecole""'
local f3 `""Directeur Formation Sanitaire""'
local f4 `""District Sanitaire""'
local f5 `""Municipalite""'
local f6 `""Access Potable Water""'

local filenames `"`f1' `f2' `f3' `f4' `f5' `f6'"'

* Unique id list
local id1 `""commune""'
local id2 `""commune school_id""'
local id3 `""commune formation_sanitaire_id""'
local id4 `""commune""'
local id5 `""commune""'

local ids `"`id1' `id2' `id3' `id4' `id5'"'
local repfiles ""
local filenames2 ""


* Loop through files again and standardize for merging
foreach file of local filenames {
	
	* Display progress
	display "   "
	display "--------"
	display "${interm}/`file' ${year}.dta" 
	
	* Load data set 
	use "${interm}/`file' ${year}.dta", clear 
	
	* Fix inconsistencies in the way communes qnd regions are named across data sets 
	
	replace region = "BOUCLE DU MOUHOUN" if region == "BOUCLE_DU_MOUHOUN" 
	replace region = "CENTRE-EST" 		 if region == "CENTRE_EST" 
	replace region = "CENTRE-NORD" 		 if region == "CENTRE_NORD" 
	replace region = "CENTRE-OUEST" 	 if region == "CENTRE_OUEST" 
	replace region = "CENTRE-SUD" 		 if region == "CENTRE_SUD" 
	replace region = "HAUTS-BASSINS" 	 if region == "HAUTS_BASSINS" 
	replace region = "PLATEAU CENTRAL" 	 if region == "PLATEAU_CENTRAL" 
	replace region = "SUD-OUEST" 		 if region == "SUD_OUEST" 
	

	replace commune = subinstr(commune, "-", "_", .) 
	
	* BOUCLE DU MOUHOUN 
	replace commune = "BOMBOROKUY" 	if commune == "BOMBORO_KUY" 
	replace commune = "BONDOKUY" 	if commune == "BONDOUKUY" 
	replace commune = "KOMBORI" 	if commune == "KOMBORI_KOURA" 
	replace commune = "POMPOI" 		if commune == "POMPOIE" 
	replace commune = "SIBY" 		if commune == "SIBI" 
	* CASCADES 
	replace commune = "WOLONKOTO" 	if commune == "WOLOKONTO" 
	* CENTRE 
	replace commune = "KOMKI-IPALA" 	 if commune == "KOMKI_IPALA" 
	replace commune = "TANGHIN-DASSOURI" if commune == "TANGHIN_DASSOURI" 
	* CENTRE-EST 
	replace commune = "BAGRE" 			  if commune == "BAGRE (TENKODOGO)" 
	replace commune = "BOUSSOUMA_GARANGO" if commune == "BOUSSOUMA" & region == "CENTRE-EST" 
	replace commune = "BOUSSOUMA GARANGO" if commune == "BOUSSOUMA_GARANGO" 
	replace commune = "COMIN-YANGA" 	  if commune == "COMIN_YANGA" | commune == "COMIN YANGA" 
	replace commune = "NIAOGHO" 		  if commune == "NIAOGO" 
	replace commune = "SANGHA" 			  if commune == "SANGA" 
	* CENTRE-NORD 
	replace commune = "BOUSSOUMA_KAYA" 		if commune == "BOUSSOUMA" & region == "CENTRE-NORD" 
	replace commune = "BOUSSOUMA KAYA" 		if commune == "BOUSSOUMA_KAYA" 
	replace commune = "NAMISSIGUIMA" 		if (commune == "NAMISSIGMA" | commune == "NAMISSIGUIMA_KAYA") /// 
												& region == "CENTRE-NORD" 
	replace commune = "ZIMTANGA" 			if commune == "ZIMTENGA" 
	* CENTRE-SUD 
	replace commune = "NOBERE" 		  		if commune == "NOBÉRÉ" 
	replace commune = "GOMBOUSSOUGOU" 		if commune == "GOMBOUSGOU" 
	* EST 
	replace commune = "FADA N'GOURMA" 		if commune == "FADA" | commune == "FADA_NGOURMA" 
	* HAUTS-BASSINS 
	replace commune = "KARANKASSO-SAMBLA" 	if commune == "KARANKASSO_SAMBLA" | commune == "KARANGASSO SAMBLA" | commune == "KARANGASSO_SAMBLA"
	replace commune = "KARANKASSO-VIGUE"  	if commune == "KARANKASSO_VIGUE" | commune == "KARANGASSO VIGUE" | commune == "KARANGASSO_VIGUE"
	replace commune = "N'DOROLA"  			if commune == "NDOROLA" 
	* NORD 
	replace commune = "ARBOLE" 					if commune == "ARBOLLE" 
	replace commune = "KOUMBRI" 				if commune == "KOUMBRIï¿½" | commune == "KOUMBRI�" 
	replace commune = "LA-TODIN" 				if commune == "LA_TODIN" | commune == "LATODIN" | commune == "LATODEN" 
	replace commune = "NAMISSIGUIMA_OUAHIGOUYA" if commune == "NAMISSIGUIMA" & region == "NORD" 
	replace commune = "NAMISSIGUIMA OUAHIGOUYA" if commune == "NAMISSIGUIMA_OUAHIGOUYA" 
	* PLATEAU CENTRAL 
	replace commune = "BOUDRY" 			if commune == "BOUDRY_" 
	replace commune = "DAPELOGO" 		if commune == "DAPELGO" 
	replace commune = "OURGOU-MANEGA"   if commune == "OURGOU_MANEGA" | commune == "OURGOU MANEGA" 
	replace commune = "ZINIARE" 		if commune == "ZINIARÉ" 
	* SAHEL 
	replace commune = "ARBINDA" 		if commune == "ARIBINDA" 
	replace commune = "POBE-MENGAO" 	if commune == "POBE_MENGAO" | commune == "POBE MENGAO" | commune == "POBEMENGAO" 
	replace commune = "TIN-AKOFF" 		if commune == "TIN_AKOFF" | commune == "TIN AKOFF" 
	replace commune = "GOROM-GOROM" 	if commune == "GOROM_GOROM" 
	* SUD-OUEST 
	replace commune = "BOUROUM-BOUROUM" if commune == "BOUROUM_BOUROUM" 
	replace commune = "GBOMBLORA" 		if commune == "GOMBLORA" 
	replace commune = "KOPER" 			if commune == "KOPPER" 
	replace commune = "PERIGBAN" 		if commune == "PERIGNAN" 
	replace commune = "SIGLE" 			if commune == "SIGLE_" 

	* Generate index for first phase communes 
	
	cap gen phase = 0 
	replace phase = 1 if /// 
			region == "CASCADES"   | region == "CENTRE-EST" 	 | region == "CENTRE-NORD" | /// 
			region == "CENTRE-SUD" | region == "PLATEAU CENTRAL" | region == "SAHEL" 
	
	label define phase 1 "PACT 1&2" 0 "PACT 2 Only" 
	label values phase phase 


	* Identify the communes with completed data 

	cap gen completed = 1 
	replace completed = 0 if /// 
		commune == "BOULSA" 			| commune == "DARGO" 		| commune == "BOALA" 			| /// 	// CENTRE-NORD 		 - 3 
		commune == "BOUSSE" 			| commune == "NIOU" 		| commune == "MOGTEDO" 			| /// 	// PLATEAU CENTRAL 	 - 7 
		commune == "TOEGHIN" 			| commune == "SOURGOUBILA" 	| commune == "DAPELOGO" 		| /// 
		commune == "OURGOU-MANEGA" 		| /// 
		commune == "DIGUEL" 			| commune == "KOUTOUGOU" 											// SAHEL 			 - 2 


keep if completed == 1 
label define completed 0 "Uncompleted" 1 "Completed", replace 
label values completed completed 

	* Save stata data set 
	save "${final}/`file'_${year}.dta", replace 
} 


/* =================================================== 
   =========== collapse/Data preparation ============= 
   =================================================== */ 

   /* This section aggregates the school and gas stock 
      data to the commune level */ 

* 1. Schooling data 
//- CEB data 
use "${final}/CEB_${year}.dta", clear 
ren total_students_sitting_exam sd_a_01total_students_sitting_ex 
ren students_admitted_exam 		sd_a_01students_admitted_exam 

save "${final}/CEB.dta", replace 

//- School director data 
use "${final}/Directeur Ecole_${year}.dta", clear 

ren functional_latrines functional_latrine 
gen number_students = number_boys + number_girls 								// Generate the number of students in the school 
order number_students, before(number_boys) 

gen sd_a_01water_source_functional 		= water_source_functional 
gen sd_a_02functional_latrines 			= functional_latrine 
gen sd_a_02number_students 				= number_students 
gen sd_a_03year_month_received_schoo 	= year_month_received_school_suppl 
gen sd_a_03week_received_school_supp 	= week_received_school_supplies 

gen sd_a_04cantine_scolaire 			= cantine_scolaire 
gen sd_a_04month_cantine_functional 	= month_cantine_functional 
gen sd_a_04food_supp	 				= food_supplies 
gen sd_a_04food_enough					= food_supplies_enough 

* Calculate indicators to be aggregated 
if ${groupnames} { 
	g functional_latrines 	= (sd_a_02functional_latrines / number_classes) >= 1 
	g latrines 				= (sd_a_02number_students / sd_a_02functional_latrines) <= 40 // Latrines new indicator, according to national standards 
	g functional_water 		= sd_a_01water_source_functional >= 9 
	g supplies_received 	= sd_a_03year_month_received_schoo - /// 
		date("10/01/${year}", "MDY", 2100) + 7 * (sd_a_03week_received_school_supp - 1) 
	g food_enough 			= sd_a_04food_enough >= 9 
} 
else { 
	replace functional_latrines = (functional_latrine / number_classes) >= 1 
	g latrines 					= (number_students / functional_latrine) <= 40 
	g functional_water 			= water_source_functional >= 9 
	g supplies_received 		= date(year_month_received_schoo, "MDY", 2100) - /// 
		date("10/01/${year}", "MDY") + 7 * (week_received_school_supp - 1) 
	g food_enough 				= food_supplies_enough >= 9 
} 

replace supplies_received 	= 0 if supplies_received < 0 
replace supplies_received 	= 364 if mi(supplies_received) | supplies_received >= 365 | supplies_received <= -200
replace functional_latrine 	= functional_latrines 
replace food_enough 		= 0 if mi(food_supplies_enough) 


* Aggregate schooling data by commune 
collapse (mean) functional_latrine latrines functional_water supplies_received food_enough, by(region province commune) 

save "${final}/Directeur Ecole.dta", replace 


* 2. Health data 
//- District sanitaire 
use "${final}/District sanitaire_${year}.dta", clear 
ren projected_deliveries_2018 		projected_deliveries 
ren assisted_deliveries_2018 		assisted_deliveries 

ren target_vaccination_bcg_2018 	target_vaccination_bcg 
ren vaccination_coverage_bcg_2018 	vaccination_coverage_bcg 

ren target_vaccination_vpo3_2018 	target_vaccination_vpo3 
ren vaccination_coverage_vpo_2018 	vaccination_coverage_vpo 

ren target_vaccination_dtchephib3_20 	target_vaccination_dtchephib3 
ren vaccination_coverage_dtchephib3_ 	vaccination_coverage_dtchephib3 

ren target_vaccination_var_2018 	target_vaccination_var 
ren vaccination_coverage_var_2018 	vaccination_coverage_var 

ren target_vaccination_vaa_2018 	target_vaccination_vaa 
ren vaccination_coverage_vaa_2018 	vaccination_coverage_vaa 

ren target_vaccination_rr1_2018 	target_vaccination_rr1 
ren vaccination_coverage_rr1_2018	vaccination_coverage_rr1 

save "${final}/District sanitaire.dta", replace 


//- Gas stock data 
use "${final}/Directeur Formation Sanitaire_${year}.dta", clear 

* Aggregate gas stock data by commune 

if !${groupnames} { 
	g sd_a_01stock_gas = stock_gas 
}
if ${year} == 2018 { 
	gen sd2 = sd_a_01stock_gas == 1 
	collapse (mean) sd2, by(region province commune) 
	rename sd2 sd_a_01stock_gas 
} 
else {
	collapse (mean) sd_a_01stock_gas, by(region province commune) 
}


save "${final}/Directeur Formation Sanitaire.dta", replace


* 3. Municipalite 
use "${final}/Municipalite_${year}.dta", clear 

ren secretaire_g_2018 		secretaire_g 
ren agent_secretaire_2018 	agent_secretaire 
ren agent_etat_civil_2018 	agent_etat_civil 
ren comptable_2018 			comptable 
ren regisseur_2018 			regisseur_recettes 
ren agent_materiel_2018 	agent_materiel_transfere 
ren agent_service_tech_2018 agent_service_techniques 
ren agent_affaires_dom_2018 agent_affaires_domaniales 

gen agent_services_statistiques = agent_etat_civil 

ren sds_2018 					 	 sds 
ren total_num_sds_2018 			 	 total_num_sds 
ren total_num_ordinary_sds_2018  	 total_num_ordinary_sds 
ren total_num_extraordinary_sds_2018 total_num_extraordinary_sds 
ren total_num_ordinary_scm_2018  	 total_num_ordinary_scm 
ren total_num_scm_2018 				 total_num_scm 
ren total_num_extraordinary_scm_2018 total_num_extraordinary_scm 

ren num_journee_redevabilite_2018 	 num_journee_redevabilite 

ren ressources_transferees_2018 	 ressources_transferees 
ren depenses_ressources_transferees_ depenses_ressources_transferees 

ren execution_equipment_procurement_ execution_equipment_procurement 

ren birth_certificates_2018 birth_certificates 


forvalues i = 1/4 { 
	replace councilor_attendance_meeting`i' = . /// 
		 if total_num_ordinary_scm >= `i' & councilor_attendance_meeting`i' == 0 
	replace councilor_attendance_meeting`i'_ch = councilor_attendance_meeting`i' 
} 

gen special_delegation = 0 
order special_delegation, before(total_num_sds) 
gen municipal_council  = 1 
order municipal_council, before(total_councilor) 

forvalues i = 1/4 { 
	gen councilor_attendance_meeting`i'sd = . if special_delegation == 0 
	order councilor_attendance_meeting`i'sd, before(municipal_council) 
} 


replace local_taxes_2018 = 1 if local_taxes_2018_amount != 0 & local_taxes_2018_amount != . 

forvalues t = 6/7 { 
replace local_taxes_201`t' = . 				if local_taxes_201`t' == 0 
replace local_taxes_forecast_201`t' = . 	if local_taxes_forecast_201`t' == 0 

replace local_taxes_201`t'_check 			= local_taxes_201`t' 
replace local_taxes_forecast_201`t'_check 	= local_taxes_forecast_201`t' 
} 

replace depenses_ressources_transferees = ressources_transferees /// 
	 if depenses_ressources_transferees < ressources_transferees 

save "${final}/Municipalite.dta", replace 


* 4. Access Potable Water 
use "${final}/Access Potable Water_${year}.dta", clear 							

keep region province commune compop2018 tauxaccess 								// Keep relevant variables 

save "${final}/Access Potable Water.dta", replace 


/* =================================================== 
   ====================== Merge ====================== 
   =================================================== */ 

gettoken file filenames : filenames 
use "${final}/`file'.dta", clear 

foreach file of local filenames { 

	merge 1:1 region commune using "${final}/`file'.dta", force nogen 

	save "${final}/merged_${year}.dta", replace 
	save "${final}/merged.dta", replace 
} 
