*Metodología para la elaboración del indicador de acceso a crédito agropecuario y rural*

*Objetivo: , el objetivo de este documento es elaborar un indicador de acceso a crédito rural y agropecuario a nivel nacional y departamental que 
*sea de utilidad en la focalización de operaciones de crédito y aseguramiento dentro del sector agropecuario. 


*1. Directorio
cd "K:\Presidencia\Asesor Economico\Pasantes Universitarios\Andrés Sánchez - UNacional\INDICADOR DE ACCESO\Construcción de serie"

* Cada mes el DANE publica los microdatos de la GEIH, de los datos se necesitan los siguientes modulos:
       *- Cabecera - Características generales (Personas)
	   *- Cabecera - Ocupados
	   *- Resto - Características generales (Personas)
	   *- Resto - Ocupados

* Lo anterior implica que para el calculo del indicador en un solo año se necesitan 48 archivos. Para facilitar los procedimientos posteriores, los archivos tendran los
* siguientes nombres:
       *- Cabecera - Características generales (Personas): "Cabecerapersonas2019`número del mes'"
	   *- Cabecera - Ocupados: "Cabeceraocupados2019`número del mes'"
	   *- Resto - Características generales (Personas): "Restopersonas2019`número del mes'"
	   *- Resto - Ocupados: "Restoocupados2019`número del mes'" 

*Por ejemplo, los archivos para el mes de junio de 2019 deberán tener el siguiente nombre: 
       *- "Cabecerapersonas20197"
       *- "Cabeceraocupados20197"
       *- "Restopersonas20197"
       *- "Restoocupados20197" 
	   
* Los meses con un  solo dígito tendrán un número solo en su notación, no nombrarlos 07 o 08. 

* Para el periodo 2017-2020 se usa los archivos .dta que publica el DANE.
* Para el resto de años se usan los archivos .txt debido a que el DANE no publica los archivos con extensión .dta

*2. Creación de base de datos de empleo en cabeceras y resto: el objetivo de esta sección es unir el modulo de características generales con el de ocupados.
*Para evitar errores se va a hacer un loop por cada año y cada zona.  

*2010***
*Cabecera
foreach i of num 1/12 {
    import delimited Cabeceraocupados2010`i'.txt
	keep p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save CabeceraO2010`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Cabecerapersonas2010`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save CabeceraP2010`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u CabeceraP2010`i'
         merge m:m directorio orden using CabeceraO2010`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2010`i', replace
 }
clear


u Cabecera20101
foreach i of num 2/12 {
		 append using Cabecera2010`i'
		 save Cabecera2010, replace
 }
clear


* Resto
foreach i of num 1/12 {
    import delimited Restoocupados2010`i'.txt
	keep p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save RestoO2010`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Restopersonas2010`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save RestoP2010`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u RestoP2010`i'
         merge m:m directorio orden using RestoO2010`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2010`i', replace
 }
clear

u Resto20101
foreach i of num 2/12 {
		 append using Resto2010`i'
		 save Resto2010, replace
 }
clear



*2011****
*Cabecera
foreach i of num 1/12 {
    import delimited Cabeceraocupados2011`i'.txt
	keep p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save CabeceraO2011`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Cabecerapersonas2011`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save CabeceraP2011`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u CabeceraP2011`i'
         merge m:m directorio orden using CabeceraO2011`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2011`i', replace
 }
clear


u Cabecera20111
foreach i of num 2/12 {
		 append using Cabecera2011`i'
		 save Cabecera2011, replace
 }
clear


* Resto
foreach i of num 1/12 {
    import delimited Restoocupados2011`i'.txt
	keep p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save RestoO2011`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Restopersonas2011`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save RestoP2011`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u RestoP2011`i'
         merge m:m directorio orden using RestoO2011`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2011`i', replace
 }
clear


u Resto20111
foreach i of num 2/12 {
		 append using Resto2011`i'
		 save Resto2011, replace
 }
clear


*2012****
*Cabecera
foreach i of num 1/12 {
    import delimited Cabeceraocupados2012`i'.txt
	keep p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save CabeceraO2012`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Cabecerapersonas2012`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save CabeceraP2012`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u CabeceraP2012`i'
         merge m:m directorio orden using CabeceraO2012`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2012`i', replace
 }
clear


u Cabecera20121
foreach i of num 2/12 {
		 append using Cabecera2012`i'
		 save Cabecera2012, replace
 }
clear


* Resto
foreach i of num 1/12 {
    import delimited Restoocupados2012`i'.txt
	keep p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save RestoO2012`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Restopersonas2012`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save RestoP2012`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u RestoP2012`i'
         merge m:m directorio orden using RestoO2012`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2012`i', replace
 }
clear

u Resto20121
foreach i of num 2/12 {
		 append using Resto2012`i'
		 save Resto2012, replace
 }
clear



*2013****
*Cabecera
foreach i of num 1/12 {
    import delimited Cabeceraocupados2013`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save CabeceraO2013`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Cabecerapersonas2013`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save CabeceraP2013`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u CabeceraP2013`i'
         merge m:m directorio orden using CabeceraO2013`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2013`i', replace
 }
clear

u Cabecera20131
foreach i of num 2/12 {
         append using Cabecera2013`i'
		 save Cabecera2013, replace
 }
