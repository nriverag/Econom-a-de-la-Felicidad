/*******************************************************************************      
Nombre del programa: 	AER_2012_Replication 
Contacto:  				Nicolás Rivera Garzón (nriverag@unal.edu.co)
Objetivo: 				Replicates all tables from "What Do You Think Would Make You 
						Happier? What Do You Think You Would Choose?" (
						Benjamin et al.), AER, 2012
Archivos usados: 		*  CornellData.dta
						*  CornellDataDemeaned.dta	

*******************************************************************************/


********************************************************************************
******************  1. Creación de base de datos centrada    *******************
********************************************************************************

* Limpieza de Resultados
set more off

* estout
ssc install estout, replace

* outreg2
ssc install outreg2, replace


*¨Cargar base de datos (CAMBIAR DIRECTORIO PARA REPLICAR) 
use "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Data\CornellData.dta", clear


* Centrar variables con respecto a su media
foreach var in choice own_happiness family_s_happiness health romantic_life ///
	social_life control_over_your_life life_s_level_of_spirituality ///
	life_s_level_of_fun social_status life_s_non_boringness physical_comfort sense_of_purpose {
gen dm`var'=.
forvalues i=2/11 {
sum `var' if question_number==`i'
replace dm`var'=`var'-r(mean) if question_number==`i'
}
}

* Reemplazar variables centradas en el nombre de las variables originales
foreach var in choice own_happiness family_s_happiness health romantic_life ///
	social_life control_over_your_life life_s_level_of_spirituality ///
	life_s_level_of_fun social_status life_s_non_boringness physical_comfort sense_of_purpose {
replace `var'=dm`var' 
drop dm`var'
}


* Cambiar el directorio a la dirección deseada	
save "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Data\CornellDataDemeaned.dta", replace
clear all

********************************************************************************
****************** 2. Creación de tablas de resultados 3 y 4 *******************
********************************************************************************

**** TABLA 3 ***

*¨Cargar base de datos centrada (CAMBIAR DIRECTORIO PARA REPLICAR) 
use "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Data\CornellDataDemeaned.dta", clear

* Hacer una variable dummy que detecte si alguno de los aspectos quedó sin respuesta
gen allaspectsanswered=1
foreach var in choice own_happiness family_s_happiness health romantic_life ///
	social_life control_over_your_life life_s_level_of_spirituality ///
	life_s_level_of_fun social_status life_s_non_boringness physical_comfort sense_of_purpose {
	replace allaspectsanswered=0 if `var'==.
	}

* Columna 1: Regresión de elección en SWB OLS
reg choice own_happiness if allaspectsanswer==1, nocons
estimates store columna1, title("OLS")
outreg2 columna1 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Output\Tabla3.xls", replace ctitle("Regresión de elección en SWB OLS") 


* Columna 2: Regresión de elección en aspectos no relacionados con el SWB OLS
reg choice family_s_happiness-sense_of_purpose if allaspectsanswer==1, nocons
estimates store columna2, title("OLS")
outreg2 columna2 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Output\Tabla3.xls", append ctitle("Regresión de elección en aspectos no relacionados con el SWB OLS") 

* Columna 3: regresión de elección en todos los aspectos OLS
reg choice own_happiness-sense_of_purpose, nocons
estimates store columna3, title("OLS")
outreg2 columna3 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Output\Tabla3.xls", append ctitle("Regresión de elección en todos los aspectos OLS") 


* Columna 4 PROBIT ORDENADO
use "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Data\CornellData.dta", clear
oprobit choice own_happiness-sense_of_purpose qnum1-qnum9
estimates store columna4, title("Ordered Probit")
outreg2 columna4 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Output\Tabla3.xls", append ctitle("PROBIT ORDENADO") 


* Columna 5: PROBIT
gen binary_choice=.
replace binary_choice=0  if inlist(choice,1,2,3)
replace binary_choice=1 if inlist(choice,4,5,6)

probit binary_choice own_happiness-sense_of_purpose qnum1-qnum9
estimates store columna5, title("Probit")
drop binary_choice

outreg2 columna5 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Output\Tabla3.xls", append ctitle("PROBIT") 


esttab columna1 columna2 columna3 columna4 columna5 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Output\Table3_AER_2012.tex", replace b(%9.2f) se(%9.3f) r2(%9.2f)


**** TABLA 4 ***

* Cargar datos 	
use "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Data\CornellDataDemeaned.dta", clear


* Cálculo de la primera columna, con todos los datos agrupados.
reg choice own_hap, noconst
local inc1=e(r2)

reg choice own_happiness-sense_of_purpose, noconst
local incr2 e(r2)-`inc1'
eststo incremental0, title("All questions") addscalars(incr2 `incr2')


* Calcular las regresiones específicas de cada pregunta
forvalues i=1/10 {

reg choice own_hap if question_number==`i'+1, noconst
local inc1=e(r2)

reg choice own_happiness-sense_of_purpose if question_number==`i'+1, noconst
local incr2 e(r2)-`inc1'
eststo incremental`i', title("Question `i'") addscalars(incr2 `incr2')
outreg2 incremental`i' using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Output\Tabla4.xls", append ctitle(`i') 
}

esttab incremental0 incremental1 incremental2 incremental3 incremental4 incremental5 incremental6 incremental7 incremental8 incremental9 incremental10  using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\AER_2012\Output\Table4_AER_2012.tex", replace b(%9.2f) se(%9.3f) label compress mtitles scalar("incr2 Incremental R2") r2(%9.2f) nonumbers


clear all




