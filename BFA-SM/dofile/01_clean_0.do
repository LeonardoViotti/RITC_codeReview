/*================================ 2018 ================================= 
 ========================================================================*/

cd "$supermun18" 

version 13 
set seed 32674	// <- generated on Random.org at Timestamp: 2019-07-17 16:33:29 UTC 

*=============================================================================== 
*======================================= CEB =================================== 
*=============================================================================== 

clear all 
use "${raw}/CEB ${year}_WIDE.dta"												// Open raw data 


*----------- BOUCLE DU MOUHOUN ------------ 
*------------------------------------------ 

*--- Questionnaire for the commune of KOUGNY sent twice 
	// Just drop one 
drop if key == "uuid:be71e58e-4ab1-4a3b-9920-51b7eb073f77" 


*----------- CASCADES ------------ 
*--------------------------------- 


*----------- CENTRE-EST ---------- 
*--------------------------------- 

*--- Questionnaire for the commune of ZABRE sent twice 
	// The one with key = uuid:a7c0c6bb-e176-41d2-96de-2bdb7c869435 should be drop 
drop if key == "uuid:a7c0c6bb-e176-41d2-96de-2bdb7c869435" 

*--- Questionnaire for the commune of COMIN-YANGA sent twice 
	// Just drop one 
drop if key == "uuid:ef156ed3-b0cd-4ead-a937-03f90e5637b2" 


*----------- CENTRE-NORD --------- 
*--------------------------------- 

*--- Questionnaire for the commune of BOULSA sent twice 
	// Just drop one 
drop if key == "uuid:8057c1c9-7261-434c-9965-a6a0a68a95b4" 

*--- Questionnaires for the communes of DABLO and NAMISSIGUIMA sent twice and the data are not alike 
	// For each, Just drop one, and replace the data by the right information 
drop if key == "uuid:db653af7-c3ab-4d1e-89d2-94022399b278" 

replace total_students_sitting_exam 	 = 330 							if commune == "DABLO" 
replace total_boys_sitting_exam 		 = 163 							if commune == "DABLO" 
replace total_girls_sitting_exam 		 = 167 							if commune == "DABLO" 
replace students_admitted_exam 			 = 109 							if commune == "DABLO" 
replace boys_admitted_exam 				 = 50 							if commune == "DABLO" 
replace girls_admitted_exam 			 = 59 							if commune == "DABLO" 
replace total_students_sitting_exam_chec = total_students_sitting_exam 	if commune == "DABLO" 
replace total_boys_sitting_exam_check 	 = total_boys_sitting_exam 		if commune == "DABLO" 
replace total_girls_sitting_exam_check 	 = total_girls_sitting_exam		if commune == "DABLO" 
replace students_admitted_exam_check 	 = students_admitted_exam 		if commune == "DABLO" 
replace boys_admitted_exam_check 		 = boys_admitted_exam 			if commune == "DABLO" 
replace girls_admitted_exam_check 		 = girls_admitted_exam 			if commune == "DABLO" 

drop if key == "uuid:b9598bf6-f2d9-4e74-85ff-708da8f6e579" 

replace total_students_sitting_exam 	 = 347 							if commune == "NAMISSIGUIMA_KAYA" 
replace total_boys_sitting_exam 		 = 169 							if commune == "NAMISSIGUIMA_KAYA" 
replace total_girls_sitting_exam 		 = 178 							if commune == "NAMISSIGUIMA_KAYA" 
replace students_admitted_exam 			 = 129 							if commune == "NAMISSIGUIMA_KAYA" 
replace boys_admitted_exam 				 = 64 							if commune == "NAMISSIGUIMA_KAYA" 
replace girls_admitted_exam 			 = 65 							if commune == "NAMISSIGUIMA_KAYA" 
replace total_students_sitting_exam_chec = total_students_sitting_exam 	if commune == "NAMISSIGUIMA_KAYA" 
replace total_boys_sitting_exam_check 	 = total_boys_sitting_exam 		if commune == "NAMISSIGUIMA_KAYA" 
replace total_girls_sitting_exam_check 	 = total_girls_sitting_exam		if commune == "NAMISSIGUIMA_KAYA" 
replace students_admitted_exam_check 	 = students_admitted_exam 		if commune == "NAMISSIGUIMA_KAYA" 
replace boys_admitted_exam_check 		 = boys_admitted_exam 			if commune == "NAMISSIGUIMA_KAYA" 
replace girls_admitted_exam_check 		 = girls_admitted_exam 			if commune == "NAMISSIGUIMA_KAYA" 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 

*--- Questionnaire for the commune of NANDIALA sent twice 
	// The second one (key= uuid:4f34cd9c-97a1-4a38-98aa-f8769c346ecf) is the one of BINGO 
replace commune = "BINGO" if key == "uuid:4f34cd9c-97a1-4a38-98aa-f8769c346ecf" 
drop if key == "uuid:1793f917-1681-4f18-b416-e02bc5ae09f4" 


*----------- HAUTS-BASSINS ------- 
*--------------------------------- 

*--- Questionnaire for the commune of HOUNDE sent three times. The 3rd is the sum of the first two (from 2 different CEBs). 
	// Drop the first two (key = uuid:c2fae21f-25de-4443-8aa1-c8b477a5adef, and key = uuid:a843bc73-d01a-4554-93ca-c16ce45c3243) 
drop if key == "uuid:c2fae21f-25de-4443-8aa1-c8b477a5adef" | key == "uuid:a843bc73-d01a-4554-93ca-c16ce45c3243" 


*--------------- SAHEL ----------- 
*--------------------------------- 

*----------- CENTRE-OUEST -------- 
*--------------------------------- 


*=================================== SAVE DATA 

save "${interm}/CEB ${year}_clean.dta", replace 
save "${interm}/CEB ${year}.dta", replace 



*=============================================================================== 
*================================ DIRECTEUR ECOLE ============================== 
*=============================================================================== 

clear all 
use "${raw}/Directeur Ecole ${year}_WIDE.dta", clear 			  				// Open raw data 


*------- BOUCLE DU MOUHOUN ------- 
*--------------------------------- 

*--- DJIBASSO: school "SOYE" sent twice 
	// Just drop one 
drop if key == "uuid:5e86f224-49a8-49f5-99ef-8c5fdbf78b05" 

*--- DJIBASSO: school "DJIBASSO B" sent twice 
	// Just drop one 
drop if key == "uuid:235cc43c-d670-4b3f-8705-db0dbb504c19" 

*--- NOUNA: school with key == "uuid:2f4b4ad5-fbb5-44cd-9be8-215b3c276d07" to be corrected 
	// Boys: 116; Girls: 118; Teachers: 03; No canteens 
replace number_boys 			= 116					if key == "uuid:2f4b4ad5-fbb5-44cd-9be8-215b3c276d07" 
replace number_girls 			= 118 					if key == "uuid:2f4b4ad5-fbb5-44cd-9be8-215b3c276d07" 
replace number_teachers 		=   3 					if key == "uuid:2f4b4ad5-fbb5-44cd-9be8-215b3c276d07" 

replace number_boys_check    	= number_boys 			if key == "uuid:2f4b4ad5-fbb5-44cd-9be8-215b3c276d07" 
replace number_girls_check 		= number_girls 			if key == "uuid:2f4b4ad5-fbb5-44cd-9be8-215b3c276d07" 
replace number_teachers_check 	= number_teachers 		if key == "uuid:2f4b4ad5-fbb5-44cd-9be8-215b3c276d07" 

foreach var of varlist month_cantine_functional month_cantine_functional_check /// 
					   food_supplies_enough food_supplies_enough_check { 
		replace `var' = . 								if key == "uuid:2f4b4ad5-fbb5-44cd-9be8-215b3c276d07" 
} 

*--- TCHERIBA: school "TCHERIBA A" sent twice 
	// Drop the one with key = "uuid:ce75cf0d-1892-40c2-aee8-aaddaf387455" 
drop if key == "uuid:ce75cf0d-1892-40c2-aee8-aaddaf387455" 

/* 
Drop schools: 
- DJIBASSO		: drop 2 (Need 20 schools) 
- DI			: drop 1 (Need 15 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

count if commune == "DJIBASSO" 
count if commune == "DI" 
drop if rank_school > 20 & commune == "DJIBASSO" 
drop if rank_school > 15 & commune == "DI" 

drop nb_school rand_school rank_school 


*----------- CASCADES ------------ 
*--------------------------------- 

*--- KANKALABA: school "BOUGOULA" sent twice 
	// Just drop one 
drop if key == "uuid:f54efc44-c1a7-4d83-a48c-36b9559c3226" 

*--- KANKALABA: school "ZOAYIRI" sent twice 
	// Drop one with key == "uuid:b6de8f81-e199-4f8c-a584-1783b29d63aa" 
drop if key == "uuid:b6de8f81-e199-4f8c-a584-1783b29d63aa" 

*--- LOUMANA: school "CISSANA" sent twice 
	// Drop the one with key == "uuid:b1eb2dca-4e6e-417c-ad93-048750c7bf79" 
drop if key == "uuid:b1eb2dca-4e6e-417c-ad93-048750c7bf79" 

*--- TOUSSIANA: school "POUANYA NIANWARE" sent twice. Correction in the number of students 
	// Drop the one with key = "uuid:fa05c9f8-397d-410d-9e19-0003d0ffd883".
drop if key == "uuid:fa05c9f8-397d-410d-9e19-0003d0ffd883" 

replace number_boys 			= 103					if key == "uuid:d514a33f-05f9-4a2f-af61-b68f4f929a06" 
replace number_girls 			=  87 					if key == "uuid:d514a33f-05f9-4a2f-af61-b68f4f929a06" 

replace number_boys_check    	= number_boys 			if key == "uuid:d514a33f-05f9-4a2f-af61-b68f4f929a06" 
replace number_girls_check 		= number_girls 			if key == "uuid:d514a33f-05f9-4a2f-af61-b68f4f929a06" 

/* 
Drop schools: 
- DAKORO			: drop 1 (Need 10 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

count if commune == "DAKORO" 
drop if rank_school > 10 & commune == "DAKORO" 

drop nb_school rand_school rank_school 


*-------------- CENTRE ----------- 
*--------------------------------- 

*--- TANGHIN_DASSOURI: School "BALLOLE" sent twice 
	// Just drop one 
drop if key == "uuid:2d6faf2c-c017-4aab-8a5e-48af0e6d093a" 


*----------- CENTRE-EST ---------- 
*--------------------------------- 


*----------- CENTRE-NORD --------- 
*--------------------------------- 

*--- BOUROUM: School PETOUGA sent three times 
	// Drop the one with key == "uuid:6cd55558-8fd5-42a9-b655-fa4cb37fbacc"  
	// Canteen funtional should be Food enough 
drop if key == "uuid:6cd55558-8fd5-42a9-b655-fa4cb37fbacc" 

*--- TOUGOURI: School "TOUGOURI CENTRE" sent twice 
	// Just drop one 
drop if key == "uuid:42f760a6-65e1-47f0-824f-956cfc6a94ae" 

*--- ZIGA: School "BISSIGA" sent twice. 
	// key = uuid:dc4de579-86d5-4d6e-ad54-e2efb2eeb13b is good one. 
	// Supplies received Week 2, instead of Week 1. 
drop if key == "uuid:0069d8e5-236f-456c-bc28-e8368640f434" 
replace week_received_school_supplies = 2 if key == "uuid:dc4de579-86d5-4d6e-ad54-e2efb2eeb13b" 

/*
Drop schools: 
- BARSALOGHO 	: drop 12 (Need 25 schools) 
- DABLO 		: drop  6 (Need 10 schools) 
- BOUROUM 		: drop  3 (Need 20 schools) 
- TOUGOURI 		: drop  1 (Need 25 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

foreach commune in BARSALOGHO DABLO BOUROUM TOUGOURI { 
	count if commune == "`commune'" 
} 

