create_and_run_batch_file_download <- function(AnaplanUser_z,WorkspaceID_z,model_id_z,export_name_z){
  wd1 <- getwd()
  file_z <- paste(export_name_z,".csv",sep = "")
  path_to_export_z <- paste(wd1,"/7_export/",file_z,sep = "")
  PathToBatchFile_z <- paste(wd1,"/4_anaplan-connect-1-3-3-3/",export_name_z,".bat",sep = "")
  
  BatchFileForImport <- file(PathToBatchFile_z)
  writeLines(paste("@echo off",
                   "\n",
                   "\n","set AnaplanUser=\"",AnaplanUser_z,"\"",
                   "\n","set WorkspaceId=\"",WorkspaceID_z,"\"",
                   "\n","set ModelId=\"",model_id_z,"\"",
                   "\n","set Operation=","-export \"",file_z,"\" -execute"," -get \"",path_to_export_z,"\"",
                   "\n",
                   "\n","setlocal enableextensions enabledelayedexpansion || exit /b 1",
                   "\n","cd %~dp0",
                   "\n","if not %AnaplanUser% == \"\" set Credentials=-user %AnaplanUser%",
                   "\n","set Command=.\\AnaplanClient.bat %Credentials% -workspace %WorkspaceId% -model %ModelId% %Operation%",
                   "\n","@echo %Command%","\n","cmd /c %Command%",
                   "\n","exit",sep = ""), BatchFileForImport)
  close(BatchFileForImport)
  
  shell.exec(PathToBatchFile_z)
  
  Sys.sleep(15)
  
  while(file.exists(path_to_export_z)==FALSE){
    Sys.sleep(10)}
  
  Sys.sleep(20)}