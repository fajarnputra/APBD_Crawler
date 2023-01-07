/*
********************************************************************************
Cleaning APBD Data Province Level
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
log using OUT\cleaning-data-apbd-province, replace text


// CLEANING DATA PROVINCE ONLY
forval tahun = 2017(1)2018 {
	cd "IN\PROVINSI ONLY `tahun'"
	import excel "data.xlsx", sheet("Worksheet") clear
		local tahun = substr(A[1], 6, 4)
		local varname1 = strtoname(B[4])
		local varname2 = strtoname(C[4])
		local varname3 = strtoname(D[4])
			gen Tahun = int(`tahun')
			order Tahun
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
	
	forval i = 1(1)33 {
		import excel "data (`i').xlsx", sheet("Worksheet") clear
			local tahun = substr(A[1], 6, 4)
			local varname1 = strtoname(B[4])
			local varname2 = strtoname(C[4])
			local varname3 = strtoname(D[4])
				gen Tahun = int(`tahun')
				order Tahun
				replace A = A[2]
			rename A namaprov
			rename B `varname1'
			rename C `varname2'
			rename D `varname3'
			rename E Persen
				drop in 1/4
				drop if Akun == ""
		tempfile data`i'
		save `data`i''
	}
	** merge all data for each year
	use `data0', clear
	forval num = 1(1)33 {
		append using `data`num''
	}
	gen Tipe = "Province Only"
	keep if Akun == "Pendapatan" | Akun == "Belanja"
	cd ..
	** ADJUST WITH YOUR OWN DIRECTORY LOCATION
	save OUT\province_only_`tahun'.dta, replace
	export excel using OUT\province_only_`tahun', firstrow(variables) replace
	
}

log close