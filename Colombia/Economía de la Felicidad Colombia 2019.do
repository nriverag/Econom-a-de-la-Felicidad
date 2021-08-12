/*******************************************************************************      
Nombre del programa: 	Economía de la Felicidad Colombia 2019 
Contacto:  				Nicolás Rivera Garzón (nriverag@unal.edu.co)
Objetivo: 				Modelo de elección sobre el nivel de felicidad en Colombia
						en 2019 con datos de la ECV 2019 del Dane. 
Archivos usados: 		* Características y composición del hogar
						* Datos de la vivienda
						* Servicios del hogar
						* Salud
						* Educación
						* Fuerza de Trabajo


*******************************************************************************/


********************************************************************************
******************  1. Creación de base de datos *******************************
********************************************************************************

* Limpieza de Resultados
set more off

* estout
ssc install estout, replace

* outreg2
ssc install outreg2, replace


*¨Cargar base de datos (CAMBIAR DIRECTORIO PARA REPLICAR) 
cd "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Data"
use "Caracteristicas y composicion del hogar", clear

* Unir con los demás diccionarios
* Datos de la Vivienda 
merge 1:1 DIRECTORIO SECUENCIA_ENCUESTA SECUENCIA_P ORDEN using "Datos de la vivienda"
drop if _merge==1
drop if _merge==2
drop _merge
* Educación 
merge 1:1 DIRECTORIO SECUENCIA_ENCUESTA SECUENCIA_P ORDEN using "Educación"
drop if _merge==1
drop if _merge==2
drop _merge
* Fuerza de Trabajo 
merge 1:1 DIRECTORIO SECUENCIA_ENCUESTA SECUENCIA_P ORDEN using "Fuerza de trabajo"
drop if _merge==1
drop if _merge==2
drop _merge
*Salud 
merge 1:1 DIRECTORIO SECUENCIA_ENCUESTA SECUENCIA_P ORDEN using "Salud"
drop if _merge==1
drop if _merge==2
drop _merge
*Servicios del hogar 
merge 1:1 DIRECTORIO SECUENCIA_ENCUESTA SECUENCIA_P ORDEN using "Servicios del Hogar"
drop if _merge==1
drop if _merge==2
drop _merge

* Creación de ID (No hay duplicados)
egen ID = concat(DIRECTORIO SECUENCIA_ENCUESTA SECUENCIA_P ORDEN) 
destring ID, replace
duplicates report ID
duplicates drop ID, force 
describe

* Guardar Base de datos 
save Personas, replace
clear all

********************************************************************************
******************  2. Creación de variables  **********************************
********************************************************************************
u Personas

* Género
tabulate P6020 // 1 Hombre 2 Mujer
gen mujer=0
replace mujer=1 if P6020==2

* Edad
drop if P6040<18
*Grupos etarios: 
*A: 18:25
gen A=0
replace A=1 if P6040 >= 18 &  P6040 <= 25
*B: 26-45
gen B=0
replace B=1 if P6040 >= 26 &  P6040 <= 45
*C: 45-60
gen C=0
replace C=1 if P6040 >= 46 &  P6040 <= 60
*D: 60+
gen D=0
replace D=1 if P6040 >= 60

* Casado
gen Casado=0
replace Casado=1 if P5502 == 6
tab Casado

* Mismo municipio nace y vive
gen Mun=0
replace Mun=1 if P756 == 1
tab Mun

* Campesino
gen Campesino=0
replace Campesino=1 if P2057 == 1
tab Campesino


* Región
* Caribe
gen Caribe = 0
replace Caribe = 1 if REGION == 1
* Oriental
gen Oriental = 0
replace Oriental = 1 if REGION == 2
* Central
gen Central = 0
replace Central = 1 if REGION == 3
* Pacifica sin valle
gen Pacifica = 0
replace Pacifica = 1 if REGION == 4
* Bogota
gen Bogota = 0
replace Bogota = 1 if REGION == 5
* Antioquia
gen Antioquia = 0
replace Antioquia = 1 if REGION == 6
* Valle del Cauca
gen Valle = 0
replace Valle = 1 if REGION == 7
* San Andres
gen SanAndres = 0
replace SanAndres = 1 if SanAndres == 8
* ORinoquia y Amazonia
gen OrinoAmazo = 0
replace OrinoAmazo = 1 if REGION == 9

* Energía Electrica
gen Electricidad = 0
replace Electricidad = 1 if P8520S1==1
*Acueducto
gen Acueducto = 0
replace Acueducto = 1 if P8520S5==1
* Alcantarillado
gen Alcantarillado = 0
replace Alcantarillado = 1 if P8520S3==1
* Basura
gen Basura = 0
replace Basura = 1 if P8520S4==1


* Nivel Educativo 
* Primaria 
gen Primaria=0
replace Primaria=1 if P8587==3
*Secundaria (media vocacional)
gen Secundaria=0
replace Secundaria=1 if P8587==5
*Terciaria
gen Terciaria=0
replace Terciaria=1 if P8587==7 | P8587==9 | P8587==11 | P8587==13


* Empleo
gen Trabaja = 0 
replace Trabaja=1 if P6240==1

* Contrato 
gen Contrato = 0 
replace Contrato=1 if P6440==1

