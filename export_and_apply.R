export_and_apply <- function(trigger_x){

# fetches model ids from "config.yaml"
# and link them with model names of "tables.yaml"
# ALL THE MODELS
for (model_id in config$anaplan$model_ids) {

  # fetches table names from "tables.yaml" only for the model id fetched in first loop
  # ALL THE TABLES within one model
  for (table_names in export[model_id]) {

    # fetches only one table at a time from the model fetched in first loop within the tables fetched in second loop
    #ONLY ONE TABLE of one model
    for (table_name in table_names) { split <- c(strsplit(table_name," / "))

    # fetches the first part and the second part of the split
    #NB: one table = one csv_query_name / one module_name
    # gsub suppresses any quote in the original text
    # gsub is needed because some module names start with # (which in yaml means "comment")
    export_name <- gsub("\'","", split[[1]][1])
    function_name <- gsub("\'","", split[[1]][2])
   
    # prints names of export and timestamp to identify easily errors if code breaks


    # uses the function defined in the R file "anaplan_upload.R"
    # it uses Anaplan built-in tool "anaplan connect" to upload data to Anaplan


    if ((function_name == 'move_export_to_archive') & (trigger_x == 1)){

      print(paste('Trigger number:',trigger_x))
      print(paste('model_id:',model_id))
      print(paste('export_name:',export_name))
      print(paste('action_function_name:',function_name))
      print(Sys.time())
      
      create_and_run_batch_file_download(config$anaplan$login,config$anaplan$workspace_id,model_id,export_name)
      move_export_to_archive(export_name)}

    else if ((function_name == 'create_excel_validation_source_file') & (trigger_x == 2)) {
      
      print(paste('Trigger number:',trigger_x))
      print(paste('model_id:',model_id))
      print(paste('export_name:',export_name))
      print(paste('action_function_name:',function_name))
      print(Sys.time())
      create_and_run_batch_file_download(config$anaplan$login,config$anaplan$workspace_id,model_id,export_name)
      create_excel_validation_source_file(export_name)}

    else if ((function_name == 're_import_ps1_ps2_season') & (trigger_x == 3)) {

      print(paste('Trigger number:',trigger_x))
      print(paste('model_id:',model_id))
      print(paste('export_name:',export_name))
      print(paste('action_function_name:',function_name))
      print(Sys.time())
      create_and_run_batch_file_download(config$anaplan$login,config$anaplan$workspace_id,model_id,export_name)
      re_import_ps1_ps2_season(export_name,model_id)
      }
    
    else if ((function_name == 're_import_ps1_ps2_weekly') & (trigger_x == 4)) {
      
      print(paste('Trigger number:',trigger_x))
      print(paste('model_id:',model_id))
      print(paste('export_name:',export_name))
      print(paste('action_function_name:',function_name))
      print(Sys.time())
      create_and_run_batch_file_download(config$anaplan$login,config$anaplan$workspace_id,model_id,export_name)
      re_import_ps1_ps2_weekly(export_name,model_id)
      }
    
    else if ((function_name == 're_import_bp_to_seasonal_planning') & (trigger_x == 5)) {
      
      print(paste('Trigger number:',trigger_x))
      print(paste('model_id:',model_id))
      print(paste('export_name:',export_name))
      print(paste('action_function_name:',function_name))
      print(Sys.time())
      create_and_run_batch_file_download(config$anaplan$login,config$anaplan$workspace_id,model_id,export_name)
      re_import_bp_to_seasonal_planning(export_name,'4B884C14CBD4456984DA153D7679CF15')}

    else if (trigger_x == 7){

      print(paste('Trigger number:',trigger_x))
      print(paste('model_id:',model_id))
      print(paste('export_name:',export_name))
      print(paste('action_function_name:',function_name))
      print(Sys.time())
      create_and_run_batch_file_download(config$anaplan$login,config$anaplan$workspace_id,model_id,export_name)}
    }}}}