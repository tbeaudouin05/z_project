re_import_bp_to_seasonal_planning <- function(export_name_u,model_id_u){
  
# useless, just to harmonize the logic / naming convention with re_import_ps1_ps2 function
csv_name_u <- export_name_u

move_export_to_csv_folder(export_name_u,csv_name_u)
  
create_and_run_batch_file_upload(config$anaplan$login,config$anaplan$workspace_id,model_id_u,csv_name_u,'Plan Ctry_Cat_Dep')
  
}