drop if rank_school > 25 & commune == "BARSALOGHO" 
drop if rank_school > 10 & commune == "DABLO" 
drop if rank_school > 20 & commune == "BOUROUM" 
drop if rank_school > 25 & commune == "TOUGOURI" 

drop nb_school rand_school rank_school 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 

*--- THYOU: School "KOUKIN" sent twice 
	// Drop the one with key == "uuid:50078d41-3094-4ca8-95f0-dea9f3917e3a". 
drop if key == "uuid:50078d41-3094-4ca8-95f0-dea9f3917e3a" 

*--- Enumerator VALIAN Mohamadou: Issue with month school received suppmlies 
	// All schools that have received week 4 of September 
	// have received supplied week 1 of October 
replace school_supplies = 0					if (commune == "BIEHA" 	  | commune == "BOURA" | commune == "LEO" /// 
											  | commune == "NIABOURI" | commune == "SILLY" | commune == "TO") /// 
											 & year_month_received_school_suppl == "Sep 1, 2018" /// 
											 & week_received_school_supplies == 4 

replace week_received_school_supplies = 1	if (commune == "BIEHA" 	  | commune == "BOURA" | commune == "LEO" /// 
											  | commune == "NIABOURI" | commune == "SILLY" | commune == "TO") /// 
											 & year_month_received_school_suppl == "Sep 1, 2018" /// 
											 & week_received_school_supplies == 4 

replace year_month_received_school_suppl = "Oct 1, 2018" if (commune == "BIEHA"    | commune == "BOURA" | commune == "LEO"  /// 
														   | commune == "NIABOURI" | commune == "SILLY" | commune == "TO") /// 
														  & school_supplies == 0 /// 
														  & week_received_school_supplies == 1 /// 
														  & year_month_received_school_suppl == "Sep 1, 2018" 

*--- KINDI: School "NAWEKYIIRI" sent twice 
	// Drop the one with Key = "uuid:026ecf29-4ce9-4c78-bffe-3a3f5254abde". 
drop if key == "uuid:026ecf29-4ce9-4c78-bffe-3a3f5254abde" 


*----------- CENTRE-SUD ---------- 
*--------------------------------- 

*--- TOECE: School "SINCENE TOECE" sent twice 
	// Just drop one 
drop if key == "uuid:a6d5a663-fe7d-4e6d-9c0a-0674df3065c3" 

*--- LOUMBILA: School "DAGUILMA B" sent twice 
	// Just drop one 
drop if key == "uuid:dc719ead-6a58-44ce-91dd-26901665fa89" 


*-------------- EST -------------- 
*--------------------------------- 

*--- MATIACOALI: School "DATOUGOU" sent twice 
	// Drop the one with key == "uuid:5549e3c5-014d-4f72-bd29-dcdad81ba60f" 
drop if key == "uuid:426adbf6-1f8c-4531-9d75-f70332a06452" 

*--- KANTCHARI: School "NABOUAMOU" sent twice 
	// Drop the one with key == "uuid:5549e3c5-014d-4f72-bd29-dcdad81ba60f" 
drop if key == "uuid:5549e3c5-014d-4f72-bd29-dcdad81ba60f" 


*----------- HAUTS-BASSINS ------- 
*--------------------------------- 

*--- DANDE: School "BAKARIBOUGOU" sent twice 
	// Drop the one with key == "uuid:9a57292f-8fce-44c5-a14c-11bcbbfaec7a" 
drop if key == "uuid:9a57292f-8fce-44c5-a14c-11bcbbfaec7a" 

*--- DANDE: School "DANDE B" sent twice 
	// Drop the one with key == "uuid:d7a20053-990e-40ef-b610-df721442ca78" 
drop if key == "uuid:d7a20053-990e-40ef-b610-df721442ca78" 

*--- LENA: School "LENA A" sent twice 
	// Drop the one with key == "uuid:5fb0e22d-55cf-4a38-a63e-14506f4f2195" 
drop if key == "uuid:5fb0e22d-55cf-4a38-a63e-14506f4f2195" 

*--- HOUNDE: School "TOUAHO" sent twice 
	// Drop the one with key == "uuid:2fd58c4a-1bc2-42a7-8cf4-878fc8f94378" 
drop if key == "uuid:2fd58c4a-1bc2-42a7-8cf4-878fc8f94378" 

/* 
Drop schools: 
- HOUNDE		: drop  9 (Need 20 schools) 
- SINDO			: drop  1 (Need 10 schools) 
- BEREBA 		: drop  1 (Need 15 schools) 
- NDOROLA		: drop  1 (Need 15 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

foreach commune in HOUNDE SINDO BEREBA NDOROLA { 
	count if commune == "`commune'" 
} 

drop if rank_school > 20 & commune == "HOUNDE" 
drop if rank_school > 10 & commune == "SINDO" 
drop if rank_school > 15 & commune == "BEREBA" 
drop if rank_school > 15 & commune == "NDOROLA" 

drop nb_school rand_school rank_school 


*-------------- NORD ------------- 
*--------------------------------- 

*--- BANH: School "ZAMNE" sent twice 
	// Drop the one with key == "uuid:a79689d5-add9-4cff-a7e2-25416ae56dc3" 
drop if key == "uuid:a79689d5-add9-4cff-a7e2-25416ae56dc3" 

*--- TITAO: School "SOFFI" sent twice 
	// Drop the one with key == "uuid:6cfeaae6-8afe-4cb5-b67b-79e1ad9ff5d6" 
drop if key == "uuid:6cfeaae6-8afe-4cb5-b67b-79e1ad9ff5d6" 


*-------- PLATEAU CENTRAL -------- 
*--------------------------------- 

*--- SALOGO: School "ZOMNOGO" sent twice 
	// Drop the one with key == "uuid:c7e7ff9c-3f2e-4bd4-bdff-383dfadca91e" 
drop if key == "uuid:c7e7ff9c-3f2e-4bd4-bdff-383dfadca91e" 

*--- BOUDRY: School "TANSEIGA" sent twice 
	// Drop the one with key == "uuid:937e297e-538a-4eff-8430-31a3f81b2816" 
drop if key == "uuid:937e297e-538a-4eff-8430-31a3f81b2816" 

*--- ZOUNGOU: School "KUILKANDA" sent twice 
	// Drop the one with key == "uuid:ab06f096-fff5-40ff-801e-e65728760be3" 
drop if key == "uuid:ab06f096-fff5-40ff-801e-e65728760be3" 

/* 
Drop schools: 
- BOUSSE 		: drop 21 (Need 20 schools) 
- DAPELOGO 		: drop 15 (Need 20 schools) 
- NIOU 			: drop  9 (Need 20 schools) 
- OURGOU-MANEGA : drop 11 (Need 15 schools) 
- SOURGOUBILA 	: drop 11 (Need 20 schools) 
- TOEGHIN 		: drop  8 (Need 15 schools) 
*/ 
bysort commune: gen nb_school = _N 
bysort commune: gen rand_school = runiform(1, nb_school) 
sort commune rand_school 
bysort commune: gen rank_school = _n 

foreach commune in BOUSSE DAPELOGO NIOU OURGOU_MANEGA SOURGOUBILA TOEGHIN { 
	count if commune == "`commune'" 
} 

drop if rank_school > 20 & commune == "BOUSSE" 
drop if rank_school > 20 & commune == "DAPELOGO" 
drop if rank_school > 20 & commune == "NIOU" 
drop if rank_school > 15 & commune == "OURGOU_MANEGA" 
drop if rank_school > 20 & commune == "SOURGOUBILA" 
drop if rank_school > 15 & commune == "TOEGHIN" 

drop nb_school rand_school rank_school 


*------------- SAHEL ------------- 
*--------------------------------- 

*--- BOUNDORE: School "TAMPETOU" sent twice 
	// Drop the one with key == "uuid:2ec44c9d-64c9-4a86-a3d9-719b373ab045" 
drop if key == "uuid:2ec44c9d-64c9-4a86-a3d9-719b373ab045" 

*--- BOUNDRORE: School "PENKATOUGOU" sent twice 
	// Drop the one with key == "uuid:8a1759a7-a476-4805-9c57-84633fcfccbc" 
drop if key == "uuid:8a1759a7-a476-4805-9c57-84633fcfccbc" 

*--- MANSILA: School "OUSSALTANDONGOBE" sent twice 
	// Drop the one with key == "uuid:c0919d8e-7aaa-441c-b82a-dc8b28f58fff" 
drop if key == "uuid:c0919d8e-7aaa-441c-b82a-dc8b28f58fff" 

*--- FALAGOUNTOU: School "GOURARA" sent twice 
	// Just drop one 
drop if key == "uuid:5fc06217-893b-4276-8e9c-0ed70fdb055d" 

*--- SEYTENGA: School "BADOURLEBE" sent twice 
	// Drop the one with key == "uuid:e71b73ee-da3a-4243-bed6-f671f12922a4" 
drop if key == "uuid:e71b73ee-da3a-4243-bed6-f671f12922a4" 


*----------- SUD_OUEST ----------- 
*--------------------------------- 

*--- ZAMBO: School "TOVOR" sent twice 
	// Drop the one with key = "uuid:514f7668-abcb-4e5a-937f-2ec0e2e50918" 
drop if key == "uuid:514f7668-abcb-4e5a-937f-2ec0e2e50918" 

*=================================== SAVE DATA 

save "${interm}/Directeur Ecole ${year}_clean.dta", replace 
save "${interm}/Directeur Ecole ${year}.dta", replace 



*===============================================================================
*=============================== DISTRICT SANITAIRE ============================
*=============================================================================== 