clear


* Resto
foreach i of num 1/12 {
    import delimited Restoocupados2013`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save RestoO2013`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Restopersonas2013`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save RestoP2013`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u RestoP2013`i'
         merge m:m directorio orden using RestoO2013`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2013`i', replace
 }
clear

u Resto20131
foreach i of num 2/12 {
         append using Resto2013`i'
		 save Resto2013, replace
 }
clear



*2014****
*Cabecera
foreach i of num 1/12 {
    import delimited Cabeceraocupados2014`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save CabeceraO2014`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Cabecerapersonas2014`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save CabeceraP2014`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u CabeceraP2014`i'
         merge m:m directorio orden using CabeceraO2014`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2014`i', replace
 }
clear

u Cabecera20141
foreach i of num 2/12 {
		 append using Cabecera2014`i'
		 save Cabecera2014, replace
 }
clear


* Resto
foreach i of num 1/12 {
    import delimited Restoocupados2014`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save RestoO2014`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Restopersonas2014`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save RestoP2014`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u RestoP2014`i'
         merge m:m directorio orden using RestoO2014`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2014`i', replace
 }
clear

u Resto20141
foreach i of num 2/12 {
		 append using Resto2014`i'
		 save Resto2014, replace
 }
clear



*2015****
*Cabecera
foreach i of num 1/12 {
    import delimited Cabeceraocupados2015`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save CabeceraO2015`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Cabecerapersonas2015`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save CabeceraP2015`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u CabeceraP2015`i'
         merge m:m directorio orden using CabeceraO2015`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2015`i', replace
 }
clear

u Cabecera20151
foreach i of num 2/12 {
		 append using Cabecera2015`i'
		 save Cabecera2015, replace
 }
clear


* Resto
foreach i of num 1/12 {
    import delimited Restoocupados2015`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save RestoO2015`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Restopersonas2015`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save RestoP2015`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u RestoP2015`i'
         merge m:m directorio orden using RestoO2015`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2015`i', replace
 }
clear


u Resto20151
foreach i of num 2/12 {
		 append using Resto2015`i'
		 save Resto2015, replace
 }
clear



*2016****
*Cabecera
foreach i of num 1/12 {
    import delimited Cabeceraocupados2016`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save CabeceraO2016`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Cabecerapersonas2016`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save CabeceraP2016`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u CabeceraP2016`i'
         merge m:m directorio orden using CabeceraO2016`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2016`i', replace
 }
clear

u Cabecera20161
foreach i of num 2/12 {
		 append using Cabecera2016`i'
		 save Cabecera2016, replace
 }
clear


* Resto
foreach i of num 1/12 {
    import delimited Restoocupados2016`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save RestoO2016`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Restopersonas2016`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save RestoP2016`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u RestoP2016`i'
         merge m:m directorio orden using RestoO2016`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2016`i', replace
 }
clear

u Resto20161
foreach i of num 2/12 {
		 append using Resto2016`i'
		 save Resto2016, replace
 }
clear



*2017****
*Cabecera
foreach i of num 1/12 {
    import delimited Cabeceraocupados2017`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save CabeceraO2017`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Cabecerapersonas2017`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save CabeceraP2017`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u CabeceraP2017`i'
         merge m:m directorio orden using CabeceraO2017`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2017`i', replace
 }
clear

u Cabecera20171
foreach i of num 2/12 {
		 append using Cabecera2017`i'
		 save Cabecera2017, replace
 }
clear


* Resto
foreach i of num 1/12 {
    import delimited Restoocupados2017`i'.txt
	keep p388 p6500 p6780 p6880 p6920 p7070 rama4d rama2d fex_c_2011 p7050 p6430 p7077 oficio inglabo directorio orden
	save RestoO2017`i', replace
	clear
 }
clear

foreach i of num 1/12 {
    import delimited Restopersonas2017`i'.txt
    keep directorio orden p6040 p6220 p6020 fex_c_2011 dpto p6050 esc 
	save RestoP2017`i', replace
	clear
 }
clear

foreach i of num 1/12 {
         u RestoP2017`i'
         merge m:m directorio orden using RestoO2017`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2017`i', replace
 }
clear

u Resto20171
foreach i of num 2/12 {
		 append using Resto2017`i'
		 save Resto2017, replace
 }
clear


* Año 2018
*Cabecera
foreach i of num 1/12 {
         u Cabeceraocupados2018`i'
	keep P388 P6500 P6780 P6880 P6920 P7070 RAMA4D RAMA2D fex_c_2011 P7050 P6430 P7077 OFICIO INGLABO DIRECTORIO ORDEN
	save CabeceraO2018`i', replace
 }
clear

foreach i of num 1/12 {
         u Cabecerapersonas2018`i'
    keep  DIRECTORIO ORDEN P6040 P6220 P6020 fex_c_2011 DPTO P6050 ESC 
	save CabeceraP2018`i', replace
 }
clear

