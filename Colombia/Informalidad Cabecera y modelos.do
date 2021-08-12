******************** Ponencia Economía Laboral **************************
*1. Directorio
cd "K:\Presidencia\Asesor Economico\Pasantes Universitarios\Andrés Sánchez - UNacional\Ponencia de informalidad\Datos"

*2. Bases de datos: Personas 
import delimited "PersonasC"
egen ID = concat(año mes directorio secuencia_p hogar orden) 
destring ID, replace
duplicates report ID
duplicates drop ID, force
describe
save PersonasC.dta, replace
clear 

*2. Bases de datos: OcupadosC 

* Mirar dofile de OcupadosC

*3 Merge
u PersonasC
merge 1:1 ID using OcupadosC 
drop if _merge==1
drop if _merge==2
keep año p6040 p6210 p6210s1 p6220 p6020 p6050 p6430s1 p6430 p6870 p6880 p6880s1 clase rama2d rama4d inglabo ID p6920 p6915 p6765 p6772 p6775
global FIX año p6040 p6210 p6210s1 p6220 p6020 p6050 p6430s1 p6430 p6870 p6880 p6880s1 clase rama2d rama4d inglabo p6920 p6915 p6765 p6772 p6775

foreach var of global FIX {
tostring `var', replace 
}

foreach var of global FIX{
replace `var'="0" if `var'=="NA" | `var'=="Inf"
}

foreach var of varlist _all{
destring `var', replace 
}

save ModelosC, replace
clear

u ModelosC
* Verificar: 
*Total
tabulate año, subpop(ID) // buena distribución de los cortes transversales 

*Edades
tabulate p6040
drop if p6040<15

*Grupos etarios: 
*A: 15-18
gen A=0
replace A=1 if p6040 >= 15 &  p6040 <= 18
*B: 19:24
gen B=0
replace B=1 if p6040 >= 19 &  p6040 <= 24
*C: 25-44
gen C=0
replace C=1 if p6040 >= 25 &  p6040 <= 44
*D: 45+
gen D=0
replace D=1 if p6040 >= 45

*Educación
tabulate p6210 // (a.Ninguno), 2(b. Preescolar), 3(c. Básica primaria (1o - 5o)), 4(d. Básica secundaria (6o - 9o))
* 5(e.Media (10o - 13o))ó 6(f. Superior o universitaria), 9(g. No sabe, no informa)
drop p6210s1 p6220

*Grupos educativos 
* Primaria 
gen Primaria=0
replace Primaria=1 if p6210==3
*Secundaria (media vocacional)
gen Secundaria=0
replace Secundaria=1 if p6210==5
*Terciaria
gen Terciaria=0
replace Secundaria=1 if p6210==6


* Género
tabulate p6020 // 1 Hombre 2 Mujer
gen mujer=0
replace mujer=1 if p6020==2


* Parentésco
tabulate p6050 //  a. Jefe (a) del hogar , b. Pareja, esposo(a), cónyuge, compañero(a), c. Hijo(a), hijastro(a)
* d. Nieto(a), e. Otro pariente, f. Empleado(a) del servicio doméstico y sus parientes, g. Pensionista
* h. Trabajador, i. Otro no pariente
*Grupos de parentesco
* Cabeza
gen Cabeza=0
replace Cabeza=1 if p6050==1
* Pareja
gen Pareja=0
replace Cabeza=1 if p6050==2
*Hijos
gen Hijo=0
replace Hijo=1 if p6050==3



* Posició ocupacional 
tabulate p6430 // a. Obrero o empleado de empresa particular, b. Obrero o empleado del gobierno, c. Empleado doméstico,
* d. Trabajador por cuenta propia, e. Patrón o empleador, f. Trabajador familiar sin remuneración, g. Trabajador sin remuneración en empresas o negocios de otros hogares, 
* h. Jornalero o peón, i. Otro

* Número de trabajadores
tabulate p6870 // a. Trabaja solo, b. 2 a 3 personas, c. 4 a 5 personas, d. 6 a 10 personas
* e. 11 a 19 personas, f. 20 a 30 personas, g. 31 a 50 personas, h. 51 a 100 personas, i. 101 o más personas
*Grupos de trabajadores 
*Unico
gen unico=0
replace unico=1 if p6870==1
*G2A3
gen G2A3=0
replace G2A3=1 if p6870==2
*G4A5
gen G4A5=0
replace G4A5=1 if p6870==3
*G6A10
gen G6A10=0
replace G6A10=1 if p6870==4
*G11A19
gen G11A19=0
replace G11A19=1 if p6870==5
*G20MAS
gen G20MAS=0
replace G20MAS=1 if p6870>=6

* Lugar del negocio
tabulate p6880 // a. En esta vivienda, b. En otras viviendas, c En kiosco - caseta, d En un vehículo
* e. De puerta en puerta, f. Sitio al descubierto en la calle (ambulante y estacionario), g. Local fijo, oficina, fábrica, etc.
* h. En el campo o área rural, mar o río, i. En una obra en construcción, j. En una mina o cantera, k. Otro,
*Grupos de lugares
*Vivienda propia 
gen vivienda=0
replace vivienda=1 if p6880==1
*Vivienda de alguien más
gen otravivienda=0
replace otravivienda=1 if p6880==2
* Kiosco o Caseta
gen caseta=0
replace caseta=1 if p6880==3
*Vehiculo o puerta a puerta
gen vehiculoPP=0
replace vehiculoPP=1 if p6880==4 | p6880==5
*Ambulante
gen ambulante=0
replace ambulante=1 if p6880==6
*Local fijo, oficina, fábrica, etc
gen fijo=0
replace fijo=1 if p6880==7
*En el campo o área rural, mar o río
gen campo=0
replace campo=1 if p6880==8
*Obra
gen obra=0 
replace obra=1 if p6880==9
*Mina
gen mina=0 
replace mina=1 if p6880==10


