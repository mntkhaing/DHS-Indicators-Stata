/*****************************************************************************************************
Program: 			FE_tables.do
Purpose: 			produce tables for fertility indicators
Author:				Courtney Allen
Date last modified: Oct 21 2019 by Courtney Allen

*Note this do file will produce the following tables in excel:
	1. 	Tables_FERT:		Contains the tables for fertility indicators
	2. 	Tables_POST:		Contains the tables for postpartum and birth interval indicators


Notes: 
*****************************************************************************************************/

* the total will show on the last row of each table.
* comment out the tables or indicator section you do not want.
****************************************************

* indicators from IR file
if file=="IR" {

//subgroups
local subgroup residence region education wealth 

**************************************************************************************************
* Indicators for fertility: excel file Tables_FERT will be produced
**************************************************************************************************
//Currently pregnant by background variables

* age
tab v013 fe_preg  [iw=wt], row nofreq 

* residence
tab v025 fe_preg  [iw=wt], row nofreq 

* region
tab v024 fe_preg  [iw=wt], row nofreq 

* education
tab v106 fe_preg  [iw=wt], row nofreq 

* wealth
tab v190 fe_preg  [iw=wt], row nofreq 

* output to excel
tabout v013 v025 v024 v106 v190 fe_preg  using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) replace 
*/

**************************************************************************************************
//Complete fertility - mean number of children ever born among women age 40-49

* mean number of children ever born among women age 40-49
tabout fe_ceb_comp using Tables_FE_Fert.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append 

* mean number of children ever born among women age 40-49, by subgroup
local subgroup residence region education wealth 

* output to excel
foreach y in `subgroup' {
	tabout fe_ceb_comp_`y'*  using Tables_FE_Fert.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append 
	}

	
**************************************************************************************************
//Number of children ever born

* number of children ever born
tab fe_ceb_num [iw=wt]

* by age
tab v013 fe_ceb_num [iw=wt], row

* output to excel
tabout v013 fe_ceb_num using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) ptotal(none)    append 
tabout fe_ceb_num using Tables_FE_Fert.xls [iw=wt] , c(cell) f(1) ptotal(none)    append 


**************************************************************************************************
//Number of children ever born among currently married women

* number of children ever born
tab fe_ceb_num if v502==1 [iw=wt]

* by age
tab v013 fe_ceb_num if v502==1 [iw=wt], row

* output to excel
tabout v013 fe_ceb_num if v502==1 using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) ptotal(none)    append 
tabout fe_ceb_num if v502==1 using Tables_FE_Fert.xls [iw=wt] , c(cell) f(1) ptotal(none)    append 

**************************************************************************************************
//Mean number of children ever born

* mean number of children ever born
tabout fe_ceb_mean using Tables_FE_Fert.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append 

* mean number of children ever born, by age group
levelsof v013
local agelevels = r(levels)
foreach y in `agelevels' {
	tabout fe_ceb_mean_age`y'*  using Tables_FE_Fert.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append 
	}
	
**************************************************************************************************
//Mean number of living children

* mean number of living children
tabout fe_live_mean using Tables_FE_Fert.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append 

* mean number of of living children, by age group
levelsof v013
local agelevels = r(levels)
foreach y in `agelevels' {
	tabout fe_live_mean_age`y'*  using Tables_FE_Fert.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append 
	}

	
**************************************************************************************************
//Menopause

* Experienced menopause
tab fe_meno [iw=wt]

* by age
tab fe_meno_age fe_meno [iw=wt], row

* output to excel
tabout fe_meno_age fe_meno using Tables_FE_Fert.xls [iw=wt] ,  c(row) f(1) ptotal(none)  append 
	
	
**************************************************************************************************	
//Age at first birth by background variables

* percent had first birth by specific ages, by age group
tab v013 ms_afb_15  [iw=wt], row nofreq 
tab ms_afb_15 if v013>=2 [iw=wt]
tab ms_afb_15 if v013>=3 [iw=wt]

tab v013 ms_afb_18 if v013>=2  [iw=wt], row nofreq 
tab ms_afb_18 if v013>=2 [iw=wt]
tab ms_afb_18 if v013>=3 [iw=wt]

