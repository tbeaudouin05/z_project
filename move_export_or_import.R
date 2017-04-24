move_export_to_archive <- function(export_name_y){
  
export_name_y <- '#Ctry_Cat_Dep_Brand_export'

extension <- if(file.exists(paste('./7_export/',export_name_y,'.csv',sep = ''))){'.csv'} else {'.xls'}
time <- gsub(':','-',Sys.time())
path_to_export <- paste('./7_export/',export_name_y,extension,sep = '')
path_to_archive <- paste('./9_archive/',export_name_y,' ',time,extension,sep = '')

if(file.exists(path_to_archive)){file.remove(path_to_archive)}
  
file.copy(path_to_export,path_to_archive)
  
}

move_import_to_archive <- function(import_name_y){
  
  extension <- if(file.exists(paste('./3_csv/',import_name_y,'.csv',sep = ''))){'.csv'} else {'.xls'}
  time <- gsub(':','-',Sys.time())
  path_to_import <- paste('./3_csv/',import_name_y,extension,sep = '')
  path_to_archive <- paste('./9_archive/',import_name_y,' ',time,extension,sep = '')
  
  if(file.exists(path_to_archive)){file.remove(path_to_archive)}
  
  file.copy(path_to_import,path_to_archive)
  
}

move_export_to_csv_folder <- function(export_name_w, csv_name_w){
  
  extension <- if(file.exists(paste('./7_export/',export_name_w,'.csv',sep = ''))){'.csv'} else {'.xls'}
  path_to_export <- paste('./7_export/',export_name_w,extension,sep = '')
  path_to_csv_folder <- paste('./3_csv/',csv_name_w,extension,sep = '')
  
  if(file.exists(path_to_csv_folder)){file.remove(path_to_csv_folder)}
  
  file.copy(path_to_export,path_to_csv_folder)
  
}