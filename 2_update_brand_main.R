# install these packages only if the user does not have them
if('RPostgreSQL' %in% rownames(installed.packages()) == FALSE) {install.packages("RPostgreSQL",dependencies=TRUE,repos="http://cran.stat.nus.edu.sg/",type="source")}
if('yaml' %in% rownames(installed.packages()) == FALSE) {install.packages("yaml")}
if('plyr' %in% rownames(installed.packages()) == FALSE) {install.packages("plyr")}
if('gmailr' %in% rownames(installed.packages()) == FALSE) {install.packages("gmailr")}
if('googlesheets' %in% rownames(installed.packages()) == FALSE) {install.packages("googlesheets")}
if('magrittr' %in% rownames(installed.packages()) == FALSE) {install.packages("magrittr")}
if('xlsx' %in% rownames(installed.packages()) == FALSE) {install.packages("xlsx")}
if('stringr' %in% rownames(installed.packages()) == FALSE) {install.packages("stringr")}


# calls the necessary packages for the code to run (installed above)
library(RPostgreSQL)
library(yaml)
library(plyr)
library(googlesheets)
library(magrittr)
library(xlsx)
library(stringr)

# timestamps when the code starts
print(Sys.time())

# takes into consideration the settings chosen in the yaml files
config <- yaml.load_file("./0_settings_yaml_files/1_config.yaml")
brand_update <- yaml.load_file("./0_settings_yaml_files/3_brand_update.yaml")
populate_csv_yaml <- yaml.load_file("./0_settings_yaml_files/4_populate_csv.yaml")
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
#source("./1_R_code_to_source/5_export/change_switch_over_week.R")


export_and_apply(1)

# fetches model ids from "config.yaml"
# and link them with model names of "tables.yaml"
# ALL THE MODELS
for (model_id in config$anaplan$model_ids) {
  
  #populates the csv from the shared folder to the csv folder
  populate_csv_f(model_id,populate_csv_yaml)
  
  # fetches table names from "tables.yaml" only for the model id fetched in first loop
  # ALL THE TABLES within one model
  for (table_names in brand_update[model_id]) {
    
    # fetches only one table at a time from the model fetched in first loop within the tables fetched in second loop
    #ONLY ONE TABLE of one model
    for (table_name in table_names) { split <- c(strsplit(table_name," / "))
    
    # fetches the first part and the second part of the split
    #NB: one table = one csv_query_name / one module_name
    # gsub suppresses any quote in the original text
    # gsub is needed because some module names start with # (which in yaml means "comment")
    csv_query_name <- gsub("\'","", split[[1]][1])
    module_name <- gsub("\'","", split[[1]][2])
    process_name <- gsub("\'","", split[[1]][3])
    
    # prints names of csv/query, module and timestamp to identify easily errors if code breaks
    
    print(paste('model_id:',model_id))
    print(paste('csv_query_name:',csv_query_name))
    print(paste('module_name:',module_name))
    print(paste('process_name:',process_name))
    print(Sys.time())
    
    # loads the PostgreSQL driver
    drv <- dbDriver("PostgreSQL")
    
    # creates a connection to the postgres database
    # note that "con" will be used later in each connection to the database
    con <- dbConnect(drv, dbname = config$redcat$db,
                     host = config$redcat$host , port = config$redcat$port,
                     user = config$redcat$user , password = config$redcat$pw)
    
    # uses the function defined in the R file "redcat_download.R"
    # as the name suggests, this function runs the query on redcat and writes the csv in the appropriate folder
    if (csv_query_name == 'subcat_level_list'){run_query_write_csv(model_id,csv_query_name,con)}
    
    dbDisconnect(con)
    
    # uses the function defined in the R file "anaplan_upload.R"
    # it uses Anaplan built-in tool "anaplan connect" to upload data to Anaplan
    create_and_run_batch_file_upload(config$anaplan$login,config$anaplan$workspace_id,model_id,csv_query_name,module_name)
    
    Sys.sleep(20)
    
    create_and_run_batch_file_process(config$anaplan$login,config$anaplan$workspace_id,model_id,process_name)
    
    move_import_to_archive(csv_query_name)
    
    }}}

export_and_apply(2)


# timestamps when the code ends
print(Sys.time())
