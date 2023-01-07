/*
********************************************************************************
Script to generate folder of each province
	Name			: Fajar Putra
	Data Source		: https://djpk.kemenkeu.go.id/portal/data/apbd
	Date of Modif.	: 26 MARCH 2021
********************************************************************************

*/

** ADJUST WITH YOUR OWN DIRECTORY LOCATION
global path "C:\Users\hp\Downloads\Data_APBD_1718\IN\KABKOT"
cd $path

global nama "01_ACEH 02_SUMUT 03_SUMBAR 04_RIAU 05_JAMBI 06_SUMSEL 07_BENGKULU 08_LAMPUNG 09_DKI 10_JABAR 11_JATENG 12_DIY 13_JATIM 14_KALBAR 15_KALTENG 16_KALSEL 17_KALTIM 18_SULUT 19_SULTENG 20_SULSEL 21_SULTRA 22_BALI 23_NTB 24_NTT 25_MALUKU 26_PAPUA 27_MALUT 28_BANTEN 29_BABEL 30_GORONTALO 31_KEPRI 32_PAPUABARAT 33_SULBAR 34_KALUT"

foreach i of global nama {
	mkdir "`i'"
}


