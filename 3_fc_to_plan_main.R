# install these packages only if the user does not have them
if('RPostgreSQL' %in% rownames(installed.packages()) == FALSE) {install.packages("RPostgreSQL",dependencies=TRUE,repos="http://cran.stat.nus.edu.sg/",type="source")}
if('yaml' %in% rownames(installed.packages()) == FALSE) {install.packages("yaml")}
if('plyr' %in% rownames(installed.packages()) == FALSE) {install.packages("plyr")}
if('gmailr' %in% rownames(installed.packages()) == FALSE) {install.packages("gmailr")}
if('googlesheets' %in% rownames(installed.packages()) == FALSE) {install.packages("googlesheets")}
if('magrittr' %in% rownames(installed.packages()) == FALSE) {install.packages("magrittr")}
if('xlsx' %in% rownames(installed.packages()) == FALSE) {install.packages("xlsx")}

# calls the necessary packages for the code to run (installed above)
library(RPostgreSQL)
library(yaml)
library(plyr)
library(googlesheets)
library(magrittr)
library(xlsx)

# timestamps when the code starts
print(Sys.time())

# takes into consideration the settings chosen in the yaml files
config <- yaml.load_file("./0_settings_yaml_files/1_config.yaml")
brand_update <- yaml.load_file("./0_settings_yaml_files/3_brand_update.yaml")
populate_csv <- yaml.load_file("./0_settings_yaml_files/4_populate_csv.yaml")
export <- yaml.load_file("./0_settings_yaml_files/5_export.yaml")


# fetches functions created in other R modules 
# (for the sake of clarity, not the whole code is in one place, we defined functions in other modules)
source ("./1_R_code_to_source/1_create_csv/download_csv.R")
source ("./1_R_code_to_source/1_create_csv/populate_csv.R")
source("./1_R_code_to_source/2_anaplan/anaplan_upload.R")
source("./1_R_code_to_source/2_anaplan/anaplan_process.R")
source("./1_R_code_to_source/2_anaplan/anaplan_download.R")
source("./1_R_code_to_source/5_export/export_and_apply.R")
source("./1_R_code_to_source/4_gdoc/create_excel_validation.R")
source("./1_R_code_to_source/5_export/move_export_or_import.R")
source("./1_R_code_to_source/5_export/re_import_ps1_ps2.R")

export_and_apply(3)

export_and_apply(4)
