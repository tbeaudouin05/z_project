create_and_run_batch_file_upload <- function(AnaplanUser_x,WorkspaceID_x,ModelId_x,table_y,module_y){
wd1 <- getwd()
file_y <- paste(table_y,".csv", sep = "")
put_y <- paste(wd1,"/3_csv/",file_y,sep = "")
import_y <- paste(module_y," from ",file_y,sep = "")
output_y <- paste(wd1,"/5_errors/Anaplan_errors/",table_y,"_errors.csv",sep = "")
PathToBatchFile_y <- paste(wd1,"/4_anaplan-connect-1-3-3-3/",table_y,".bat",sep = "")

BatchFileForImport <- file(PathToBatchFile_y)
writeLines(paste("@echo off",
                 "\n",
                 "\n","set AnaplanUser=\"",AnaplanUser_x,"\"",
                 "\n","set WorkspaceId=\"",WorkspaceID_x,"\"",
                 "\n","set ModelId=\"",ModelId_x,"\"",
                 "\n","set Operation=","-file \"",file_y,"\" -put \"",put_y,"\" -import \"",import_y,"\" -execute"," -output \"",output_y,"\"",
                 "\n",
                 "\n","setlocal enableextensions enabledelayedexpansion || exit /b 1",
                 "\n","cd %~dp0",
                 "\n","if not %AnaplanUser% == \"\" set Credentials=-user %AnaplanUser%",
                 "\n","set Command=.\\AnaplanClient.bat %Credentials% -workspace %WorkspaceId% -model %ModelId% %Operation%",
                 "\n","@echo %Command%","\n","cmd /c %Command%",
                 "\n","exit",sep = ""), BatchFileForImport)
close(BatchFileForImport)

shell.exec(PathToBatchFile_y)}