foreach i of num 1/12 {
         u CabeceraP2018`i'
         merge m:m DIRECTORIO ORDEN using CabeceraO2018`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2018`i', replace
 }
clear

u Cabecera20181
foreach i of num 2/12 {
		 append using Cabecera2018`i'
		 save Cabecera2018, replace
 }
clear


* Resto
foreach i of num 1/12 {
    u Restoocupados2018`i'
	keep P388 P6500 P6780 P6880 P6920 P7070 RAMA4D RAMA2D fex_c_2011 P7050 P6430 P7077 OFICIO INGLABO DIRECTORIO ORDEN
	save RestoO2018`i', replace
 }
clear

foreach i of num 1/12 {
    u Restopersonas2018`i'
    keep  DIRECTORIO ORDEN P6040 P6220 P6020 fex_c_2011 DPTO P6050 ESC 
	save RestoP2018`i', replace
 }
clear

foreach i of num 1/12 {
         u RestoP2018`i'
         merge m:m DIRECTORIO ORDEN using RestoO2018`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2018`i', replace
 }
clear

u Resto20181
foreach i of num 2/12 {
		 append using Resto2018`i'
		 save Resto2018, replace
 }
clear

* Año 2019
*Cabecera
foreach i of num 1/12 {
    u Cabeceraocupados2019`i'
	keep P388 P6500 P6780 P6880 P6920 P7070 RAMA4D RAMA2D fex_c_2011 P7050 P6430 P7077 OFICIO INGLABO DIRECTORIO ORDEN
	save CabeceraO2019`i', replace
 }
clear

foreach i of num 1/12 {
    u Cabecerapersonas2019`i'
    keep  DIRECTORIO ORDEN P6040 P6220 P6020 fex_c_2011 DPTO P6050 ESC 
	save CabeceraP2019`i', replace
 }
clear

foreach i of num 1/12 {
         u CabeceraP2019`i'
         merge m:m DIRECTORIO ORDEN using CabeceraO2019`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2019`i', replace
 }
clear

u Cabecera20191
foreach i of num 2/12 {
		 append using Cabecera2019`i'
		 save Cabecera2019, replace
 }
clear


* Resto
foreach i of num 1/12 {
         u Restoocupados2019`i'
	keep P388 P6500 P6780 P6880 P6920 P7070 RAMA4D RAMA2D fex_c_2011 P7050 P6430 P7077 OFICIO INGLABO DIRECTORIO ORDEN
	save RestoO2019`i', replace
 }
clear

foreach i of num 1/12 {
         u Restopersonas2019`i'
    keep  DIRECTORIO ORDEN P6040 P6220 P6020 fex_c_2011 DPTO P6050 ESC 
	save RestoP2019`i', replace
 }
clear

foreach i of num 1/12 {
         u RestoP2019`i'
         merge m:m DIRECTORIO ORDEN using RestoO2019`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2019`i', replace
 }
clear

u Resto20191
foreach i of num 2/12 {
		 append using Resto2019`i'
		 save Resto2019, replace
 }
clear


*****
*2020: para el año en curso agregar un loop más a medida que el DANE publique los resultados
*Cabecera
foreach i of num 1/2 {
    u Cabeceraocupados2020`i'
	keep P388 P6500 P6780 P6880 P6920 P7070 RAMA4D_R4 RAMA2D_R4 fex_c_2011 P7050 P6430 P7077 OFICIO INGLABO DIRECTORIO ORDEN
	save CabeceraO2020`i', replace
 }
clear

*COVID
foreach i of num 3/11 {
    u Cabeceraocupados2020`i'
	drop MES
	keep P6500 RAMA4D_R4 RAMA2D_R4 fex_c_2011 P6430 OFICIO DIRECTORIO ORDEN
	save CabeceraO2020`i', replace
 }
clear

*COVID

foreach i of num 1/2 {
    u Cabecerapersonas2020`i'
    keep  DIRECTORIO ORDEN P6040 P6220 P6020 fex_c_2011 DPTO P6050 ESC 
	save CabeceraP2020`i', replace
 }
clear


*COVID
foreach i of num 3/11 {
    u Cabecerapersonas2020`i'
	keep  DIRECTORIO ORDEN area P6040 P6020 fex_c_2011
	rename area DPTO
	drop if DPTO==""
	capture confirm variable dpto
if (_rc == 0) {
   rename dpto DPTO
}

	save CabeceraP2020`i', replace
 }
clear


*COVID

foreach i of num 1/11{
         u CabeceraP2020`i'
         merge m:m DIRECTORIO ORDEN using CabeceraO2020`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2020`i', replace
 }
clear

u Cabecera20201
foreach i of num 2/11 {
		 append using Cabecera2020`i'
		 save Cabecera2020, replace
 }
clear


* Resto
foreach i of num 1/11 {
    u Restoocupados2020`i'
	keep P388 P6500 P6780 P6880 P6920 P7070 RAMA4D_R4 RAMA2D_R4 fex_c_2011 P7050 P6430 P7077 OFICIO INGLABO DIRECTORIO ORDEN
	save RestoO2020`i', replace
 }
clear

