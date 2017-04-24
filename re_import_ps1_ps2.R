# this function moves forecasts from FC to PS1 OR PS2 
# for a certain year and semester depending on input in config.yaml under 'lock plan'
re_import_ps1_ps2_season <- function(export_name_z, model_id_z){

# makes sure that only one plan was chosen in config.yaml under 'lock plan'
if(length(config$anaplan$`lock plan`)>1){

  winDialog(type = 'ok','ERROR! Please choose PS1 OR PS2 in config.yaml - YOU CANNOT USE BOTH')}

else {

# NB: config is defined in the script calling this function, not here
plan_and_semester <- config$anaplan$`lock plan`

print(paste('Plan / semester / year:',plan_and_semester))

split <- c(strsplit(plan_and_semester," / "))

plan <- gsub("\'","", split[[1]][1])
semester <- gsub("\'","", split[[1]][2])
year <- gsub("\'","", split[[1]][3])

csv_name_z <- paste(export_name_z,'_',plan,sep = '')
path_to_export_z <- paste('./7_export/',export_name_z,'.csv',sep = '')
path_to_csv_z <- paste('./3_csv/',csv_name_z,'.csv',sep = '')

export_table <- read.csv(path_to_export_z,header = FALSE)
i <- length(export_table)

for (j in 1:i) {

  if(export_table[1,j] == paste(semester,year)){

prepared_table <- data.frame(export_table[1:2],export_table[j])

write.csv(prepared_table,path_to_csv_z)}

}

#create_and_run_batch_file_upload(config$anaplan$login,config$anaplan$workspace_id,model_id_z,csv_name_z, export_name_z)

}}

# SECOND FUNCTION (same but for weekly level)
re_import_ps1_ps2_weekly <- function(export_name_z, model_id_z){
  
  if(length(config$anaplan$`lock plan`)>1){
    
    winDialog(type = 'ok','ERROR! Please choose PS1 OR PS2 in config.yaml - YOU CANNOT USE BOTH')}
  
  else {
    
    plan_and_semester <- config$anaplan$`lock plan`
    
    print(paste('Plan / semester / year:',plan_and_semester))
    
    split <- c(strsplit(plan_and_semester," / "))
    
    # fetches the first part and the second part of the split
    plan <- gsub("\'","", split[[1]][1])
    semester <- gsub("\'","", split[[1]][2])
    year <- gsub("\'","", split[[1]][3])
    
    csv_name_z <- paste(export_name_z,'_',plan,sep = '')
    path_to_export_z <- paste('./7_export/',export_name_z,'.csv',sep = '')
    path_to_csv_z <- paste('./3_csv/',csv_name_z,'.csv',sep = '')
    
    export_table <- read.csv(path_to_export_z,header = FALSE)
    

    i <- length(export_table)
    prepared_table <- data.frame(export_table[1:2])
    if (semester == 'H1'){
      week_numbers <- 1:26} else if (semester =='H2') {
        week_numbers <- 27:52} else 
          winDialog(type = 'ok','ERROR! Please input correct semester in config.yaml: H1 OR H2')
    
    for (j in 1:i) {
      
      for (week_number in week_numbers) {
      
      if(export_table[1,j] == paste('Week',week_number,year)){
        
        prepared_table <- data.frame(prepared_table,export_table[j])
        
        write.csv(prepared_table,path_to_csv_z)}
      }
    }
    
    #create_and_run_batch_file_upload(config$anaplan$login,config$anaplan$workspace_id,model_id_z,csv_name_z, export_name_z)
    
  }}
