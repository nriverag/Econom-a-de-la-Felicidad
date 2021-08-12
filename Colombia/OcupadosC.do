import delimited "K:\Presidencia\Asesor Economico\Pasantes Universitarios\Andrés Sánchez - UNacional\Ponencia de informalidad\Bases.csv\OC1.csv"
drop v1
egen ID = concat(año mes directorio secuencia_p hogar orden) 
destring ID, replace
duplicates report ID
duplicates drop ID, force
keep año p6430s1 p6430 p6870 p6880 p6880s1 clase rama2d rama4d inglabo ID p6920 p6915 p6765 p6772 p6775
describe
save OC1.dta, replace
clear 

import delimited "K:\Presidencia\Asesor Economico\Pasantes Universitarios\Andrés Sánchez - UNacional\Ponencia de informalidad\Bases.csv\OC2.csv"
drop v1
egen ID = concat(año mes directorio secuencia_p hogar orden) 
destring ID, replace
duplicates report ID
duplicates drop ID, force
keep año p6430s1 p6430 p6870 p6880 p6880s1 clase rama2d rama4d inglabo ID p6920 p6915 p6765 p6772 p6775
describe
save OC2.dta, replace
clear 

import delimited "K:\Presidencia\Asesor Economico\Pasantes Universitarios\Andrés Sánchez - UNacional\Ponencia de informalidad\Bases.csv\OC3.csv"
drop v1
egen ID = concat(año mes directorio secuencia_p hogar orden) 
destring ID, replace
duplicates report ID
duplicates drop ID, force
keep año p6430s1 p6430 p6870 p6880 p6880s1 clase rama2d rama4d inglabo ID p6920 p6915 p6765 p6772 p6775
describe
save OC3.dta, replace
clear 

import delimited "K:\Presidencia\Asesor Economico\Pasantes Universitarios\Andrés Sánchez - UNacional\Ponencia de informalidad\Bases.csv\OC19.csv"
drop v1
egen ID = concat(año mes directorio secuencia_p hogar orden) 
destring ID, replace
duplicates report ID
duplicates drop ID, force
keep año p6430s1 p6430 p6870 p6880 p6880s1 clase rama2d rama4d inglabo ID p6920 p6915 p6765 p6772 p6775
describe
save OC4.dta, replace
clear 

foreach i of num 2/4 {
	u OC`i'
	drop if inlist(p6920,"NA","Inf")
	destring p6920, replace
	save OC`i', replace
}
clear

u OC1
foreach i of num 2/4 {
         append using OC`i'
}
save OcupadosC.dta, replace
describe
clear

