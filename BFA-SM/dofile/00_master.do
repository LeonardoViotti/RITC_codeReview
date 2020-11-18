/* This is the master file for the creation of infographic 
   posters for the WB's DIME team. The program cleans the 
   raw data from several surveys; calculates indicator 
   scores, values, and totals of the performance 
   of 349 municipal governments in Burkina Faso. */ 

clear
version 13
set more off

/* =================================================== 
   ================== set globals ==================== 
   =================================================== */ 

global year = 2018 
global national_average = 64.8 
global groupnames = 0 
global workspace = 1 										// Please change this to "2" after setting your directory path in line 27 


   if $workspace == 1 { 
       global supermun18 "C:/Users/850/Dropbox/Peer_code_review_2020/Supermun" 
	   cd "$supermun18" 
   } 

   if $workspace == 2 { 
       global supermun18 " " 								// Please add your directory path 
	   cd "$supermun18" 
   } 


* define subfolders 
global raw  	"raw" 
global interm  	"intermediary" 
global final 	"final" 
global dofile  	"dofile" 

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

do "${dofile}/01_clean_0.do" 
do "${dofile}/01_clean_1.do" 

do "${dofile}/02_calculate_scores_ic.do" 
do "${dofile}/02_calculate_scores_sd.do" 

