  create_and_run_batch_file_process <- function(AnaplanUser_z,WorkspaceID_z,model_id_z,process_z){
  wd1 <- getwd()
  output_z <- paste(wd1,"/5_errors/Anaplan_errors/",process_z,"_errors.csv",sep = "")
  PathToBatchFile_z <- paste(wd1,"/4_anaplan-connect-1-3-3-3/",process_z,".bat",sep = "")
  
  BatchFileForImport <- file(PathToBatchFile_z)
  writeLines(paste("@echo off",
                   "\n",
                   "\n","set AnaplanUser=\"",AnaplanUser_z,"\"",
                   "\n","set WorkspaceId=\"",WorkspaceID_z,"\"",
                   "\n","set ModelId=\"",model_id_z,"\"",
                   "\n","set Operation=","-process \"",process_z,"\" -execute"," -output \"",output_z,"\"",
                   "\n",
                   "\n","setlocal enableextensions enabledelayedexpansion || exit /b 1",
                   "\n","cd %~dp0",
                   "\n","if not %AnaplanUser% == \"\" set Credentials=-user %AnaplanUser%",
                   "\n","set Command=.\\AnaplanClient.bat %Credentials% -workspace %WorkspaceId% -model %ModelId% %Operation%",
                   "\n","@echo %Command%","\n","cmd /c %Command%",
                   "\n","exit",sep = ""), BatchFileForImport)
  close(BatchFileForImport)
  
  shell.exec(PathToBatchFile_z)}