tab v013 ms_afb_20 if v013>=2  [iw=wt], row nofreq 
tab ms_afb_20 if v013>=2 [iw=wt]
tab ms_afb_20 if v013>=3 [iw=wt]

tab v013 ms_afb_22 if v013>=3  [iw=wt], row nofreq 
tab ms_afb_22 if v013>=3 [iw=wt]

tab v013 ms_afb_25 if v013>=3  [iw=wt], row nofreq 
tab ms_afb_25 if v013>=3 [iw=wt]


* output to excel
* percent had first birth by specific ages, by age group
tabout v013 ms_afb_15 using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) append 
tabout v013 ms_afb_18 if v013>=2 using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) append 
tabout v013 ms_afb_20 if v013>=2 using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) append 
tabout v013 ms_afb_22 if v013>=3 using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) append 
tabout v013 ms_afb_25 if v013>=3 using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) append 

* percent had first birth by specific ages, among 20-49 and 25-49 year olds
tabout ms_afb_15 ms_afb_18 ms_afb_20 if v013>=2 [iw=wt] using Tables_FE_Fert.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append 
tabout ms_afb_15 ms_afb_18 ms_afb_20 ms_afb_22 ms_afb_25 if v013>=3 [iw=wt] using Tables_FE_Fert.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append 

**************************************************************************************************
//Never given birth by background variables

* never given birth
tab v013 fe_birth_never  [iw=wt], row nofreq 
tab fe_birth_never if v013>=2 [iw=wt] //among 20-49 yr olds
tab fe_birth_never if v013>=3 [iw=wt] //among 25-49 yr olds

* output to excel
tabout v013 fe_birth_never using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) append 
tabout fe_birth_never if v013>=2 [iw=wt] using Tables_FE_Fert.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append 
tabout fe_birth_never if v013>=3 [iw=wt] using Tables_FE_Fert.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append 

**************************************************************************************************
//Median age at first birth by background variables

*median age at first birth by age group
tabout mafb_1519_all1 mafb_2024_all1 mafb_2529_all1 mafb_3034_all1 mafb_3539_all1 mafb_4044_all1 mafb_4549_all1 mafb_2049_all1 mafb_2549_all1 using Tables_FE_Fert.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append 

*median age at first marriage among 25-49 yr olds, by subgroup
local subgroup residence region education wealth 

foreach y in `subgroup' {
	tabout mafb_2549_`y'*  using Tables_FE_Fert.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append 
	}

	
**************************************************************************************************
//Teens (age 15-19) had a live birth by background variables

* age
tab v012 fe_teen_birth  [iw=wt], row nofreq 

* residence
tab v025 fe_teen_birth  [iw=wt], row nofreq 

* region
tab v024 fe_teen_birth  [iw=wt], row nofreq 

* education
tab v106 fe_teen_birth  [iw=wt], row nofreq 

* wealth
tab v190 fe_teen_birth  [iw=wt], row nofreq 

* output to excel
tabout v012 v025 v024 v106 v190 fe_teen_birth  using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) append 
*/


**************************************************************************************************
//Teens (age 15-19) currently pregnant by background variables

* age
tab v012 fe_teen_preg  [iw=wt], row nofreq 

* residence
tab v025 fe_teen_preg  [iw=wt], row nofreq 

* region
tab v024 fe_teen_preg  [iw=wt], row nofreq 

* education
tab v106 fe_teen_preg  [iw=wt], row nofreq 

* wealth
tab v190 fe_teen_preg  [iw=wt], row nofreq 

* output to excel
tabout v012 v025 v024 v106 v190 fe_teen_preg  using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) append 
*/


**************************************************************************************************
//Teens (age 15-19) begun childbearing by background variables

* age
tab v012 fe_teen_beg  [iw=wt], row nofreq 

* residence
tab v025 fe_teen_beg  [iw=wt], row nofreq 

* region
tab v024 fe_teen_beg  [iw=wt], row nofreq 

* education
tab v106 fe_teen_beg  [iw=wt], row nofreq 

* wealth
tab v190 fe_teen_beg  [iw=wt], row nofreq 

* output to excel
tabout v012 v025 v024 v106 v190 fe_teen_beg  using Tables_FE_Fert.xls [iw=wt] , c(row) f(1) append 
*/

}