clear all 
use "${raw}/District Sanitaire ${year}_WIDE.dta", clear   	  					// Open raw data 

br if region == "" | province == "" | commune == "" 

*----------- BOUCLE DU MOUHOUN ------------ 
*------------------------------------------ 

*--- Questionnaire for the commune of MADOUBA sent twice. 
	// Just drop one 
drop if key == "uuid:ad7bc666-c99b-44b5-b82b-395057cc9eb2" 

*--- Unconsistant data for RR1 in BOMBOROKUY (ZOUNGRANA Sébastien) 
	// Replace with the right value 
replace vaccination_coverage_rr1_2018 		= 843							if commune == "BOMBORO_KUY" 
replace vaccination_coverage_rr1_2018_ch    = vaccination_coverage_rr1_2018	if commune == "BOMBORO_KUY" 


*----------- CASCADES ------------
*---------------------------------

*--- Missing Projected and Assisted delivery for DAKORO, DOUNA and NIANKORODOUGOU (ZOUBGA Ousmane) 
	// Replace with the right values 
replace projected_deliveries_2018 		= 1030						if commune == "DAKORO" 
replace assisted_deliveries_2018 		=  933						if commune == "DAKORO" 
replace projected_deliveries_2018_check = projected_deliveries_2018	if commune == "DAKORO" 
replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	if commune == "DAKORO" 

replace projected_deliveries_2018 		= 709						if commune == "DOUNA" 
replace assisted_deliveries_2018 		= 378						if commune == "DOUNA" 
replace projected_deliveries_2018_check = projected_deliveries_2018	if commune == "DOUNA" 
replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	if commune == "DOUNA" 

replace projected_deliveries_2018 		= 2831						if commune == "NIANKORODOUGOU" 
replace assisted_deliveries_2018 		= 2606						if commune == "NIANKORODOUGOU" 
replace projected_deliveries_2018_check = projected_deliveries_2018	if commune == "NIANKORODOUGOU" 
replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	if commune == "NIANKORODOUGOU" 


*--- Missing Projected and Assisted delivery for all 5 communes (LOUMANA, OUELENI, KANKALABA, SINDOU, WOLONKOTO). (ZARE Malick) 
	// Replace with the right values 
replace projected_deliveries_2018 		= 1909						if commune == "LOUMANA" 
replace assisted_deliveries_2018 		= 1356						if commune == "LOUMANA" 

replace projected_deliveries_2018 		= 911						if commune == "OUELENI" 
replace assisted_deliveries_2018 		= 770						if commune == "OUELENI" 

replace projected_deliveries_2018 		= 750						if commune == "KANKALABA" 
replace assisted_deliveries_2018 		= 429						if commune == "KANKALABA" 

replace projected_deliveries_2018 		= 1395						if commune == "SINDOU" 
replace assisted_deliveries_2018 		= 1766						if commune == "SINDOU" 

replace projected_deliveries_2018 		= 305						if commune == "WOLONKOTO" 
replace assisted_deliveries_2018 		= 212						if commune == "WOLONKOTO" 

replace projected_deliveries_2018_check = projected_deliveries_2018	/// 
	 if commune == "LOUMANA" | commune == "OUELENI" | commune == "KANKALABA" | commune == "SINDOU" | commune == "WOLONKOTO" 
replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	/// 
	 if commune == "LOUMANA" | commune == "OUELENI" | commune == "KANKALABA" | commune == "SINDOU" | commune == "WOLONKOTO" 


*----------- CENTRE-EST ---------- 
*--------------------------------- 

*--- Missing Projected and Assisted delivery for all 6 communes. (TAITA Ramatou) 
	// Replace with the values 
replace projected_deliveries_2018 		= 3450						if commune == "ANDEMTENGA" 
replace projected_deliveries_2018 		= 1752						if commune == "KANDO" 
replace projected_deliveries_2018 		= 5694						if commune == "POUYTENGA" 
replace projected_deliveries_2018 		= 790						if commune == "BASKOURE" 
replace projected_deliveries_2018 		= 1290						if commune == "KOUPELA" 
replace projected_deliveries_2018 		= 2094						if commune == "GOUNGHIN" 

replace projected_deliveries_2018_check = projected_deliveries_2018	/// 
		if commune == "ANDEMTENGA" | commune == "KANDO"   | commune == "POUYTENGA" | /// 
		   commune == "BASKOURE"   | commune == "KOUPELA" | commune == "GOUNGHIN" 

replace assisted_deliveries_2018 		= 2909						if commune == "ANDEMTENGA" 
replace assisted_deliveries_2018 		= 1039						if commune == "KANDO" 
replace assisted_deliveries_2018 		= 5297						if commune == "POUYTENGA" 
replace assisted_deliveries_2018 		= 601						if commune == "BASKOURE" 
replace assisted_deliveries_2018 		= 4673						if commune == "KOUPELA" 
replace assisted_deliveries_2018 		= 1592						if commune == "GOUNGHIN" 

replace assisted_deliveries_2018_check	= assisted_deliveries_2018 /// 
		if commune == "ANDEMTENGA" | commune == "KANDO"   | commune == "POUYTENGA" | /// 
		   commune == "BASKOURE"   | commune == "KOUPELA" | commune == "GOUNGHIN" 

*--- Questionnaire for BANE sent twice. 
	// Just drop one. 
drop if key == "uuid:f4f3a147-4f76-4abb-a0df-b5d10e6a2fc8" 

*--- Questionnaire for ZONSE sent twice. 
	// Just drop one. 
drop if key == "uuid:b92002a1-8a90-4e7f-b162-bf3dfa780361" 

*--- Wrong data for KOMTOEGA. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1668 			if commune == "KOMTOEGA" 
replace vaccination_coverage_bcg_2018 	 = 1027 			if commune == "KOMTOEGA" 
replace target_vaccination_vpo3_2018 	 = 1794 			if commune == "KOMTOEGA" 
replace vaccination_coverage_vpo_2018 	 = 1061 			if commune == "KOMTOEGA" 
replace target_vaccination_dtchephib3_20 = 1794 			if commune == "KOMTOEGA" 
replace vaccination_coverage_dtchephib3_ = 1061 			if commune == "KOMTOEGA" 
replace target_vaccination_vaa_2018 	 = 1794 			if commune == "KOMTOEGA" 
replace vaccination_coverage_vaa_2018 	 = 1022 			if commune == "KOMTOEGA" 
replace target_vaccination_rr1_2018 	 = 1794 			if commune == "KOMTOEGA" 
replace vaccination_coverage_rr1_2018 	 = 1074 			if commune == "KOMTOEGA" 

/*
foreach commune in TENKODOGO BISSIGA DIALGAYE TENSOBENTENGA YARGO { 
	replace target_vaccination_bcg_2018 	 = 0.963*projected_deliveries_2018 if commune == "`commune'" 
	replace target_vaccination_vpo3_2018 	 = 0.853*projected_deliveries_2018 if commune == "`commune'" 
	replace target_vaccination_dtchephib3_20 = 0.855*projected_deliveries_2018 if commune == "`commune'" 
	replace target_vaccination_vaa_2018 	 = 0.850*projected_deliveries_2018 if commune == "`commune'" 
	replace target_vaccination_rr1_2018 	 = 0.850*projected_deliveries_2018 if commune == "`commune'" 
} 
*/ 
foreach commune in TENKODOGO BISSIGA DIALGAYE TENSOBENTENGA YARGO { 
	replace target_vaccination_bcg_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_vpo3_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_dtchephib3_20 = . 			if commune == "`commune'" 
	replace target_vaccination_vaa_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_rr1_2018 	 = . 			if commune == "`commune'" 
} 


*----------- CENTRE-NORD --------- 
*--------------------------------- 

*--- Questionnaire for the commune of KAYA sent twice. 
	// Just drop one 
drop if key == "uuid:d2284a1b-a622-419c-8fdc-0441f566c3ce" 

*--- Questionnaire for the commune of NAGBINGOU sent twice. 
	// Just drop one with key == "uuid:0ac4fcdb-b77b-443a-a596-7abfa5258866". 
drop if key == "uuid:0ac4fcdb-b77b-443a-a596-7abfa5258866" 


foreach commune in BOALA BOULSA DARGO PIBAORE PISSILA ZEGUEDEGUIN { 
	replace target_vaccination_bcg_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_vpo3_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_dtchephib3_20 = . 			if commune == "`commune'" 
	replace target_vaccination_vaa_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_rr1_2018 	 = . 			if commune == "`commune'" 
} 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 

foreach commune in KINDI REO DASSA GODYR DIDYR KORDIE /// 
				   BAKATA BOUGNOUNOU DALO GAO CASSOU SAPOUY { 
	replace target_vaccination_bcg_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_vpo3_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_dtchephib3_20 = . 			if commune == "`commune'" 
	replace target_vaccination_vaa_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_rr1_2018 	 = . 			if commune == "`commune'" 
} 


*----------- CENTRE-SUD ---------- 
*--------------------------------- 

*--- Wrong data for BERE. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1725 		if commune == "BERE" 
replace vaccination_coverage_bcg_2018 	 = 1262 		if commune == "BERE" 
replace vaccination_coverage_vpo_2018 	 = 1296 		if commune == "BERE" 
replace vaccination_coverage_dtchephib3_ = 1296 		if commune == "BERE" 
replace vaccination_coverage_vaa_2018 	 = 1201 		if commune == "BERE" 
replace vaccination_coverage_rr1_2018 	 = 1201 		if commune == "BERE" 

*--- Wrong data for BINDE. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1762 		if commune == "BINDE" 
replace vaccination_coverage_bcg_2018 	 = 1450 		if commune == "BINDE" 
replace vaccination_coverage_vpo_2018 	 = 1554 		if commune == "BINDE" 
replace vaccination_coverage_dtchephib3_ = 1554 		if commune == "BINDE" 
replace vaccination_coverage_vaa_2018 	 = 1404 		if commune == "BINDE" 
replace vaccination_coverage_rr1_2018 	 = 1404 		if commune == "BINDE" 

*--- Wrong data for GOGO. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 2102 if commune == "GOGO" 
replace vaccination_coverage_bcg_2018 	 = 1862 if commune == "GOGO" 
replace vaccination_coverage_vpo_2018 	 = 2163 if commune == "GOGO" 
replace vaccination_coverage_dtchephib3_ = 2163 if commune == "GOGO" 
replace vaccination_coverage_vaa_2018 	 = 2053 if commune == "GOGO" 
replace vaccination_coverage_rr1_2018 	 = 2053 if commune == "GOGO" 

*--- Wrong data for GOMBOUSSOUGOU. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 2482 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_bcg_2018 	 = 2891 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_vpo_2018 	 = 2739 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_dtchephib3_ = 2739 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_vaa_2018 	 = 2668 if commune == "GOMBOUSGOU" 
replace vaccination_coverage_rr1_2018 	 = 2668 if commune == "GOMBOUSGOU" 