foreach i of num 1/11 {
         u Restopersonas2020`i'
    keep  DIRECTORIO ORDEN P6040 P6220 P6020 fex_c_2011 DPTO P6050 ESC 
	save RestoP2020`i', replace
 }
clear

foreach i of num 1/11 {
         u RestoP2020`i'
         merge m:m DIRECTORIO ORDEN using RestoO2020`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2020`i', replace
 }
clear

u Resto20201
foreach i of num 2/11 {
		 append using Resto2020`i'
		 save Resto2020, replace
 }
clear

* Año 2021
*Cabecera
foreach i of num 1/3 {
    u Cabeceraocupados2021`i'
	keep P388 P6500 P6780 P6880 P6920 P7070 RAMA4D_R4 RAMA2D fex_c_2011 P7050 P6430 P7077 OFICIO INGLABO DIRECTORIO ORDEN
	save CabeceraO2021`i', replace
 }
clear

foreach i of num 1/3 {
    u Cabecerapersonas2021`i'
    keep  DIRECTORIO ORDEN P6040 P6220 P6020 fex_c_2011 DPTO P6050 ESC 
	save CabeceraP2021`i', replace
 }
clear

foreach i of num 1/3 {
         u CabeceraP2021`i'
         merge m:m DIRECTORIO ORDEN using CabeceraO2021`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Cabecera2021`i', replace
 }
clear

u Cabecera20211
foreach i of num 2/3 {
		 append using Cabecera2021`i'
		 save Cabecera2021, replace
 }
clear


* Resto
foreach i of num 1/3 {
         u Restoocupados2021`i'
	keep P388 P6500 P6780 P6880 P6920 P7070 RAMA4D_R4 RAMA2D fex_c_2011 P7050 P6430 P7077 OFICIO INGLABO DIRECTORIO ORDEN
	save RestoO2021`i', replace
 }
clear

foreach i of num 1/3 {
         u Restopersonas2021`i'
    keep  DIRECTORIO ORDEN P6040 P6220 P6020 fex_c_2011 DPTO P6050 ESC 
	save RestoP2021`i', replace
 }
clear

foreach i of num 1/3 {
         u RestoP2021`i'
         merge m:m DIRECTORIO ORDEN using RestoO2021`i'
		 drop if _merge==1
		 drop if _merge==2
		 drop _merge
		 gen mes=`i'
		 save Resto2021`i', replace
 }
clear

u Resto20211
foreach i of num 2/3 {
		 append using Resto2021`i'
		 save Resto2021, replace
 }
clear


*3. Indicador de Acceso clásico: obtener la serie de productores agropecuarios

*3.1. Primer Empleo     
	 *A) Edad: mayor de 18 años, P6040>18
	 *B) Lugar de trabajo: en el campo o área rural, P6880==8
	 *C) Tipo de Trabajador: patrón o empleador o trabajador por cuenta propia, P6430==4,5
	 *D) Rama de actividad de económica de 2 dígitos: agricultura, ganadaería, caza, silvicultura y pesca, RAMA2D=1,2,5. 

*En este punto se debe tener en cuenta que la clasificación industrial de actividades para el 
*periodo 2010-2019 toma la revisión 3 y para el año 2020 toma la revisión 4. En el documento metodológico se explica de 
*forma detallada las equivalencias. 	 
	 
* Año 2021
*Cabeceras
        u Cabecera2021 
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6430,4,5) & inlist(RAMA2D_R4,1,2,3), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2021
		destring dpto, replace
		replace dpto=0 if dpto==.
		save Cabecera_primer_empleo2021, replace

clear
*Resto
        u Resto2021
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,4,5) & inlist(RAMA2D_R4,1,2,3), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2021
		destring dpto, replace
		save Resto_primer_empleo2021, replace

clear

	 
	 * Año 2020
*Cabeceras
        u Cabecera2020 
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6430,4,5) & inlist(RAMA2D_R4,1,2,3), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2020
		destring dpto, replace
		replace dpto=0 if dpto==.
		save Cabecera_primer_empleo2020, replace

clear
*Resto
        u Resto2020
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,4,5) & inlist(RAMA2D_R4,1,2,3), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2020
		destring dpto, replace
		save Resto_primer_empleo2020, replace

clear

	 
	 
* Años: 2018-2019
*Cabeceras
foreach i of num 2018/2019 {
        u Cabecera`i' 
        destring RAMA2D, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,4,5) & inlist(RAMA2D,1,2,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=`i' 
		destring dpto, replace
		save Cabecera_primer_empleo`i', replace
}
clear
*Resto
foreach i of num 2018/2019 {
        u Resto`i' 
        destring RAMA2D, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,4,5) & inlist(RAMA2D,1,2,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=`i' 
		destring dpto, replace
		save Resto_primer_empleo`i', replace
}
clear

* Años: 2010-2017
*Cabeceras
foreach i of num 2010/2017 {
        u Cabecera`i' 
        destring rama2d, replace
        collapse (sum) fex_c_2011 if p6040>18 & p6880==8 & inlist(p6430,4,5) & inlist(rama2d,1,2,5), by (dpto mes) 
        sort dpto mes
        replace fex_c_2011=round(fex_c_2011)
		gen año=`i' 
		save Cabecera_primer_empleo`i', replace
}
clear
*Resto
foreach i of num 2010/2017 {
        u Resto`i' 
        destring rama2d, replace
        collapse (sum) fex_c_2011 if p6040>18 & p6880==8 & inlist(p6430,4,5) & inlist(rama2d,1,2,5), by (dpto mes) 
        sort dpto mes
        replace fex_c_2011=round(fex_c_2011)
		gen año=`i' 
		save Resto_primer_empleo`i', replace
}
clear

*Unir la serie de primer empleo
u Cabecera_primer_empleo2010
foreach i of num 2011/2021 {
		 append using Cabecera_primer_empleo`i', force
		 drop if dpto==.
		 save Cabecera_primer_empleo_2010_a_2021, replace
 }