*Clase
tabulate clase
drop clase

* Rama 2d
tabulate rama2d 
*Grupos de division
* División 1: AGRICULTURA, GANADERÍA, CAZA Y SILVICULTURA
gen div1=0
replace div1=1 if rama2d==1
* División 2: Silvicultura, extracción de madera y actividades de servicios conexas
gen div2=0
replace div2=1 if rama2d==2
* División 5: Pesca, producción de peces en criaderos y granjas piscícolas; actividades de servicios relacionadas con la pesca
gen div5=0
replace div5=1 if rama2d==5
* Act: EXPLOTACIÓN DE MINAS Y CANTERAS
gen extraccion=0 
replace extraccion=1 if rama2d >= 10 & rama2d<= 14
*Act: Industrias manufactureras
gen manufactura=0
replace manufactura=1 if rama2d >= 15 & rama2d<= 39
* Act: construcción
gen construccion=0
replace construccion=1 if  rama2d >= 45 & rama2d<=49
* Act: comercio
gen comercio=0
replace comercio=1 if  rama2d >= 50 & rama2d<=54
* Act: Hoteles, restaurantes, bares y similares
gen restaurantes=0
replace restaurantes=1 if rama2d >= 55 & rama2d<=59
* Act: transporte
gen transporte=0
replace transporte=1 if rama2d >= 60 & rama2d<=64

* Rama 4d
tabulate rama4d

* Base intermedia
save BaseC_int
clear

* 5. Crear variables de informalidad por tipos y bases 
* 5.1 Informalidad laboral DANE
u BaseC_int
gen DANE5=0
*According to DANE (2020), the firm definition of informal workers includes workers in one of the following situations:
* 1.	Private employees and workers who work in establishments, businesses, or companies of up to five people, including the employer.
* 2.	Unpaid family workers in establishments, businesses, or companies with five workers or less.
* 3.	Unpaid workers in companies or businesses from other households.
* 4.	Domestic employees and day laborers in companies up to five workers or less.
* 5.	Own-account workers who work in establishments of up to five people, except professional freelancers.
* 6.	Employers in companies with five workers or less.
* 7.	Government employees are excluded.

replace DANE5=1 if p6870 == 1 | p6870 == 2 | p6870 == 3
replace DANE5=0 if p6430 == 2

* 5.2 Informalidad laboral legal
* Pensión 
tabulate p6920 // 1 Sí 2 No 3 Ya es pensionado
* Régimen de Salud
tabulate p6915 // 38. ¿En caso de enfermedad como cubriría los costos médicos y los medicamentos?, a. Es afiliado como cotizante a un régimen contributivo de salud (EPS)
* b. Es afiliado a un régimen subsidiado de salud, . Es beneficiario de un afiliado, d. Con ahorros personales, e. Con ayudas de los hijos o familiares, f. Con otro tipo de seguro o cubrimiento
* g. Pidiendo dinero prestado, h. Vendería su vivienda o bienes del hogar, i. Empeñaría bienes del hogar, j. No lo ha considerado, k. No tiene recursos, l. Otro,
gen Legal=0
replace Legal=1 if p6920==2 
replace Legal=0 if p6915 == 1 | p6915 == 2

save Informalidad_PersonasC
clear

* 5.3 Informalidad empresarial
u BaseC_int
gen Micro=0
* Negocio propio 
tabulate p6765 // a. Trabajó por honorarios o prestación de servicios?, b. Trabajó por obra?, c. Trabajó por piezas o a destajo? (satélite, maquila, etc)
* d. Trabajó por comisión únicamente?, e. Trabajó vendiendo por catálogo?, f. Trabajó en su oficio? (plomero, taxista, doméstica por días etc), 
* g. Tiene un negocio de industria, comercio, servicios o una finca?, h. Otro
keep if p6765 == 7
* Contabilidad
tabulate p6775 // 1 Sí 2 No 3 No aplica 9 No sabe
* Registro Mercantil 
tabulate p6772 // 1 Sí 2 No

replace Micro=1 if p6772 == 2 | p6775 == 2

save Informalidad_MicroC
clear


* 6. Modelos 
u Informalidad_PersonasC
*6.1. Dane 5
logit DANE5 A B C Primaria Secundaria mujer Cabeza div1 div2 div5 extraccion manufactura construccion comercio restaurantes transporte vivienda otravivienda caseta vehiculoPP ambulante fijo campo obra mina
estimates store Dane5

outreg2 Dane5 using "Modelos_personasC.xls", ctitle(Modelos personas DANE5)

*6.2. Legal
logit Legal A B C Primaria Secundaria mujer Cabeza div1 div2 div5 extraccion manufactura construccion comercio restaurantes transporte vivienda otravivienda caseta vehiculoPP ambulante fijo campo obra mina
estimates store LEGAL

outreg2 LEGAL using "Modelos_personasC.xls", append ctitle (Modelos personas Legales)

*6.3. Micro 
u Informalidad_MicroC
logit Micro unico G2A3 G4A5 G6A10 G11A19 vivienda otravivienda caseta vehiculoPP ambulante fijo campo obra mina div1 div2 div5 extraccion manufactura construccion comercio restaurantes transporte
estimates store MicroM1


outreg2 MicroM1 using "Modelos_empresas1C.xls", ctitle(Modelos microempresarios rurales) 