*--- Wrong data for GUIBA. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1796 if commune == "GUIBA" 
replace vaccination_coverage_bcg_2018 	 = 1288 if commune == "GUIBA" 
replace vaccination_coverage_vpo_2018 	 = 1399 if commune == "GUIBA" 
replace vaccination_coverage_dtchephib3_ = 1399 if commune == "GUIBA" 
replace vaccination_coverage_vaa_2018 	 = 1409 if commune == "GUIBA" 
replace vaccination_coverage_rr1_2018 	 = 1409 if commune == "GUIBA" 

*--- Wrong data for MANGA. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1776 if commune == "MANGA" 
replace vaccination_coverage_bcg_2018 	 = 1284 if commune == "MANGA" 
replace vaccination_coverage_vpo_2018 	 = 1206 if commune == "MANGA" 
replace vaccination_coverage_dtchephib3_ = 1206 if commune == "MANGA" 
replace vaccination_coverage_vaa_2018 	 = 1177 if commune == "MANGA" 
replace vaccination_coverage_rr1_2018 	 = 1177 if commune == "MANGA" 

*--- Wrong data for NOBERE. 
	// Replace with the right values. 
replace target_vaccination_bcg_2018 	 = 1775 if commune == "NOBERE" 
replace vaccination_coverage_bcg_2018 	 = 1346 if commune == "NOBERE" 
replace vaccination_coverage_vpo_2018 	 = 1281 if commune == "NOBERE" 
replace vaccination_coverage_dtchephib3_ = 1281 if commune == "NOBERE" 
replace vaccination_coverage_vaa_2018 	 = 1354 if commune == "NOBERE" 
replace vaccination_coverage_rr1_2018 	 = 1354 if commune == "NOBERE" 


*--------------- EST ------------- 
*--------------------------------- 

*--- Vaccinated is the coverage percentage for 3 communes (THION, MANI and COALLA) 
	// Should multiply the target by the percentage. 

foreach commune in THION MANI COALLA { 
	replace vaccination_coverage_bcg_2018 		= round(target_vaccination_bcg_2018*(vaccination_coverage_bcg_2018/10000)) 			if commune == "`commune'" 
	replace vaccination_coverage_vpo_2018 		= round(target_vaccination_vpo3_2018*(vaccination_coverage_vpo_2018/10000)) 		if commune == "`commune'" 
	replace vaccination_coverage_dtchephib3_ 	= round(target_vaccination_dtchephib3_20*(vaccination_coverage_dtchephib3_/10000)) 	if commune == "`commune'" 
	replace vaccination_coverage_var_2018 		= round(target_vaccination_var_2018*(vaccination_coverage_var_2018/10000)) 			if commune == "`commune'" 
	replace vaccination_coverage_vaa_2018 		= round(target_vaccination_vaa_2018*(vaccination_coverage_vaa_2018/10000)) 			if commune == "`commune'" 
	replace vaccination_coverage_rr1_2018		= round(target_vaccination_rr1_2018*(vaccination_coverage_rr1_2018/10000)) 			if commune == "`commune'" 
	replace vaccination_coverage_bcg_2018_ch 	= vaccination_coverage_bcg_2018 					if commune == "`commune'" 
	replace vaccination_coverage_vpo_2018_ch	= vaccination_coverage_vpo_2018 					if commune == "`commune'" 
	replace v26 								= vaccination_coverage_dtchephib3_ 					if commune == "`commune'" 
	replace vaccination_coverage_var_2018_ch 	= vaccination_coverage_var_2018 					if commune == "`commune'" 
	replace vaccination_coverage_vaa_2018_ch 	= vaccination_coverage_vaa_2018 					if commune == "`commune'" 
	replace vaccination_coverage_rr1_2018_ch 	= vaccination_coverage_rr1_2018 					if commune == "`commune'" 
} 

*--- Zero values for: 
	  *- Target VPO3 and RR1 for PAMA: Should be 2541. 
	  *- Target DTC-HEPHIB3 for KOMPIENGA: Should be 2210. 
	  *- Target VAA for MADJOARI and KOMPIENGA: Should be 759 and 2349 respectively. 
	replace target_vaccination_vpo3_2018 		= 2541 							if commune == "PAMA" 
	replace target_vaccination_vpo3_2018_che	= target_vaccination_vpo3_2018  if commune == "PAMA" 
	replace target_vaccination_rr1_2018 		= 2541 							if commune == "PAMA" 
	replace target_vaccination_rr1_2018_che		= target_vaccination_rr1_2018   if commune == "PAMA" 

	replace target_vaccination_dtchephib3_20 	= 2210 								if commune == "KOMPIENGA" 
	replace target_vaccination_vaa_2018 		= 759 								if commune == "KOMPIENGA" 
	replace target_vaccination_rr1_2018 		= 759 								if commune == "KOMPIENGA" 
	replace v24 								= target_vaccination_dtchephib3_20 	if commune == "KOMPIENGA" 
	replace target_vaccination_vaa_2018_chec 	= target_vaccination_vaa_2018 		if commune == "KOMPIENGA" 
	replace target_vaccination_rr1_2018_chec 	= target_vaccination_rr1_2018		if commune == "KOMPIENGA" 

	replace target_vaccination_vaa_2018 		= 2349 							if commune == "MADJOARI" 
	replace target_vaccination_vaa_2018_chec 	= target_vaccination_vaa_2018 	if commune == "MADJOARI" 

*--- Wrong data for MADJOARI. 
	// Replace with the right values. 
	replace target_vaccination_vaa_2018 		= 943 		if commune == "MADJOARI" 
	replace target_vaccination_rr1_2018 		= 943 		if commune == "MADJOARI" 


*----------- HAUTS-BASSINS -------
*---------------------------------

*--- Unconsistant data for FARAMANA (OUATTARA San Paulin) 
	// Replace with the right values 

	replace projected_deliveries_2018 		 	= 901								if commune == "FARAMANA" 
	replace assisted_deliveries_2018 		 	= 961								if commune == "FARAMANA" 
	replace target_vaccination_bcg_2018 	 	= 989 								if commune == "FARAMANA" 
	replace vaccination_coverage_bcg_2018 	 	= 1020 								if commune == "FARAMANA" 
	replace target_vaccination_vpo3_2018 	 	= 887 								if commune == "FARAMANA" 
	replace vaccination_coverage_vpo_2018 	 	= 927 								if commune == "FARAMANA" 
	replace target_vaccination_dtchephib3_20 	= 869								if commune == "FARAMANA" 
	replace vaccination_coverage_dtchephib3_ 	= 902								if commune == "FARAMANA" 
	replace target_vaccination_var_2018 		= 805								if commune == "FARAMANA" 
	replace vaccination_coverage_var_2018 		= 376								if commune == "FARAMANA" 
	replace target_vaccination_vaa_2018 		= 805								if commune == "FARAMANA" 
	replace vaccination_coverage_vaa_2018 		= 753								if commune == "FARAMANA" 
	replace target_vaccination_rr1_2018 		= 805 								if commune == "FARAMANA" 
	replace vaccination_coverage_rr1_2018 		= 817 								if commune == "FARAMANA" 

*--- Questionnaire for the commune of HOUNDE sent twice. 
	// Just drop one 
drop if key == "uuid:5d164e47-16f9-428f-922b-c8fe68244144" 

*--- Wrong data for FO. 
	// Replace with the right values. 
	replace projected_deliveries_2018 		 	= 901								if commune == "FO" 
	replace assisted_deliveries_2018 		 	= 1065								if commune == "FO" 
	replace target_vaccination_bcg_2018 	 	= 1483 								if commune == "FO" 
	replace vaccination_coverage_bcg_2018 	 	= 1066 								if commune == "FO" 
	replace target_vaccination_vpo3_2018 	 	= 1483 								if commune == "FO" 
	replace vaccination_coverage_vpo_2018 	 	= 1053 								if commune == "FO" 
	replace target_vaccination_dtchephib3_20 	= 1483								if commune == "FO" 
	replace vaccination_coverage_dtchephib3_ 	= 1050								if commune == "FO" 
	replace target_vaccination_var_2018 		= 636								if commune == "FO" 
	replace vaccination_coverage_var_2018 		= 576								if commune == "FO" 
	replace target_vaccination_vaa_2018 		= 465								if commune == "FO" 
	replace vaccination_coverage_vaa_2018 		= 902								if commune == "FO" 
	replace target_vaccination_rr1_2018 		= 636 								if commune == "FO" 
	replace vaccination_coverage_rr1_2018 		= 906 								if commune == "FO" 

*--- Wrong data for KOUNDOUGOU. 
	// Replace with the right values. 
	replace projected_deliveries_2018 		 	= 1764								if commune == "KOUNDOUGOU" 
	replace assisted_deliveries_2018 		 	= 1028								if commune == "KOUNDOUGOU" 
	replace target_vaccination_bcg_2018 	 	= 1836 								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_bcg_2018 	 	= 1321 								if commune == "KOUNDOUGOU" 
	replace target_vaccination_vpo3_2018 	 	= 1712 								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_vpo_2018 	 	= 1043 								if commune == "KOUNDOUGOU" 
	replace target_vaccination_dtchephib3_20 	= 1895								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_dtchephib3_ 	= 1043								if commune == "KOUNDOUGOU" 
	replace target_vaccination_var_2018 		= 495								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_var_2018 		= 458								if commune == "KOUNDOUGOU" 
	replace target_vaccination_vaa_2018 		= 1895								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_vaa_2018 		= 1201								if commune == "KOUNDOUGOU" 
	replace target_vaccination_rr1_2018 		= 1895 								if commune == "KOUNDOUGOU" 
	replace vaccination_coverage_rr1_2018 		= 1201 								if commune == "KOUNDOUGOU" 

*--- Wrong data for PADEMA. 
	// Replace with the right values. 
	replace projected_deliveries_2018 		 	= 2242								if commune == "PADEMA" 
	replace assisted_deliveries_2018 		 	= 2573								if commune == "PADEMA" 
	replace target_vaccination_bcg_2018 	 	= 1836 								if commune == "PADEMA" 
	replace vaccination_coverage_bcg_2018 	 	= 3032 								if commune == "PADEMA" 
	replace target_vaccination_vpo3_2018 	 	= 1712 								if commune == "PADEMA" 
	replace vaccination_coverage_vpo_2018 	 	= 2839 								if commune == "PADEMA" 
	replace target_vaccination_dtchephib3_20 	= 1895								if commune == "PADEMA" 
	replace vaccination_coverage_dtchephib3_ 	= 2839								if commune == "PADEMA" 
	replace target_vaccination_var_2018 		= 964								if commune == "PADEMA" 
	replace vaccination_coverage_var_2018 		= 452								if commune == "PADEMA" 
	replace target_vaccination_vaa_2018 		= 1315								if commune == "PADEMA" 
	replace vaccination_coverage_vaa_2018 		= 2676								if commune == "PADEMA" 
	replace target_vaccination_rr1_2018 		= 1315 								if commune == "PADEMA" 
	replace vaccination_coverage_rr1_2018 		= 2843 								if commune == "PADEMA" 