clear

u Resto_primer_empleo2010
foreach i of num 2011/2021 {
		 append using Resto_primer_empleo`i', force
		 save Resto_primer_empleo_2010_a_2021, replace
 }
clear


*3.2. Segundo Empleo
	 *A) Edad: mayor de 18 años, P6040>18
	 *B) Lugar de trabajo: en el campo o área rural, P880==8
	 *C) Tipo de Trabajador: todos excepto patrón o empleador o trabajador por cuenta propia. P6430==1,2,3,6,7,8,9
	 *D) Rama de actividad de económica de 2 dígitos: agricultura, ganadaería, caza, silvicultura y pesca, RAMA2D=1,2,5. 
	 *E) Segundo Empleo: patrón o empleador o trabajador por cuenta propia en su segundo empleo, P7050==4,5

* Año 2021
*Cabeceras
        u Cabecera2021
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D_R4,1,2,5) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2021
		destring dpto, replace
		save Cabecera_segundo_empleo2021, replace
clear
*Resto
        u Resto2021
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D_R4,1,2,5) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2021
		destring dpto, replace
		save Resto_segundo_empleo2021, replace

clear

	 
	 
	 * Año 2020
*Cabeceras
        u Cabecera2020 
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D_R4,1,2,5) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2020
		destring dpto, replace
		save Cabecera_segundo_empleo2020, replace
clear
*Resto
        u Resto2020
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D_R4,1,2,5) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2020
		destring dpto, replace
		save Resto_segundo_empleo2020, replace

clear

	 
	 
* Años: 2018-2019
*Cabeceras
foreach i of num 2018/2019 {
        u Cabecera`i' 
        destring RAMA2D, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D,1,2,5) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=`i' 
		destring dpto, replace
		save Cabecera_segundo_empleo`i', replace
}
clear
*Resto
foreach i of num 2018/2019 {
        u Resto`i' 
        destring RAMA2D, replace
        collapse (sum) fex_c_2011 if P6040>18 & P6880==8 & inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D,1,2,5) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=`i' 
		destring dpto, replace
		save Resto_segundo_empleo`i', replace
}
clear

* Años: 2010-2017
*Cabeceras
foreach i of num 2010/2017 {
        u Cabecera`i' 
        destring rama2d, replace
        collapse (sum) fex_c_2011 if p6040>18 & p6880==8 & inlist(p6430,1,2,3,6,7,8,9) & inlist(rama2d,1,2,5) & inlist(p7050,4,5), by (dpto mes) 
        sort dpto mes
        replace fex_c_2011=round(fex_c_2011)
		gen año=`i' 
		save Cabecera_segundo_empleo`i', replace
}
clear
*Resto
foreach i of num 2010/2017 {
        u Resto`i' 
        destring rama2d, replace
        collapse (sum) fex_c_2011 if p6040>18 & p6880==8 & inlist(p6430,1,2,3,6,7,8,9) & inlist(rama2d,1,2,5) & inlist(p7050,4,5), by (dpto mes) 
        sort dpto mes
        replace fex_c_2011=round(fex_c_2011)
		gen año=`i' 
		save Resto_segundo_empleo`i', replace
}
clear

*Unir la serie de segundo empleo
u Cabecera_segundo_empleo2010
foreach i of num 2011/2021 {
		 append using Cabecera_segundo_empleo`i', force
		 save Cabecera_segundo_empleo_2010_a_2021, replace
 }
clear

