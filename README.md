# APBD_Crawler
### Helps to bulk download APBD data from DJPK Kemenkeu website and reduce redundant process

**Step by step to use the system. **

The data cleaning process utilizes multiple software/ programming languages: Python for crawling the data, Stata for cleaning the data, and Excel to finalize the data. This method aims to fasten the download and cleaning process and help relevant stakeholders who might be tired of clicking on the DJPK Kemenkeu website to download data one by one, saving their time. 
Note: you must have all three required software on your pc/laptop to fully use this system.
In this project, we have three levels of data which are national, province, and municipal level budget data. You can run manually straight from python to excel to edit the data for the national data. But for the province and municipal level, there is some step to pass through. 
Please follow this instruction before using the system. 
1. Install the required software/ library/ driver
2. Download or clone the repository to your local repo
3. Put the scraping tools folder in your default downloads folder (mine was in Downloads)
4. Adjust the repository location in both Python and Stata do-file
5. Run the Script to Generate Province Folder.do to generate a province folder in the KABKOT folder
6. Repeat this process (manually)
  - Run the crawler, wait for selenium finish download all files 
  - Put the downloaded data to respective folder
  - Repeat for each national level, province by each year, and municipal by each province
7. Run the Stata do-file from stata and you will get the excel file of cleaned version
8. You can finalize the data by merging with Statistics Indonesia (BPS) region classification code so you can merge with other dataset (DJPK data is not contained the region code so we need to generate by ourself)
9. I have attached the crosswalk to match the region in DJPK with Statistics Indonesia (BPS) code

Please contact me if there is any errata, critics, or suggestions. Thank You.