foreach commune in KOUROUMA MOROLABA NDOROLA KAYAN { 
	replace target_vaccination_bcg_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_vpo3_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_dtchephib3_20 = . 			if commune == "`commune'" 
	replace target_vaccination_vaa_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_rr1_2018 	 = . 			if commune == "`commune'" 
} 


*----------- NORD ---------------- 
*--------------------------------- 

*--- A typo in the name of the commune KOUMBRI 

replace commune = "KOUMBRI" if commune == "KOUMBRI�" 


*------- PLATEAU CENTRAL --------- 
*--------------------------------- 

*--- A typo in the name of the commune BOUDRY 
replace commune = "BOUDRY" if commune == "BOUDRY_" 

foreach commune in BOUSSE LAYE NIOU SOURGOUBILA TOEGHIN { 
	replace target_vaccination_bcg_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_vpo3_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_dtchephib3_20 = . 			if commune == "`commune'" 
	replace target_vaccination_vaa_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_rr1_2018 	 = . 			if commune == "`commune'" 
} 


*------------- SAHEL ------------- 
*--------------------------------- 

*--- Three additional for BANI, DORI and GORGADJI by DIALLO Tahirou. 
	// They should be (and are) done by SAWADOGO Rasmane. Need to drop them. 
drop if commune == "DORI" 		& key == "uuid:2ffb5f7e-4adb-4f3a-84f8-822f8c0b2949" 
drop if commune == "GORGADJI" 	& key == "uuid:6fc95ed5-bf9a-410f-b6be-b3a85ccd81a8" 
drop if commune == "BANI" 		& key == "uuid:ec6d840c-0a90-422a-997e-c165b937e18e" 

*--- Issues with projected and assisted delivery for FALAGOUNTOU, SEYTENGA and SAMPELGA 
	// Data were not correct 
	replace projected_deliveries_2018 = 1415			if commune == "FALAGOUNTOU" 
	replace assisted_deliveries_2018  = 1367			if commune == "FALAGOUNTOU" 

	replace projected_deliveries_2018 = 2110			if commune == "SEYTENGA" 
	replace assisted_deliveries_2018  = 1296			if commune == "SEYTENGA" 

	replace projected_deliveries_2018 =  773			if commune == "SAMPELGA" 
	replace assisted_deliveries_2018  =  713			if commune == "SAMPELGA" 

foreach commune in FALAGOUNTOU SEYTENGA SAMPELGA { 
	replace projected_deliveries_2018_check = projected_deliveries_2018	if commune == "`commune'" 
	replace assisted_deliveries_2018_check	= assisted_deliveries_2018 	if commune == "`commune'" 
} 


*----------- SUD_OUEST ----------- 
*--------------------------------- 

*--- Wrong data for DISSIN. 
	// Replace with the right values. 
	replace projected_deliveries_2018 	= 1928			if commune == "DISSIN" 
	replace assisted_deliveries_2018 	= 1954			if commune == "DISSIN" 

*--- Wrong data for ZAMBO. 
	// Replace with the right values. 
	replace projected_deliveries_2018 	= 964			if commune == "ZAMBO" 
	replace assisted_deliveries_2018 	= 719			if commune == "ZAMBO" 


foreach commune in BATIE BOUSSOUKOULA KPUERE LEGMOIN MIDEBDO { 
	replace target_vaccination_bcg_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_vpo3_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_dtchephib3_20 = . 			if commune == "`commune'" 
	replace target_vaccination_vaa_2018 	 = . 			if commune == "`commune'" 
	replace target_vaccination_rr1_2018 	 = . 			if commune == "`commune'" 
} 


*=================================== Replace double entry variables by the corrected values 

replace target_vaccination_bcg_2018_chec = target_vaccination_bcg_2018 		if target_vaccination_bcg_2018_chec != target_vaccination_bcg_2018 
replace vaccination_coverage_bcg_2018_ch = vaccination_coverage_bcg_2018 	if vaccination_coverage_bcg_2018_ch != vaccination_coverage_bcg_2018 
replace target_vaccination_vpo3_2018_che = target_vaccination_vpo3_2018		if target_vaccination_vpo3_2018_che != target_vaccination_vpo3_2018 
replace vaccination_coverage_vpo_2018_ch = vaccination_coverage_vpo_2018 	if vaccination_coverage_vpo_2018_ch	!= vaccination_coverage_vpo_2018 
replace v24 							 = target_vaccination_dtchephib3_20 if v24 								!= target_vaccination_dtchephib3_20 
replace v26 							 = vaccination_coverage_dtchephib3_ if v26 								!= vaccination_coverage_dtchephib3_ 
replace target_vaccination_var_2018_chec = target_vaccination_var_2018 		if target_vaccination_var_2018_chec != target_vaccination_var_2018 
replace vaccination_coverage_var_2018_ch = vaccination_coverage_var_2018 	if vaccination_coverage_var_2018_ch != vaccination_coverage_var_2018 
replace target_vaccination_vaa_2018_chec = target_vaccination_vaa_2018		if target_vaccination_vaa_2018_chec != target_vaccination_vaa_2018 
replace vaccination_coverage_vaa_2018_ch = vaccination_coverage_vaa_2018 	if vaccination_coverage_vaa_2018_ch != vaccination_coverage_vaa_2018 
replace target_vaccination_rr1_2018_chec = target_vaccination_rr1_2018		if target_vaccination_rr1_2018_chec != target_vaccination_rr1_2018 
replace vaccination_coverage_rr1_2018_ch = vaccination_coverage_rr1_2018 	if vaccination_coverage_rr1_2018_ch != vaccination_coverage_rr1_2018 


*=================================== SAVE DATA

save "${interm}/District Sanitaire ${year}_clean.dta", replace 
save "${interm}/District Sanitaire ${year}.dta", replace 



*===============================================================================
*============================ INFIRMIER CHEF DE POSTE ==========================
*=============================================================================== 

clear all 
use "${raw}/Directeur Formation Sanitaire 2018_WIDE.dta", clear 				// Open raw data 


*------- BOUCLE DU MOUHOUN ------- 
*--------------------------------- 


*----------- CASCADES ------------ 
*--------------------------------- 

*--- CSPS DAKORO from commune of DAKORO sent twice. 
	// Drop the one with key == "uuid:aa13f38b-ee8e-4e6b-b30a-5e8c4f368a85" 
drop if key == "uuid:aa13f38b-ee8e-4e6b-b30a-5e8c4f368a85" 


*----------- CENTRE-EST ---------- 
*--------------------------------- 

*----------- CENTRE-NORD --------- 
*--------------------------------- 

*----------- CENTRE-OUEST -------- 
*--------------------------------- 

*----------- CENTRE-SUD ---------- 
*--------------------------------- 

*-------------- EST -------------- 
*--------------------------------- 

*----------- HAUTS-BASSINS -------
*---------------------------------

*--- CSPS "ZANGOMA" from the commune of PADEMA sent twice. 
	// Drop the one with key = "uuid:b00520d0-4d15-4a27-bbf3-bfab2a1181ba". 
drop if key == "uuid:b00520d0-4d15-4a27-bbf3-bfab2a1181ba" 

*-------------- NORD -------------
*---------------------------------

*--- CSPS BANGO from commune of THIOU sent twice. 
	// Just drop one. 
drop if key == "uuid:ca57eb38-dceb-4e77-84ab-671876183811" 


*-------- PLATEAU CENTRAL --------
*---------------------------------

*--- CSPS BOENA from commune of BOUDRY:  
	// 2 bottles needed per month, instead of 24. 
replace bottles_gas 	  = 2				if bottles_gas == 24 
replace bottles_gas_check = bottles_gas	 


*------------- SAHEL ------------- 
*--------------------------------- 

*--- CSPS HIGA from commune of TANKOUGOUNADIE sent twice. 
	// Just drop one. 
drop if key == "uuid:ccd43094-9656-485d-aa88-2754601ad26a" 


*----------- SUD_OUEST ----------- 
*--------------------------------- 

*--- CSPS VARPOUO from commune of NIEGO sent twice. 
	// Just drop one. 
drop if key == "uuid:911e2d4d-2ef6-4619-8984-b17f9718cb13" 


*=================================== SAVE DATA 

save "${interm}/Directeur Formation Sanitaire ${year}_clean.dta", replace 
save "${interm}/Directeur Formation Sanitaire ${year}.dta", replace 


*=============================================================================== 
*================================= MUNICIPALITE ================================ 
*=============================================================================== 

clear all 
use "${raw}/Municipalite 2018_WIDE.dta", clear 									// Open raw data 

destring local_taxes_2016 local_taxes_forecast_2016 /// 						// Destring Local tax variables 
		 local_taxes_2017 local_taxes_forecast_2017 /// 
		 local_taxes_2018_amount local_taxes_forecast_2018, replace 

destring local_taxes_2016_check local_taxes_forecast_2016_check /// 
		 local_taxes_2017_check local_taxes_forecast_2017_check /// 
		 local_taxes_2018_amount_check local_taxes_forecast_2018_check, replace 


*----------- BOUCLE DU MOUHOUN ------------ 
*------------------------------------------ 

*--- Replace 2016 and 2017 local taxes for SAFANE. 
	// Data was missing due to Accountant unavailable 
replace local_taxes_2016 			=  58090232						if commune == "SAFANE" 
replace local_taxes_2017 			= 103000000						if commune == "SAFANE" 
replace local_taxes_forecast_2016 	=  54817808						if commune == "SAFANE" 
replace local_taxes_forecast_2017 	=  64783955						if commune == "SAFANE" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "SAFANE" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "SAFANE" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "SAFANE" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "SAFANE" 
	
*--- Correct the value of Population for YAHO 
	// Value was very low (1,200) 
replace commune_population_number = 22851 							if commune == "YAHO" 
replace commune_population_number_check = commune_population_number if commune == "YAHO" 

*--- Correct the value of 2016 and 2017 local taxes for NOUNA 
	// Sudden taxes increase in from 2016 to 2017. Need to correct the data 
replace local_taxes_2016 		= 76376143				if commune == "NOUNA" 
replace local_taxes_2017 		= 90388688				if commune == "NOUNA" 
replace local_taxes_2016_check 	= local_taxes_2016 		if commune == "NOUNA" 
replace local_taxes_2017_check 	= local_taxes_2017 		if commune == "NOUNA" 

