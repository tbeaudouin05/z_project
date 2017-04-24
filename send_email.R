
send_email <- function(){
## edit line below to reflect YOUR json credential filename
  gmail_auth(scope = "full", id = '1064291232862-kiim022036dmarldbb8vdfefofranb75.apps.googleusercontent.com',
             secret ='j_4XajFgKl9B73h0mI73UvTl')

today <- as.Date(Sys.time(), format="%d-%m-%Y")
weeknum <- as.numeric( format(today, "%U"))-4
weeknum1 <- weeknum-1

## edit below with email addresses from your life
test_email <- mime(
  To = "thomas.beaudouin@zalora.com",
  From = "thomas.beaudouin@zalora.com",
  Subject = paste("Anaplan Seasonal Planning Data updated for week",weeknum1),
  body = paste("Anaplan data is actualized to week",weeknum1,'(',today,')',"- week",weeknum,'onwards is forecasted figures.'))

send_message(test_email)}
