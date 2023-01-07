/*
********************************************************************************
Cleaning APBD Data Municipal Level
	Name			: Fajar Putra
	Data Source		: https://djpk.kemenkeu.go.id/portal/data/apbd
	Date of Modif.	: 26 MARCH 2021
********************************************************************************

*/

clear
capture log close 
set more off 
** ADJUST WITH YOUR OWN DIRECTORY LOCATION
cd "C:\Users\hp\Downloads\Data_APBD_1718"
global main "C:\Users\hp\Downloads\Data_APBD_1718"
global path "C:\Users\hp\Downloads\Data_APBD_1718\IN\KABKOT"
log using OUT\cleaning-data-apbd-municipal, replace text

import excel "IN\province_folder_name.xlsx", sheet("Sheet1") firstrow clear
** DKI di skip ya karena tidak ada data kab/kota
global nama "01_ACEH 02_SUMUT 03_SUMBAR 04_RIAU 05_JAMBI 06_SUMSEL 07_BENGKULU 08_LAMPUNG 10_JABAR 11_JATENG 12_DIY 13_JATIM 14_KALBAR 15_KALTENG 16_KALSEL 17_KALTIM 18_SULUT 19_SULTENG 20_SULSEL 21_SULTRA 22_BALI 23_NTB 24_NTT 25_MALUKU 26_PAPUA 27_MALUT 28_BANTEN 29_BABEL 30_GORONTALO 31_KEPRI 32_PAPUABARAT 33_SULBAR 34_KALUT "
import excel "IN\total_municipal_by_province.xlsx", sheet("Sheet1") firstrow clear

* We get the number of the data from dataset
forval nprov = 1(1)33 {
	local jumkab`nprov' = jumkab[`nprov']
}

local urut = 1

foreach i of global nama{
	cd "$path\\`i'"
	import excel "data.xlsx", sheet("Worksheet") clear
		** same  with the province level but this time we add province variable
		local tahun = substr(A[1], 6, 4)
		local varname1 = strtoname(B[4])
		local varname2 = strtoname(C[4])
		local varname3 = strtoname(D[4])
			gen Tahun = int(`tahun')
			** add gen province
			gen Provinsi = "`i'"
			order Tahun Provinsi
			replace A = A[2]
		rename A namaprov
		rename B `varname1'
		rename C `varname2'
		rename D `varname3'
		rename E Persen
			drop in 1/4
			drop if Akun == ""
	tempfile data0
	save `data0'
	
	* since this is 2 periods we multiply by 2 but we minus with 1 because one of the file dont have number in their names which is data.xlsx
	local datatot = `jumkab`urut'' * 2 - 1
	forval kab = 1(1)`datatot' {
		import excel "data (`kab').xlsx", sheet("Worksheet") clear
			local tahun = substr(A[1], 6, 4)
			local varname1 = strtoname(B[4])
			local varname2 = strtoname(C[4])
			local varname3 = strtoname(D[4])
				gen Tahun = int(`tahun')
				** add gen province
				gen Provinsi = "`i'"
				order Tahun Provinsi
				replace A = A[2]
			rename A namaprov
			rename B `varname1'
			rename C `varname2'
			rename D `varname3'
			rename E Persen
				drop in 1/4
				drop if Akun == ""
		tempfile data`kab'
		save `data`kab''
	}
	** merge all data for each year
	use `data0', clear
	
	forval num = 1(1)`datatot' {
		append using `data`num''
	}
	cd "..\.."
	tempfile data_`i'
	save `data_`i''
	local urut = `urut' + 1
}

** merge all kabkot provinsi
** DKI di skip ya karena tidak ada data kab/kota
local nama2 "02_SUMUT 03_SUMBAR 04_RIAU 05_JAMBI 06_SUMSEL 07_BENGKULU 08_LAMPUNG 10_JABAR 11_JATENG 12_DIY 13_JATIM 14_KALBAR 15_KALTENG 16_KALSEL 17_KALTIM 18_SULUT 19_SULTENG 20_SULSEL 21_SULTRA 22_BALI 23_NTB 24_NTT 25_MALUKU 26_PAPUA 27_MALUT 28_BANTEN 29_BABEL 30_GORONTALO 31_KEPRI 32_PAPUABARAT 33_SULBAR 34_KALUT "
	use `data_01_ACEH', clear
	foreach prov of local nama2 {
		append using `data_`prov''
	}

gen Tipe = "Kabkot Only"
keep if Akun == "Pendapatan" | Akun == "Belanja"

** ADJUST WITH YOUR OWN DIRECTORY LOCATION
save $main\OUT\OUT\kabkot_1718.dta, replace
export excel using OUT\OUT\kabkot_1718, firstrow(variables) replace

log close