u Resto_segundo_empleo2010
foreach i of num 2011/2021 {
		 append using Resto_segundo_empleo`i', force
		 save Resto_segundo_empleo_2010_a_2021, replace
 }
clear


*3.2 Serie del total de empleo agropecuario mes a mes por departamentos
u Cabecera_primer_empleo_2010_a_2021
capture confirm variable fex_c_2011
if (_rc == 0) {
   rename fex_c_2011 Primer_Empleo
}
save Cabecera_primer_empleo_2010_a_2021, replace
clear

u Resto_primer_empleo_2010_a_2021
rename fex_c_2011 Primer_Empleo
save Resto_primer_empleo_2010_a_2021, replace
clear

u Cabecera_segundo_empleo_2010_a_2021
rename fex_c_2011 Segundo_Empleo
save Cabecera_segundo_empleo_2010_a_2021, replace
clear

u Resto_segundo_empleo_2010_a_2021
rename fex_c_2011 Segundo_Empleo
save Resto_segundo_empleo_2010_a_2021, replace
clear

* Unir datos: Serie productores agropecuarios a nivel nacional
u Cabecera_primer_empleo_2010_a_2021
merge m:m dpto año mes using Cabecera_segundo_empleo_2010_a_2021
drop _merge 
replace Segundo_Empleo=0 if Segundo_Empleo==.
gen Empleo_Total= Primer_Empleo + Segundo_Empleo
sort año mes dpto
save Cabecera_total_empleo_2010_a_2021, replace
export excel using "Cabecera_total_empleo_2010_a_2021", firstrow(variables) replace
clear

u Resto_primer_empleo_2010_a_2021
merge m:m dpto año mes using Resto_segundo_empleo_2010_a_2021
replace Segundo_Empleo=0 if Segundo_Empleo==.
drop _merge 
gen Empleo_Total= Primer_Empleo + Segundo_Empleo
sort año mes dpto
save Resto_total_empleo_2010_a_2021, replace
export excel using "Resto_total_empleo_2010_a_2021", firstrow(variables) replace
clear

u Cabecera_total_empleo_2010_a_2021
drop Primer_Empleo Segundo_Empleo
rename Empleo_Total Empleo_Total_Cabecera 
merge m:m dpto año mes using Resto_total_empleo_2010_a_2021
drop _merge 
drop Primer_Empleo Segundo_Empleo
rename Empleo_Total Empleo_Total_Resto 
replace Empleo_Total_Cabecera=0 if Empleo_Total_Cabecera==.
replace Empleo_Total_Resto=0 if Empleo_Total_Resto==.
gen Empleo_Total_Agropecuario= Empleo_Total_Cabecera + Empleo_Total_Resto
sort año mes dpto
save Total_empleo_agropecuario_2010_a_2021, replace
export excel using "Total_empleo_agropecuario_2010_a_2021", firstrow(variables) replace
clear



* Los tres archvios de excel anteriores son el insumo principal para el cálculo del indicador de acceso clásico, para ello se usa la serie de beeficiarios
*de cartera mes a mes por departamento de Finagro, la razón resultante entre ambas es justamente el indicador. A pesar de que los datos anteriores son de
* gran utilidad, hay variables que no se aprovecharon en el análisis, debido a ello, las proximas secciones tienen el objetivo de:
                                         *1. Serie productores agroindustriales a nivel nacional
										 *2. Serie de productores agropecuarios + agroindustriales a nivel nacional
										 *3. Niveles de ingreso de ambos tipos de productor

*4. Indicador de Acceso aumentado: obtener la serie de productores agroindustriales
* La metodología es  la misma que la del indicador clásico expcetuando dos cambios. Ahora se tienen en cuenta las siguientes actividades económicas: 
                                          
										  *Elaboración de productos alimenticios.
										  *Elaboración de bebidas.
										  *Elaboración de productos de tabaco.
										  *Fabricación de productos textiles.
										  *Confección de prendas de vestir.
										  *Curtido y recurtido de cueros; fabricación de calzado; fabricación de artículos de viaje, maletas, bolsos de mano y artículos similares, y fabricación de artículos de talabartería y guarnicionería; adobo y teñido de pieles.
										  *Transformación de la madera y fabricación de productos de madera y de corcho, excepto muebles; fabricación de artículos de cestería y espartería.
										  *Fabricación de papel, cartón y productos de papel y cartón.
									
*Por la naturaleza de las actividades anteriiores, el lugar de trabajo también se debe expandir, con ello en mente se tiene en cuenta:
                                          * En esta vivienda
                                          * En otras viviendas
                                          * En kiosco-caseta
                                          * Local fijo, oficina, fábrica, etc
                                          * En campo o área rura
										  
* Teniendo en cuenta lo anterior, el filtro de la variable P6880 incluye las respuestas 1,2,3,7,8
									
									
*4.1. Primer Empleo     
* Año 2020
*Cabeceras
        u Cabecera2020 
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6880,1,2,3,7,8) & inlist(P6430,4,5) & inlist(RAMA2D_R4,10,11,12,13,14,15,16,17), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2020
		destring dpto, replace
		save Cabecera_primer_empleo_agroindustrial2020, replace

clear
*Resto
        u Resto2020
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6880,1,2,3,7,8) & inlist(P6430,4,5) & inlist(RAMA2D_R4,10,11,12,13,14,15,16,17), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2020
		destring dpto, replace
		save Resto_primer_empleo_agroindustrial2020, replace

clear

	
* Años: 2018-2019
*Cabeceras
foreach i of num 2018/2019 {
        u Cabecera`i' 
        destring RAMA2D, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6880,1,2,3,7,8) & inlist(P6430,4,5) & inlist(RAMA2D,15,16,17,18,19,20,21), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=`i' 
		destring dpto, replace
		save Cabecera_primer_empleo_agroindustrial`i', replace
}
clear
*Resto
foreach i of num 2018/2019 {
        u Resto`i' 
        destring RAMA2D, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6880,1,2,3,7,8) & inlist(P6430,4,5) & inlist(RAMA2D,15,16,17,18,19,20,21), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=`i' 
		destring dpto, replace
		save Resto_primer_empleo_agroindustrial`i', replace
}
clear

* Años: 2010-2017
*Cabeceras
foreach i of num 2010/2017 {
        u Cabecera`i' 
        destring rama2d, replace
        collapse (sum) fex_c_2011 if p6040>18 & inlist(p6880,1,2,3,7,8) & inlist(p6430,4,5) & inlist(rama2d,15,16,17,18,19,20,21), by (dpto mes) 
        sort dpto mes
        replace fex_c_2011=round(fex_c_2011)
		gen año=`i' 
		save Cabecera_primer_empleo_agroindustrial`i', replace
}
clear
*Resto
foreach i of num 2010/2017 {
        u Resto`i' 
        destring rama2d, replace
        collapse (sum) fex_c_2011 if p6040>18 & inlist(p6880,1,2,3,7,8) & inlist(p6430,4,5) & inlist(rama2d,15,16,17,18,19,20,21), by (dpto mes) 
        sort dpto mes
        replace fex_c_2011=round(fex_c_2011)
		gen año=`i' 
		save Resto_primer_empleo_agroindustrial`i', replace
}
clear

*Unir la serie de primer empleo
u Cabecera_primer_empleo_agroindustrial2010
foreach i of num 2011/2020 {
		 append using Cabecera_primer_empleo_agroindustrial`i', force
		 save Cabecera_primer_empleo_agroindustrial_2010_a_2020, replace
 }