* EPS
gen EPS = 0 
replace EPS=1 if P6090==1

* ARL 
gen ARL = 0 
replace ARL=1 if P6990==1


* Posición Ocupacional 
* Empleado Privado
gen EmpleadoPrivado = 0
replace EmpleadoPrivado = 1 if P6435==1
* Empleado Público
gen EmpleadoPublico = 0
replace EmpleadoPublico = 1 if P6435==2
* Empleado Doméstico
gen EmpleadoDomestico = 0
replace EmpleadoDomestico = 1 if P6435==3
* Patron
gen Patron = 0
replace Patron = 1 if P6435==6

save DF, replace
clear all 

********************************************************************************
*******************  3. Creación del modelo   **********************************
********************************************************************************
 u DF 
 
 * La variable endógena es: 
 * P1901: ¿qué tan feliz se sintió ... el día de ayer? Donde 0 significa que no experimento "para nada" esa sensación y 10 significa que experimentó "todo el tiempo" esa sensación.
	tab P1901
 
 * 	Se dividen los modelos agrupando según las carácterísticas de las Xs
 
 * Carácterísticas y Composición del Hogar
 
* Ordered Logit 
ologit P1901 mujer A B C D Casado Mun Campesino
estimates store C1, title("Ordered Logit")
outreg2 C1 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Generales.xls", replace ctitle("Ordered Logit") 

* Ordered Logit: ODD Ratio
ologit P1901 mujer A B C D Casado Mun Campesino, or

 * Ordered Probit
 oprobit P1901 mujer A B C D Casado Mun Campesino
estimates store C2, title("Ordered Probit")
outreg2 C2 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Generales.xls", append ctitle("Ordered Probit") 
esttab C1 C2 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Generales.tex", replace b(%9.2f) se(%9.3f) r2(%9.2f)

 
 *Oredered Probit: OR
 oprobit P1901 mujer A B C D Casado Mun Campesino

 * Datos de la vivienda 
 * Ordered Logit 
ologit P1901 Caribe Oriental Central Pacifica Bogota Antioquia Valle SanAndres OrinoAmazo Electricidad Acueducto Alcantarillado Basura 
estimates store C1, title("Ordered Logit")
outreg2 C1 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Vivienda.xls", replace ctitle("Ordered Logit") 


* Ordered Logit: ODD Ratio
ologit P1901 Caribe Oriental Central Pacifica Bogota Antioquia Valle SanAndres OrinoAmazo Electricidad Acueducto Alcantarillado Basura, or

 * Ordered Probit
oprobit P1901 Caribe Oriental Central Pacifica Bogota Antioquia Valle SanAndres OrinoAmazo Electricidad Acueducto Alcantarillado Basura 
estimates store C2, title("Ordered Probit")
outreg2 C2 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Vivienda.xls", append ctitle("Ordered Probit") 
esttab C1 C2 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Vivienda.tex", replace b(%9.2f) se(%9.3f) r2(%9.2f)

 
 *Oredered Probit: OR
oprobit P1901 Caribe Oriental Central Pacifica Bogota Antioquia Valle SanAndres OrinoAmazo Electricidad Acueducto Alcantarillado Basura
 
 * Educación 
  * Ordered Logit 
ologit P1901 Primaria Secundaria Terciaria
estimates store C1, title("Ordered Logit")
outreg2 C1 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Educacion.xls", replace ctitle("Ordered Logit") 

* Ordered Logit: ODD Ratio
ologit P1901 Primaria Secundaria Terciaria, or

 * Ordered Probit
oprobit P1901 Primaria Secundaria Terciaria
estimates store C2, title("Ordered Probit")
outreg2 C2 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Educacion.xls", append ctitle("Ordered Probit") 
esttab C1 C2 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Educacion.tex", replace b(%9.2f) se(%9.3f) r2(%9.2f)

 *Oredered Probit: OR
oprobit P1901 Primaria Secundaria Terciaria

* Trabajo y Salud 
  * Ordered Logit 
ologit P1901 Trabaja Contrato EPS ARL EmpleadoPrivado EmpleadoPublico EmpleadoDomestico Patron
estimates store C1, title("Ordered Logit")
outreg2 C1 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Trabajo.xls", replace ctitle("Ordered Logit") 

* Ordered Logit: ODD Ratio
ologit P1901 Trabaja Contrato EPS ARL EmpleadoPrivado EmpleadoPublico EmpleadoDomestico Patron, or

 * Ordered Probit
oprobit P1901 Trabaja Contrato EPS ARL EmpleadoPrivado EmpleadoPublico EmpleadoDomestico Patron
estimates store C2, title("Ordered Probit")
outreg2 C2 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Trabajo.xls", append ctitle("Ordered Probit") 
esttab C1 C2 using "C:\Users\Nicolás Rivera\OneDrive\Documentos\2021-1\Tópicos microeconometría\Paper\Colombia\Output\T1Trabajo.tex", replace b(%9.2f) se(%9.3f) r2(%9.2f)
 
 *Oredered Probit: OR
oprobit P1901 Trabaja Contrato EPS ARL EmpleadoPrivado EmpleadoPublico EmpleadoDomestico Patron
clear all
 

