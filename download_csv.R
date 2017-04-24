# 3 arguments for this function: table name, model id and a connection to a database
run_query_write_csv <- function (model_id_x,table_name_x,con_x) {

# defines the path to the query depending on the table name
path_to_query <- paste("./2_queries/",model_id_x,"/",table_name_x,".txt",sep = "")

# defines the path to where we want to save the csv (and the name of the csv)
path_to_csv <- paste("./3_csv/",table_name_x,".csv",sep = "")

file.create(path_to_csv)

i <- 1

while(file.info(path_to_csv)$size < 10000){

if(i > 1){Sys.sleep(10)}

# fetches the text of the query in the folder "path_to_query" 
# query is stored in text format in "path_to_query" - it needs to be converted into string in R
unformatted_query <- readLines(path_to_query)

# formats the text of the query so that it becomes readable by R 
#NB: THERE SHOULD BE NO COMMENT IN THE SQL or this will not work
formatted_query <- paste(unformatted_query, collapse=" ")
formatted_query <- gsub("\t","", formatted_query)

# runs the query on redcat
query_output <- dbGetQuery(con_x,formatted_query)

# publishes the csv in "csv" folder
write.table(query_output, file = path_to_csv , row.names=FALSE, na="",sep = "|")

i <- i+1
}
}
