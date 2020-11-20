/* This is the master file for the creation of infographic 
   posters for the WB's DIME team. The program cleans the 
   raw data from several surveys; calculates indicator 
   scores, values, and totals of the performance 
   of 349 municipal governments in Burkina Faso. */ 

clear
version 13
set more off
set varabbrev off

/* =================================================== 
   ================ section swtiches ================= 
   =================================================== */ 

// Add brief description of what 01_clean_0.do does
global clean_0 = 1

// Add brief description of what 01_clean_1.do does
global clean_1 = 1

// Add brief description of what 02_calculate_scores_ic.do does
global calculate_scores_ic = 1

// Add brief description of what 02_calculate_scores_sd.do does
global calculate_scores_sd = 1

/* =================================================== 
   ================== set globals ==================== 
   =================================================== */ 

global year = 2018 
global national_average = 64.8 
global groupnames = 0 

// Sekou
if "`c(username)'" == "850"{
	global supermun18 "C:/Users/850/Dropbox/Peer_code_review_2020/Supermun" 
   } 

// Leonardo
if "`c(username)'" == "wb519128" | "`c(username)'" == "WB519128"{
	global supermun18 "C:\Users\wb519128\GitHub\code-review\BFA-SM"
} 


* define subfolders 
global raw  	"${supermun18}/raw" 
global interm  	"${supermun18}/intermediary" 
global final 	"${supermun18}/final" 
global dofile  	"${supermun18}/dofile" 

* create subfolders if they don't already exist 
foreach dir in $interm $final { 
	capture drop "`dir'" 
	cap confirm file "`dir'/nul" 
	if _rc { 
		mkdir "`dir'" 
	} 
} 


/* =================================================== 
   ================== run do-files =================== 
   =================================================== */ 

if $clean_0{
	do "${dofile}/01_clean_0.do" 
}
if $clean_1{
	do "${dofile}/01_clean_1.do" 
}
if $calculate_scores_ic{
	do "${dofile}/02_calculate_scores_ic.do" 
}
if $calculate_scores_sd{
	do "${dofile}/02_calculate_scores_sd.do" 
}


