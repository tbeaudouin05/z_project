create_excel_validation_source_file <- function(export_name_x){
  
  path_to_export <- paste("./7_export/",export_name_x,".csv",sep = "")
  path_to_excel <- paste("./8_gdoc/",export_name_x,".xls",sep = "")
  
  table <- read.csv(path_to_export)
  table['Country'] <- data.frame(lapply(table['Country'],FUN = tolower))
  excel_prep <- c(table['Country'],table['Category'],table['Department'],table['Brand'],table['Code'])
  excel <- data.frame(excel_prep)
  
  if(file.exists(path_to_excel)){file.remove(path_to_excel)}
  
  write.xlsx(x = excel, file = path_to_excel,
             sheetName = export_name_x, row.names = FALSE)}