clear

u Resto_primer_empleo2010
foreach i of num 2011/2020 {
		 append using Resto_primer_empleo_agroindustrial`i', force
		 save Resto_primer_empleo_agroindustrial_2010_a_2020, replace
 }
clear


*4.2. Segundo Empleo
* Año 2020
*Cabeceras
        u Cabecera2020 
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6880,1,2,3,7,8) & inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D_R4,10,11,12,13,14,15,16,17) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2020
		destring dpto, replace
		save Cabecera_segundo_empleo_agroindustrial2020, replace

clear
*Resto
        u Resto2020
        destring RAMA2D_R4, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6880,1,2,3,7,8) & inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D_R4,10,11,12,13,14,15,16,17) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=2020
		destring dpto, replace
		save Resto_segundo_empleo_agroindustrial2020, replace

clear

*No hay observaciones de segundo empleo agroindustrial, por esto el año 2020 no se tiene en cuenta en la unión de la serie de segundo empleo	 
	 
* Años: 2018-2019
*Cabeceras
foreach i of num 2018/2019 {
        u Cabecera`i' 
        destring RAMA2D, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6880,1,2,3,7,8)& inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D,15,16,17,18,19,20,21) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=`i' 
		destring dpto, replace
		save Cabecera_segundo_empleo_agroindustrial`i', replace
}
clear
*Resto
foreach i of num 2018/2019 {
        u Resto`i' 
        destring RAMA2D, replace
        collapse (sum) fex_c_2011 if P6040>18 & inlist(P6880,1,2,3,7,8) & inlist(P6430,1,2,3,6,7,8,9) & inlist(RAMA2D,15,16,17,18,19,20,21) & inlist(P7050,4,5), by (DPTO mes) 
        sort DPTO mes
        replace fex_c_2011=round(fex_c_2011)
		rename DPTO dpto
		gen año=`i' 
		destring dpto, replace
		save Resto_segundo_empleo_agroindustrial`i', replace
}
clear

* Años: 2010-2017
*Cabeceras
foreach i of num 2010/2017 {
        u Cabecera`i' 
        destring rama2d, replace
        collapse (sum) fex_c_2011 if p6040>18 & inlist(p6880,1,2,3,7,8) & inlist(p6430,1,2,3,6,7,8,9) & inlist(rama2d,15,16,17,18,19,20,21) & inlist(p7050,4,5), by (dpto mes) 
        sort dpto mes
        replace fex_c_2011=round(fex_c_2011)
		gen año=`i' 
		save Cabecera_segundo_empleo_agroindustrial`i', replace
}
clear
*Resto
foreach i of num 2010/2017 {
        u Resto`i' 
        destring rama2d, replace
        collapse (sum) fex_c_2011 if p6040>18 & inlist(p6880,1,2,3,7,8) & inlist(p6430,1,2,3,6,7,8,9) & inlist(rama2d,15,16,17,18,19,20,21) & inlist(p7050,4,5), by (dpto mes) 
        sort dpto mes
        replace fex_c_2011=round(fex_c_2011)
		gen año=`i' 
		save Resto_segundo_empleo_agroindustrial`i', replace
}
clear


*Unir la serie de segundo empleo
u Cabecera_segundo_empleo_agroindustrial2010
foreach i of num 2011/2020 {
		 append using Cabecera_segundo_empleo_agroindustrial`i', force
		 save Cabecera_segundo_empleo_agroindustrial_2010_a_2020, replace
 }
clear

