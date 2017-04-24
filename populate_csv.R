populate_csv_f <- function(model_id_x,populate_csv_yaml_x){

    # fetches table names from "populate_csv.yaml" only for the model id fetched in first loop
    # ALL THE TABLES within one model
    for (table_names in populate_csv_yaml_x[model_id_x]) {

      # fetches only one table at a time from the model fetched in first loop within the tables fetched in second loop
      #ONLY ONE TABLE of one model
      for (table_name in table_names) {

        split <- c(strsplit(table_name," / "))

      i <- as.integer(length(split[[1]]))

      # gsub suppresses any quote in the original text
      # gsub is needed because some module names start with # (which in yaml means "comment")
      csv_name <- gsub("\'","", split[[1]][1])

      # csv_name_copies is a vector of length i-1
      csv_name_copies <- gsub("\'","", split[[1]][2:i])

        # hence you can create a loop on the elements of csv_name_copies
        for (csv_name_copy in csv_name_copies) {

          # defines the path from where to get the csv and to where to copy the csv
          path_to_csv_name <- paste('./3_csv/shared_folder/',csv_name,'.csv',sep = "")
          path_to_csv_name_copy <- paste('./3_csv/',csv_name_copy,'.csv',sep = "")

          # copies each csv according to defined paths  
          
          if(file.exists(path_to_csv_name_copy)){file.remove(path_to_csv_name_copy)}
          
          file.copy(path_to_csv_name,path_to_csv_name_copy)
          

        }}}}
