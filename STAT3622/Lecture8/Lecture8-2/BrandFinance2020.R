library(rvest)

thisurl = "https://brandirectory.com/rankings/global/table"
webpage <- read_html(thisurl)

# Inspect the webpage
xdata <- webpage %>% html_nodes("body tbody") 
DataX = NULL
for (i in 1:length(xdata)){
  tmp <- xdata[i] %>% html_nodes("td") 
  rank21 <- tmp[1] %>% html_text()  %>% as.numeric() 
  rank20 <- tmp[2] %>% html_text()  %>% as.numeric()
  logo <- tmp[3] %>% html_nodes("img") %>% xml_attr("src")
  company <- tmp[3] %>% html_text() 
  company = trimws(gsub("\n", "", company))
  country <- tmp[4] %>% html_text() 
  country = trimws(gsub("\n", "", country))
  flag <- tmp[5] %>% html_nodes("img") %>% xml_attr("src")
  value21 <- tmp[5] %>% html_nodes("span") %>% html_text()  
  value20 <- tmp[6] %>% html_nodes("span") %>% html_text()  
  rate21 <- tmp[7] %>% html_text()  
  rate21 = trimws(gsub("\n", "", rate21))
  rate20 <- tmp[8] %>% html_text()  
  rate20 = trimws(gsub("\n", "", rate20))
  DataX = rbind(DataX, c(rank21, rank20,logo, company, country,flag, value21, value20, rate21, rate20))
}

# xname <- webpage %>% html_nodes(".col-sm-9 .main th") %>% html_text() 
colnames(DataX) = c("Rank21", "Rank20", "Company", "Country", 
                    "Value21", "Value20", "Rate21", "Rate20")
DataX = as.data.frame(DataX)
# knitr::kable(head(DataX), format="html")
write.csv(DataX,  file="TopBrand2021.csv", row.names=F)