*--- Replace 2018 local taxes for BALAVE 
	// This was not calculated yet 
replace local_taxes_2018_amount 		= 10745729					if commune == "BALAVE" 
replace local_taxes_forecast_2018 		= 10333000					if commune == "BALAVE" 
replace local_taxes_2018_amount_check 	= local_taxes_2018 			if commune == "BALAVE" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "BALAVE" 

*--- Replace 2016 local taxes for TOENI 
	// This was missing due to insecurity 
replace local_taxes_2016 				= 0							if commune == "TOENI" 
replace local_taxes_forecast_2016 		= 53333188					if commune == "TOENI" 
replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "TOENI" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "TOENI" 

*--- Correct local taxes, transferred resources and procurement for GOMBORO 
	// There were mistake in the data 
replace local_taxes_2016 			=  5518869						if commune == "GOMBORO" 
replace local_taxes_2017 			= 10375793						if commune == "GOMBORO" 
replace local_taxes_2018_amount 	=  8836780						if commune == "GOMBORO" 
replace local_taxes_forecast_2016 	=  9658000						if commune == "GOMBORO" 
replace local_taxes_forecast_2017 	=  9996000						if commune == "GOMBORO" 
replace local_taxes_forecast_2018 	= 15357404						if commune == "GOMBORO" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "GOMBORO" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "GOMBORO" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "GOMBORO" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "GOMBORO" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "GOMBORO" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "GOMBORO" 

replace ressources_transferees_2018 	 = 25279343 					if commune == "GOMBORO" 
replace depenses_ressources_transferees_ = 24781560 					if commune == "GOMBORO" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "GOMBORO" 
replace v151 = depenses_ressources_transferees_							if commune == "GOMBORO" 

replace execution_equipment_procurement_ = 70 						if commune == "GOMBORO" 
replace v153 = execution_equipment_procurement_ 					if commune == "GOMBORO" 

*--- Replace Birth certificate data for GOMBORO 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 1273						if commune == "GOMBORO" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "GOMBORO" 

*--- Correct local taxes and procurement for DOUMBALA 
	// Data were missing 
replace local_taxes_2016 			=  6322712						if commune == "DOUMBALA" 
replace local_taxes_2017 			=  9108969						if commune == "DOUMBALA" 
replace local_taxes_2018_amount 	=  9241701						if commune == "DOUMBALA" 
replace local_taxes_forecast_2016 	=  7310000						if commune == "DOUMBALA" 
replace local_taxes_forecast_2017 	=  9188000						if commune == "DOUMBALA" 
replace local_taxes_forecast_2018 	= 13619000						if commune == "DOUMBALA" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "DOUMBALA" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "DOUMBALA" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "DOUMBALA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "DOUMBALA" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "DOUMBALA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "DOUMBALA" 

replace execution_equipment_procurement_ = 75 						if commune == "DOUMBALA" 
replace v153 = execution_equipment_procurement_ 					if commune == "DOUMBALA" 

*--- Correct attendance score and 2016/2017 local taxes for KOMBORI 
	// Data were missing for all 4 sessions held 
replace councilor_attendance_meeting1 	= 29 				if commune == "KOMBORI" 
replace councilor_attendance_meeting2 	= 28 				if commune == "KOMBORI" 
replace councilor_attendance_meeting3 	= 28 				if commune == "KOMBORI" 
replace councilor_attendance_meeting4 	= 27 				if commune == "KOMBORI" 

replace date_2018meeting1 = date("03/15/2018", "MDY", 2050)	if commune == "KOMBORI" 
replace date_2018meeting2 = date("06/21/2018", "MDY", 2050)	if commune == "KOMBORI" 
replace date_2018meeting3 = date("11/22/2018", "MDY", 2050)	if commune == "KOMBORI" 
replace date_2018meeting4 = date("12/29/2018", "MDY", 2050)	if commune == "KOMBORI" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' /// 
	 if commune == "KOMBORI" 
} 

replace local_taxes_2016 			= 1516134						if commune == "KOMBORI" 
replace local_taxes_2017 			= 2516694						if commune == "KOMBORI" 
replace local_taxes_forecast_2016 	= 4857634						if commune == "KOMBORI" 
replace local_taxes_forecast_2017 	= 5008000						if commune == "KOMBORI" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "KOMBORI" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "KOMBORI" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "KOMBORI" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "KOMBORI" 

*--- Replace Procurement data for KOMBORI 
	// There were missing in the data 
replace execution_equipment_procurement_ = 99 			if commune == "KOMBORI" 
replace v153 = execution_equipment_procurement_ 		if commune == "KOMBORI" 

*--- Replace Birth certificate data for KOMBORI 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 77						if commune == "KOMBORI" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "KOMBORI" 

*--- Correct transferred resources for GASSAN 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "GASSAN" 
replace v151 = depenses_ressources_transferees_							if commune == "GASSAN" 

*--- Correct Birth certificate data for SOLENZO 
	// Data was wrong 
replace birth_certificates_2018 		= 6300						if commune == "SOLENZO" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "SOLENZO" 


*----------- CASCADES ------------ 
*--------------------------------- 

*--- Replace Birth certificate data for SOUBAKANIEDOUGOU 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 590						if commune == "SOUBAKANIEDOUGOU" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "SOUBAKANIEDOUGOU" 

*--- Less than 20 councilors in DOUNA: 
	// Replace by the right value 
replace total_councilor  		= 20 if commune == "DOUNA" 
replace total_councilor_check   = 20 if commune == "DOUNA" 


*----------- CENTRE-EST ----------
*---------------------------------

*--- Replace Birth certificate data for DIALGAYE 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 2661						if commune == "DIALGAYE" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "DIALGAYE" 

*--- Replace 2018 local taxes for ZOAGA 
	// This was not calculated yet 
replace local_taxes_2018_amount 		= 18058270					if commune == "ZOAGA" 
replace local_taxes_forecast_2018 		=  7050000					if commune == "ZOAGA" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "ZOAGA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "ZOAGA"  

*--- Replace 2016 local taxes for SANGHA 
	// This was missing 
replace local_taxes_2016 				= 12135000					if commune == "SANGA" 
replace local_taxes_forecast_2016 		= 24475000					if commune == "SANGA" 
replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "SANGA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "SANGA" 

*--- Replace Birth certificate data for BASKOURE 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 402						if commune == "BASKOURE" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "BASKOURE" 

*--- Correct Birth certificate data for NIANGOLOKO 
	// Data was wrong 
replace birth_certificates_2018 		= 2706						if commune == "NIANGOLOKO" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "NIANGOLOKO" 


*----------- CENTRE-NORD ---------
*---------------------------------

*--- Correct 2018 local taxes forecast for ROLLO 
	// This was 4 times less than the others 
replace local_taxes_2018_amount 		= 38090813					if commune == "ROLLO" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount 	if commune == "ROLLO" 

*--- Correct local taxes and transferred resources for BARSALOGHO 
	// There were mistake in the data 
replace local_taxes_2016 			= 28861945						if commune == "BARSALOGHO" 
replace local_taxes_2017 			= 37845310						if commune == "BARSALOGHO" 
replace local_taxes_2018_amount 	= 45981855						if commune == "BARSALOGHO" 
replace local_taxes_forecast_2016 	= 29355037						if commune == "BARSALOGHO" 
replace local_taxes_forecast_2017 	= 41155910						if commune == "BARSALOGHO" 
replace local_taxes_forecast_2018 	= 51026037						if commune == "BARSALOGHO" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "BARSALOGHO" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "BARSALOGHO" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "BARSALOGHO" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "BARSALOGHO" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "BARSALOGHO" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "BARSALOGHO" 

replace ressources_transferees_2018 	 = 52979795 					if commune == "BARSALOGHO" 
replace depenses_ressources_transferees_ = 39909075 					if commune == "BARSALOGHO" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "BARSALOGHO" 
replace v151 = depenses_ressources_transferees_							if commune == "BARSALOGHO" 

*--- Correct transferred resources for NAMISSIGUIMA 
	// There were mistake in the data 
replace ressources_transferees_2018 	 = 11005736 					if commune == "NAMISSIGUIMA_KAYA" 
replace depenses_ressources_transferees_ = 7071909	 					if commune == "NAMISSIGUIMA_KAYA" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "NAMISSIGUIMA_KAYA" 
replace v151 = depenses_ressources_transferees_							if commune == "NAMISSIGUIMA_KAYA" 

*--- Correct transferred resources for KAYA 
	// There were mistake in the data 
replace ressources_transferees_2018 	 = 13231596 					if commune == "KAYA" 
replace depenses_ressources_transferees_ =  7042752	 					if commune == "KAYA" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "KAYA" 
replace v151 = depenses_ressources_transferees_							if commune == "KAYA" 

*--- Correct local taxes for YALGO 
	// Suddent growth in Local taxes from 2016 to 2017 and 2018 
	// Should be corrected by the right data 
replace local_taxes_forecast_2016 = 16375000						if commune == "YALGO" 
replace local_taxes_forecast_2017 = 224667429						if commune == "YALGO" 
replace local_taxes_forecast_2018 = 395987800						if commune == "YALGO" 

replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "YALGO" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "YALGO" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "YALGO" 

*--- Correct transferred resources for BOUROUM 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "BOUROUM" 
replace v151 = depenses_ressources_transferees_							if commune == "BOUROUM" 

*--- Correct 2016 local taxes for PISSILA 
	// Data was missing 
replace local_taxes_forecast_2016 		= 14263025					if commune == "PISSILA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "PISSILA" 

*--- Replace Procurement data for BOULSA 
	// Was set zero. Is missing due to strikes 
replace execution_equipment_procurement_ = . 						if commune == "BOULSA" 
replace v153 = execution_equipment_procurement_ 					if commune == "BOULSA" 

*--- Correct Birth certificate data for NAGBINGOU 
	// Data was wrong 
replace birth_certificates_2018 		= 599						if commune == "NAGBINGOU" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "NAGBINGOU" 


*----------- CENTRE-OUEST -------- 
*--------------------------------- 

*--- Replace Birth certificate data for POA 
	// This was missing due to strikes 
replace birth_certificates_2018 	  = 651							if commune == "POA" 
replace birth_certificates_2018_check = birth_certificates_2018 	if commune == "POA" 

*--- Correct transferred resources for KYON 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "KYON" 
replace v151 = depenses_ressources_transferees_							if commune == "KYON" 

*--- Replace Birth certificate data for BIEHA 
	// This was missing due to strikes 
replace birth_certificates_2018 	  = .							if commune == "BIEHA" 
replace birth_certificates_2018_check = birth_certificates_2018 	if commune == "BIEHA" 

*--- Correct local taxes and transferred resources for DIDYR 
	// There were mistake in the data 
