# Code
*creating year-specific variables for income, municipalitey familytype, prfession and educationlevel

foreach year of numlist 2001/2003{
insheet using "`DATA_FOLDER'/LISA`year'_CLEAN.txt", clear tab
rename dispinkpersf income_`year'

foreach var in kommun famtypf ssyk4{
rename `var' `var'_`year'
}
gen education_`year' =.
destring sun2000niva_old, force replace
replace education_`year'=1 if sun2000niva_old==1 | sun2000niva_old==2 
replace education_`year'=2 if sun2000niva_old==3 | sun2000niva_old==4 
replace education_`year'=3 if sun2000niva_old==5 | sun2000niva_old==6 | sun2000niva_old==7 
keep lopnr education_`year' income_`year'  kommun_`year' ssyk4_`year'
save "`TEMP_FOLDER'/LISA`year'.dta", replace
}

set more off
local TEMP_FOLDER = "K:/temp"
local RESULT_FOLDER = "K:/results"
local DATA_FOLDER = "K:/DOGCHILD/"


foreach year of numlist 2004/2010{
insheet using "`DATA_FOLDER'/LISA`year'_CLEAN.txt", clear tab
rename dispinkpersf04 income_`year'

foreach var in kommun famtypf ssyk4{
rename `var' `var'_`year'
}
gen education_`year' =.
destring sun2000niva_old, force replace
replace education_`year'=1 if sun2000niva_old==1 | sun2000niva_old==2 
replace education_`year'=2 if sun2000niva_old==3 | sun2000niva_old==4 
replace education_`year'=3 if sun2000niva_old==5 | sun2000niva_old==6 | sun2000niva_old==7 
keep lopnr education_`year' income_`year'  kommun_`year' ssyk4_`year'
save "`TEMP_FOLDER'/LISA`year'.dta", replace
}


foreach year of numlist 2000/2009{
merge 1:1 lopnr using "`TEMP_FOLDER'/LISA`year'.dta"
drop _merge
}