u Resto_segundo_empleo_agroindustrial2010
foreach i of num 2011/2019 {
		 append using Resto_segundo_empleo_agroindustrial`i', force
		 save Resto_segundo_empleo_agroindustrial_2010_a_2020, replace
 }
clear

*4.3 Cambio de nombres
u Cabecera_primer_empleo_agroindustrial_2010_a_2020
rename fex_c_2011 Primer_Empleo
save Cabecera_primer_empleo_agroindustrial_2010_a_2020, replace
clear

u Resto_primer_empleo_agroindustrial_2010_a_2020
rename fex_c_2011 Primer_Empleo
save Resto_primer_empleo_agroindustrial_2010_a_2020, replace
clear

u Cabecera_segundo_empleo_agroindustrial_2010_a_2020
rename fex_c_2011 Segundo_Empleo
save Cabecera_segundo_empleo_agroindustrial_2010_a_2020, replace
clear

u Resto_segundo_empleo_agroindustrial_2010_a_2020
rename fex_c_2011 Segundo_Empleo
save Resto_segundo_empleo_agroindustrial_2010_a_2020, replace
clear


*4.4 Unir datos: Serie productores agroindustriales a nivel nacional
u Cabecera_primer_empleo_agroindustrial_2010_a_2020
merge m:m dpto año mes using Cabecera_segundo_empleo_agroindustrial_2010_a_2020
drop _merge 
replace Segundo_Empleo=0 if Segundo_Empleo==.
gen Empleo_Total= Primer_Empleo + Segundo_Empleo
sort año mes dpto
save Cabecera_total_empleo_agroindustrial_2010_a_2020, replace
export excel using "Cabecera_total_empleo_agroindustrial_2010_a_2020", firstrow(variables) replace
clear

u Resto_primer_empleo_agroindustrial_2010_a_2020
merge m:m dpto año mes using Resto_segundo_empleo_agroindustrial_2010_a_2020
replace Segundo_Empleo=0 if Segundo_Empleo==.
drop _merge 
gen Empleo_Total= Primer_Empleo + Segundo_Empleo
sort año mes dpto
save Resto_total_empleo_agroindustrial_2010_a_2020, replace
export excel using "Resto_total_empleo_agroindustrial_2010_a_2020", firstrow(variables) replace
clear

u Cabecera_total_empleo_agroindustrial_2010_a_2020
drop Primer_Empleo Segundo_Empleo
rename Empleo_Total Empleo_Total_Cabecera 
merge m:m dpto año mes using Resto_total_empleo_agroindustrial_2010_a_2020
drop _merge 
drop Primer_Empleo Segundo_Empleo
rename Empleo_Total Empleo_Total_Resto 
replace Empleo_Total_Cabecera=0 if Empleo_Total_Cabecera==.
replace Empleo_Total_Resto=0 if Empleo_Total_Resto==.
gen Empleo_Total_agroindustrial= Empleo_Total_Cabecera + Empleo_Total_Resto
sort año mes dpto
save Total_empleo_agroindustrial_2010_a_2020, replace
export excel using "Total_empleo_agroindustrial_2010_a_2020", firstrow(variables) replace
clear



*5. Serie de productores agropecuarios + agroindustriales a nivel nacional
u Total_empleo_agropecuario_2010_a_2020
rename Empleo_Total_Cabecera Agropecuario_Cabecera
rename Empleo_Total_Resto Agropecuario_Resto
merge m:m dpto año mes using Total_empleo_agroindustrial_2010_a_2020
drop _merge 
rename Empleo_Total_Cabecera Agroindustrial_Cabecera
rename Empleo_Total_Rest Agroindustrial_Resto
gen Agropecuario_y_Agroindustrial= Empleo_Total_Agropecuario + Empleo_Total_agroindustrial
save Total_empleo_agropecuario_agroindustrial_2010_a_2020
export excel using "Total_empleo_agropecuario_agroindustrial_2010_a_2020", firstrow(variables) replace
clear
							  
*6. Niveles de ingreso de ambos tipos de productor para el año 2019
*Agropecuario
u Cabecera2019
destring RAMA2D, replace
keep if P6040>18 & P6880==8 & inlist(P6430,4,5) & inlist(RAMA2D,1,2,5)
drop if INGLABO==.
drop if INGLABO==0
* Salario Mínimo 2019: $ 828.116
gen SMMLV = INGLABO/828116
histogram SMMLV if SMMLV<5, frequency kdensity
histogram SMMLV if SMMLV<20, frequency kdensity
clear

*Agroindustrial
u Cabecera2019
destring RAMA2D, replace
keep if P6040>18 & inlist(P6880,1,2,3,7,8) & inlist(P6430,4,5) & inlist(RAMA2D,15,16,17,18,19,20,21)
drop if INGLABO==.
drop if INGLABO==0
* Salario Mínimo 2019: $ 828.116
gen SMMLV = INGLABO/828116
histogram SMMLV if SMMLV<5, frequency kdensity
histogram SMMLV if SMMLV<20, frequency kdensity

clear


*7. Todos los procedimientos anteriores crean una gran cantidad de archivos en el directorio de trabajo:
*Elimine todos los archivos del directorio a excepción de las bases en Excel. 