replace local_taxes_2018_amount 	= 13277943						if commune == "DIDYR" 
replace local_taxes_forecast_2016 	= 38051041						if commune == "DIDYR" 
replace local_taxes_forecast_2018 	= 15318433						if commune == "DIDYR" 

replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "DIDYR" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "DIDYR" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "DIDYR" 

*--- Replace Birth certificate data for DIDYR 
	// This was missing due to strikes 
replace birth_certificates_2018 	  = .							if commune == "DIDYR" 
replace birth_certificates_2018_check = birth_certificates_2018 	if commune == "DIDYR" 

*--- Replace Procurement data for SOURGOU 
	// There were missing in the data 
replace execution_equipment_procurement_ = 76 			if commune == "SOURGOU" 
replace v153 = execution_equipment_procurement_ 		if commune == "SOURGOU" 

*--- Correct transferred resources for KOUDOUGOU 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "KOUDOUGOU" 
replace v151 = depenses_ressources_transferees_							if commune == "KOUDOUGOU" 

*--- Correct 2018 local taxes for IMASGO 
	// Data was not calculated yet 
replace local_taxes_2018_amount 		= 12972030					if commune == "IMASGO" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "IMASGO" 


*----------- CENTRE-SUD ---------- 
*--------------------------------- 

*--- Correct 2016 local taxes for PO 
	// They were missing 
replace local_taxes_2016 			= 169400000						if commune == "PO" 
replace local_taxes_forecast_2016 	= 157800000						if commune == "PO" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "PO" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "PO" 


*--------------- EST -------------
*---------------------------------

*--- Correct number of sessions and attendance for BARTIEBOUGOU 
	// No session in that commune due to insecurity 
replace total_num_scm_2018 					= 0 			if commune == "BARTIEBOUGOU" 
replace total_num_scm_2018_check  			= 0 			if commune == "BARTIEBOUGOU" 
replace total_num_extraordinary_scm_2018 	= 0 			if commune == "BARTIEBOUGOU" 
replace v64 = 0 											if commune == "BARTIEBOUGOU" 
replace total_num_ordinary_scm_2018 		= 0 			if commune == "BARTIEBOUGOU" 
replace total_num_ordinary_scm_2018_chec 	= 0 			if commune == "BARTIEBOUGOU" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t' 	= . 			if commune == "BARTIEBOUGOU" 
replace councilor_attendance_meeting`t'_ch 	= . 			if commune == "BARTIEBOUGOU" 
} 

*--- Correct presence of "Agent Etat civil" for BARTIEBOUGOU 
	// There were mistake in the data 
replace agent_etat_civil_2018 = 0 							if commune == "BARTIEBOUGOU" 

*--- Correct presence of "Agent Etat civil" for FOUTOURI 
	// There were mistake in the data 
replace agent_etat_civil_2018 = 0 							if commune == "FOUTOURI" 

*--- Correct 1st session attendance for BILANGA 
	// There were mistake in the data 
replace councilor_attendance_meeting1 		= 123 							if commune == "BILANGA" 
replace councilor_attendance_meeting1_ch 	= councilor_attendance_meeting1 if commune == "BILANGA" 

*--- Correct transferred resources for BILANGA 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "BILANGA" 
replace v151 = depenses_ressources_transferees_							if commune == "BILANGA" 

*--- Replace Birth certificate data for TIBGA 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 580						if commune == "TIBGA" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "TIBGA" 

/* BARTIEBOUGOU and FOUTOURI didn't deliver certificates because of Municipality burnt. */ 

*--- Correct local taxes, transferred resources and Attendance for BOTOU 
	// They were missing 
replace local_taxes_2016 			= 51599051						if commune == "BOTOU" 
replace local_taxes_2017 			= 58841104						if commune == "BOTOU" 
replace local_taxes_2018_amount 	= 79040272						if commune == "BOTOU" 
replace local_taxes_forecast_2016 	= 54411202						if commune == "BOTOU" 
replace local_taxes_forecast_2017 	= 57878492						if commune == "BOTOU" 
replace local_taxes_forecast_2018 	= 68319262						if commune == "BOTOU" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "BOTOU" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "BOTOU" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "BOTOU" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "BOTOU" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "BOTOU" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "BOTOU" 

/* 
replace ressources_transferees_2018 	 = 52979795 					if commune == "BOTOU" 
replace depenses_ressources_transferees_ = 39909075 					if commune == "BOTOU" 
replace ressources_transferees_2018_chec = ressources_transferees_2018 	if commune == "BOTOU" 
replace v151 = depenses_ressources_transferees_							if commune == "BOTOU" 
*/ 

replace execution_equipment_procurement_ = 60 			if commune == "BOTOU" 
replace v153 = execution_equipment_procurement_ 		if commune == "BOTOU" 


*--- Correct meeting Attendance for BOTOU and KOMPIENGA 
	// They were missing 
replace total_num_scm_2018 					= 6 								if commune == "BOTOU" 
replace total_num_ordinary_scm_2018 		= 4 								if commune == "BOTOU" 
replace total_num_extraordinary_scm_2018 	= 2 								if commune == "BOTOU" 

replace total_num_scm_2018_check  			= total_num_scm_2018 				if commune == "BOTOU" 
replace total_num_ordinary_scm_2018_chec 	= total_num_ordinary_scm_2018 		if commune == "BOTOU" 
replace v64 								= total_num_extraordinary_scm_2018 	if commune == "BOTOU" 

replace councilor_attendance_meeting1 	= 49 				if commune == "BOTOU" 
replace councilor_attendance_meeting2 	= 44 				if commune == "BOTOU" 
replace councilor_attendance_meeting3 	= 49 				if commune == "BOTOU" 
replace councilor_attendance_meeting4 	= 48 				if commune == "BOTOU" 

replace councilor_attendance_meeting1 	= 34 				if commune == "KOMPIENGA" 
replace councilor_attendance_meeting2 	= 34 				if commune == "KOMPIENGA" 
replace councilor_attendance_meeting3 	= 34 				if commune == "KOMPIENGA" 
replace councilor_attendance_meeting4 	= 34 				if commune == "KOMPIENGA" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' 	/// 
	 if commune == "BOTOU" | commune == "KOMPIENGA" 
} 

*--- Correct meeting dates for BOTOU 
	// They were missing 
replace date_2018meeting1 = date("03/07/2018", "MDY", 2050)	if commune == "BOTOU" 
replace date_2018meeting2 = date("06/18/2018", "MDY", 2050)	if commune == "BOTOU" 
replace date_2018meeting3 = date("10/18/2018", "MDY", 2050)	if commune == "BOTOU" 
replace date_2018meeting4 = date("12/07/2018", "MDY", 2050)	if commune == "BOTOU" 

*--- Replace Birth certificate data for KOMPIENGA and MADJOARI 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 99						if commune == "MADJOARI" 
replace birth_certificates_2018_check  	= birth_certificates_2018 	if commune == "MADJOARI" 

replace birth_certificates_2018 		= 2972						if commune == "KOMPIENGA" 
replace birth_certificates_2018_check  	= birth_certificates_2018 	if commune == "KOMPIENGA" 

*--- Correct Birth certificate data for THION 
	// Data was wrong 
replace birth_certificates_2018 		= 788						if commune == "THION" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "THION" 


*----------- HAUTS-BASSINS -------
*---------------------------------

*--- Correct 2016 and 2017 local taxes for KOUMBIA 
	// They were missing due to unavailable docmuents. 
replace local_taxes_2016 			= 11875599						if commune == "KOUMBIA" 
replace local_taxes_2017 			= 23000000						if commune == "KOUMBIA" 
replace local_taxes_forecast_2016 	= 13425400						if commune == "KOUMBIA" 
replace local_taxes_forecast_2017 	= 19275448						if commune == "KOUMBIA" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "KOUMBIA" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "KOUMBIA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "KOUMBIA" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "KOUMBIA" 

*--- Correct 2018 local taxes for KARANKASSO-VIGUE 
	// Was not calculated yet. 
replace local_taxes_2018_amount 		= 43773003					if commune == "KARANKASSO_VIGUE" 
replace local_taxes_forecast_2018 		= 30930270					if commune == "KARANKASSO_VIGUE" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount 	if commune == "KARANKASSO_VIGUE" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "KARANKASSO_VIGUE" 

/* KARANKASSO-SAMBLA 
  * Staff start date missing: all are set 01/07/2018. 
  * Sessions dates missing for 2 sessions: all are set 01/07/2018. 
  * Missing participation for 2 sessions: They are set 1. 
*/ 
*--- Correct number of sessions and attendance and councilors for KARANKASSO-SAMBLA 
	// Missing participation for 2 sessions  (While they delared 4 sessions) 
	// Data was missing for KARANKASSO-SAMBLA
replace councilor_attendance_meeting1 	= 27 				if commune == "KARANKASSO_SAMBLA" 
replace councilor_attendance_meeting2 	= 27 				if commune == "KARANKASSO_SAMBLA" 
replace councilor_attendance_meeting3 	= 28 				if commune == "KARANKASSO_SAMBLA" 
replace councilor_attendance_meeting4 	= 26 				if commune == "KARANKASSO_SAMBLA" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' 	/// 
	 if commune == "KARANKASSO_SAMBLA" 
} 

replace date_2018meeting1 = date("04/15/2018", "MDY", 2050)	if commune == "KARANKASSO_SAMBLA" 
replace date_2018meeting2 = date("07/15/2018", "MDY", 2050)	if commune == "KARANKASSO_SAMBLA" 
replace date_2018meeting3 = date("09/15/2018", "MDY", 2050)	if commune == "KARANKASSO_SAMBLA" 
replace date_2018meeting4 = date("11/15/2018", "MDY", 2050)	if commune == "KARANKASSO_SAMBLA" 

*--- Less than 20 councilors in KARANKASSO_SAMBLA 
	// Replace by the right value 
replace total_councilor  		= 30 if commune == "KARANKASSO_SAMBLA" 
replace total_councilor_check   = 30 if commune == "KARANKASSO_SAMBLA" 

*--- Correct 2018 local taxes for LENA 
	// Was not calculated yet. 
replace local_taxes_2018_amount 		= 7582989					if commune == "LENA" 
replace local_taxes_forecast_2018 		= 8115000					if commune == "LENA" 

replace local_taxes_2018_amount_check 	= local_taxes_2018_amount 	if commune == "LENA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "LENA" 

*--- Correct transferred resources for LENA 
	// Data were missing 
replace ressources_transferees_2018 	 = 103802778					if commune == "LENA" 
replace depenses_ressources_transferees_ = 	93673916					if commune == "LENA" 

replace ressources_transferees_2018_chec = ressources_transferees_2018	if commune == "LENA" 
replace v151 = depenses_ressources_transferees_							if commune == "LENA" 

*--- Correct number of sessions and attendance for LENA 
	// Missing participation for 2 first sessions (While they delared 4 sessions) 
forvalues t = 1/2 { 
replace councilor_attendance_meeting`t' 	= . 			if commune == "LENA" 
replace councilor_attendance_meeting`t'_ch 	= . 			if commune == "LENA" 
} 

forvalues t = 1/2 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' 	/// 
	 if commune == "LENA" 
} 

*--- Correct 2018 local taxes for ORODARA 
	// Was not calculated yet 
replace local_taxes_2018_amount 		=  95337142						if commune == "ORODARA" 
replace local_taxes_forecast_2018 		= 129653444 					if commune == "ORODARA" 

replace local_taxes_2018_amount_check 	= local_taxes_2018_amount 		if commune == "ORODARA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 	if commune == "ORODARA" 

*--- Correct local taxes for KOUNDOUGOU 
	// There were missing in the data 
replace local_taxes_2018_amount 	= 10973965						if commune == "KOUNDOUGOU" 
replace local_taxes_forecast_2018 	=  7870000						if commune == "KOUNDOUGOU" 

replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "KOUNDOUGOU" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "KOUNDOUGOU" 

*--- Correct attendance score for KOUNDOUGOU 
	// Data were missing for all 4 sessions held 
replace councilor_attendance_meeting1 	= 17 				if commune == "KOUNDOUGOU" 
replace councilor_attendance_meeting2 	= 16 				if commune == "KOUNDOUGOU" 
replace councilor_attendance_meeting3 	= 18 				if commune == "KOUNDOUGOU" 
replace councilor_attendance_meeting4 	= 18 				if commune == "KOUNDOUGOU" 

replace date_2018meeting1 = date("02/26/2018", "MDY", 2050)	if commune == "KOUNDOUGOU" 
replace date_2018meeting2 = date("05/09/2018", "MDY", 2050)	if commune == "KOUNDOUGOU" 
replace date_2018meeting3 = date("06/18/2018", "MDY", 2050)	if commune == "KOUNDOUGOU" 
replace date_2018meeting4 = date("10/30/2018", "MDY", 2050)	if commune == "KOUNDOUGOU" 

forvalues t = 1/4 { 
replace councilor_attendance_meeting`t'_ch 	= councilor_attendance_meeting`t' /// 
	 if commune == "KOUNDOUGOU" 
} 


*--------------- NORD ------------ 
*--------------------------------- 

*--- Replace Birth certificate data for LEBA 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 768						if commune == "LEBA" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "LEBA" 

*--- Correct 2016 local taxes for KOUMBRI 
	// They were missing due to unavailable docmuents. 
replace local_taxes_2016 			= 14017000						if commune == "KOUMBRI" 
replace local_taxes_forecast_2016 	= 12969000						if commune == "KOUMBRI" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "KOUMBRI" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "KOUMBRI" 

*--- Correct transferred resources for KALSAKA 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "KALSAKA" 
replace v151 = depenses_ressources_transferees_							if commune == "KALSAKA" 

*--- Replace Birth certificate data for OUINDIGUI 
	// This was missing due to strikes 
replace birth_certificates_2018 		= 583						if commune == "OUINDIGUI" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "OUINDIGUI" 

*--- Correct transferred resources for YAKO 
	// Data were missing 
replace ressources_transferees_2018 	 = 306220379					if commune == "YAKO" 
replace depenses_ressources_transferees_ = 189866169					if commune == "YAKO" 

replace ressources_transferees_2018_chec = ressources_transferees_2018	if commune == "YAKO" 
replace v151 = depenses_ressources_transferees_							if commune == "YAKO" 

*--- Correct transferred resources for NAMISSIGUIMA_OUAHIGOUYA 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "NAMISSIGUIMA_OUAHIGOUYA" 
replace v151 = depenses_ressources_transferees_							if commune == "NAMISSIGUIMA_OUAHIGOUYA" 

*--- Correct transferred resources for THIOU 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "THIOU" 
replace v151 = depenses_ressources_transferees_							if commune == "THIOU" 

*--- Correct Birth certificate data for OUAHIGOUYA 
	// Data was wrong 
replace birth_certificates_2018 		= 4618						if commune == "OUAHIGOUYA" 
replace birth_certificates_2018_check 	= birth_certificates_2018 	if commune == "OUAHIGOUYA" 


*--------- PLATEAU CENTRAL ------- 
*--------------------------------- 

*--- Correct transferred resources for ZORGHO 
	// Tranferees less than depensees. 
	// This is due to depensees include 2017 and 2018; but all 2018 have been used 
replace depenses_ressources_transferees_ = ressources_transferees_2018	if commune == "ZORGHO" 
replace v151 = depenses_ressources_transferees_							if commune == "ZORGHO" 


*--------------- SAHEL ----------- 
*--------------------------------- 

*--- Correct 2016 and 2017 local taxes for NASSOUMBOU 
	// They were missing due to unavailable docmuents 
replace local_taxes_2017 			=  7599032						if commune == "NASSOUMBOU" 
replace local_taxes_forecast_2017 	= 10896331						if commune == "NASSOUMBOU" 

replace local_taxes_2016_check 			= local_taxes_2017 			if commune == "NASSOUMBOU" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2017 if commune == "NASSOUMBOU" 

*--- Replace Procurement data for MANSILA 
	// There were error in tha data (No activity in that commune) 
replace execution_equipment_procurement_ = 0 						if commune == "MANSILA" 
replace v153 = execution_equipment_procurement_ 					if commune == "MANSILA" 

*--- Correct local taxes for MANSILA 
	// They were missing 
replace local_taxes_2016 			= 17869412						if commune == "MANSILA" 
replace local_taxes_2017 			= 20500000						if commune == "MANSILA" 
replace local_taxes_2018_amount 	= 0								if commune == "MANSILA" // Missing due to insecurity, and municipality didn't work in 2018 
replace local_taxes_forecast_2016 	= 14213707						if commune == "MANSILA" 
replace local_taxes_forecast_2017 	= 16925000						if commune == "MANSILA" 
replace local_taxes_forecast_2018 	= 21710664 						if commune == "MANSILA" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "MANSILA" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "MANSILA" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "MANSILA" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "MANSILA" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "MANSILA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "MANSILA" 

*--- Correct local taxes for DEOU 
	// They were missing 
replace local_taxes_2016 			= 24255024						if commune == "DEOU" 
replace local_taxes_2017 			= 28500000						if commune == "DEOU" 
replace local_taxes_2018_amount 	= 0								if commune == "DEOU" // Missing due to insecurity, and municipality didn't work in 2018 
replace local_taxes_forecast_2016 	= 26535394						if commune == "DEOU" 
replace local_taxes_forecast_2017 	= 31656728						if commune == "DEOU" 
replace local_taxes_forecast_2018 	= 37079975 						if commune == "DEOU" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "DEOU" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "DEOU" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "DEOU" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "DEOU" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "DEOU" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "DEOU" 

*--- Local taxe for 2016 and 2017 missing for OURSI (due to Insecurity and archives not available) 
	// Data replaced from 2017 data set 
replace local_taxes_2016 			=  5426202						if commune == "OURSI" 
replace local_taxes_2017 			=  7612373						if commune == "OURSI" 
replace local_taxes_forecast_2016 	=  7562206						if commune == "OURSI" 
replace local_taxes_forecast_2017 	= 11339109						if commune == "OURSI" 

replace local_taxes_2016_check 			= local_taxes_2016 			if commune == "OURSI" 
replace local_taxes_2017_check 			= local_taxes_2017 			if commune == "OURSI" 
replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "OURSI" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "OURSI" 

*--- Correct 2016, 2017 and 2018 local taxes forecast for BARABOULE 
	// They were missing due to unavailable docmuents. 
replace local_taxes_forecast_2016 = 12113008						if commune == "BARABOULE" 
replace local_taxes_forecast_2017 = 11402307						if commune == "BARABOULE" 
replace local_taxes_forecast_2018 =  9863200						if commune == "BARABOULE" 

replace local_taxes_forecast_2016_check = local_taxes_forecast_2016 if commune == "BARABOULE" 
replace local_taxes_forecast_2017_check = local_taxes_forecast_2017 if commune == "BARABOULE" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "BARABOULE" 

*--- Correct 2018 local taxes forecast for KOUTOUGOU 
	// They were missing. 
replace local_taxes_2018_amount 		= 0							if commune == "KOUTOUGOU" 
replace local_taxes_forecast_2018 		= 108475424					if commune == "KOUTOUGOU" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "KOUTOUGOU" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018	if commune == "KOUTOUGOU" 

*--- Less than 20 councilors in DJIBO 
	// Replace by the right value 
replace total_councilor  		= 76 if commune == "DJIBO" 
replace total_councilor_check   = 76 if commune == "DJIBO" 

*--- Correct 2018 local taxes for SAMPELGA 
	// Data was not calculated yet 
replace local_taxes_2018_amount 		= 19762474					if commune == "SAMPELGA" 
replace local_taxes_forecast_2018 		= 59202508					if commune == "SAMPELGA" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount	if commune == "SAMPELGA" 
replace local_taxes_forecast_2018_check = local_taxes_forecast_2018 if commune == "SAMPELGA" 


*------------ SUD-OUEST ---------- 
*--------------------------------- 

*--- Correct 2018 local taxes for DIEBOUGOU 
	// Was not calculated yet 
replace local_taxes_2018_amount 		= 180698680					if commune == "DIEBOUGOU" 
replace local_taxes_2018_amount_check 	= local_taxes_2018_amount 	if commune == "DIEBOUGOU" 

*--- Correct the number of villages for KAMPTI 
	// Was not calculated yet 
replace villages 		= 117					if commune == "KAMPTI" 
replace villages_check  = villages 				if commune == "KAMPTI" 


*=================================== SAVE DATA 

save "${interm}/Municipalite ${year}_clean.dta", replace 
save "${interm}/Municipalite ${year}.dta", replace 



*=============================================================================== 
*============================== ACCES A L'EAU POTABLE ========================== 
*=============================================================================== 

/* Data on Water access is from the ministry in charge of Water and Sanitation 
   The data is received in Excel format and then imported to Stata */ 

clear all 
use "${raw}/Access Potable Water ${year}.dta", clear 							// Open raw data 

br if region == "" | province == "" | commune == "" 

/* Two communes are not part is this data collection */ 
drop if commune == "OUAGADOUGOU" | commune == "BOBO-DIOULASSO" 


*=== Save data 

save "${interm}/Access Potable Water ${year}_clean.dta", replace 
save "${interm}/Access Potable Water ${year}.dta", replace 


*=============================================================================== 
*=============================================================================== 
*=============================================================================== 
*=============================================================================== 


