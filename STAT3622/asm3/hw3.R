library(rvest)
library(xml2)
library(dplyr)
library(ggplot2)
library(plotly)
library(dygraphs)
library(xts)

thisurl = paste0(paste0("https://brandirectory.com/rankings/global/", 2011:2020, "/table",
                 collapse = ","), ",https://brandirectory.com/rankings/global/table")
thisurl = as.list(strsplit(thisurl, ",")[[1]])
DataList = as.list(1:11)
yearList = as.list(2011:2021)

dfDecade = NULL

for (j in 1:11){
  webpage <- read_html(thisurl[[j]])
  # Inspect the webpage
  xdata <- webpage %>% html_nodes("body tbody") %>% html_nodes("tr")
  DataX = NULL
  
  for (i in 1:100){
    tmp <- xdata[i] %>% html_nodes("td")
    rank <- tmp[1] %>% html_text()  %>% as.numeric()
    past_rank <- tmp[2] %>% html_text()  %>% as.numeric()
    company <- tmp[3] %>% html_text()
    company = trimws(gsub("\n", "", company))
    country <- tmp[4] %>% html_text() 
    country = trimws(gsub("\n", "", country))
    value <- tmp[5] %>% html_nodes("span") %>% html_text()
    past_value <- tmp[6] %>% html_nodes("span") %>% html_text()
    rate <- tmp[7] %>% html_text()  
    rate = trimws(gsub("\n", "", rate))
    past_rate <- tmp[8] %>% html_text()  
    past_rate = trimws(gsub("\n", "", past_rate))
    year = yearList[[j]]
    DataX = rbind(DataX, c(rank, past_rank,company, country, value, 
                           past_value, rate, past_rate))
    dfDecade = rbind(dfDecade, c(year, rank, past_rank,company, country, value, 
                              past_value, rate, past_rate))
  }
  
  colnames(DataX) = c("Rank", "Past_Rank", "Company", "Country", 
                      "Value", "Past_Value", "Rate", "Past_rate")
  DataList[[j]] = as.data.frame(DataX)
}

colnames(dfDecade) = c("Year", "Rank", "Past_Rank", "Company", "Country", 
                       "Value", "Past_Value", "Rate", "Past_rate")
dfDecade = as.data.frame(dfDecade)


# --- 1b ---
NoOfBrandIn2021 = summarize(group_by(DataList[[11]],Country=Country),
                   country.freq=n())

fig <- plot_ly(NoOfBrandIn2021, labels = ~Country, values = ~country.freq, type = 'pie')
fig <- fig %>% layout(title = 'Number of brands by country in 2021',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

fig

# --- 1c ---
NoOfBrandInDecade = summarize(group_by(dfDecade,Year = Year, Country=Country),
                              country.freq=n())

fig <- NoOfBrandInDecade %>%
        plot_ly(
          labels = ~Country,
          values = ~country.freq,
          frame = ~Year,
          type = 'pie'
        )
fig <- fig %>% layout(title = 'Number of brands by country from 2011 to 2021',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

fig


# --- 1d ---
Year = 2021
DataList[[11]]$Rank = as.numeric(DataList[[11]]$Rank)
DataList[[11]]$Past_Rank = as.numeric(DataList[[11]]$Past_Rank)
xlim0=c(1, max(DataList[[11]]$Past_Rank))
ylim0=c(1,max(DataList[[11]]$Rank))
DataList[[11]] = transform(DataList[[11]], Value = as.vector(Value))
for (i in 1:100){
  DataList[[11]]$Value[i] = gsub("[^0-9///' ]","", DataList[[11]]$Value[i])
}
DataList[[11]] = transform(DataList[[11]], Value = as.numeric(Value))


sectorList = as.list(c("restaurants", "logistics","tyres", "car-rental-services",
               "auto-components", "telecoms", "telecoms-infrastructure",
               "gambling", "retail", "chemicals", "banking", "it-services",
               "oil-and-gas", "tech", "auto"))
thisurl = paste0("https://brandirectory.com/rankings/", sectorList, "/table", collapse = ",")
thisurl = as.list(strsplit(thisurl, ",")[[1]])
DataList[[11]]$Sector = rep("others", 100)

for (j in 1:length(sectorList)){
  webpage <- read_html(thisurl[[j]])
  xdata <- webpage %>% html_nodes("body tbody") %>% html_nodes("tr")
  DataX = NULL
  for (i in 1:length(xdata)){
    tmp <- xdata[i] %>% html_nodes("td")
    company <- tmp[3] %>% html_text()
    company = trimws(gsub("\n", "", company))
    
    if(company %in% as.vector(DataList[[11]]$Company)){
      DataList[[11]]$Sector[DataList[[11]]$Company == company] <- sectorList[[j]]
    }
  }
}

plot_ly(DataList[[11]], x = ~Past_Rank, y = ~Rank, type="scatter", mode = "markers",
        size = ~Value, color = ~Sector,
        hoverinfo = 'text',
        text = ~paste("", Company)) %>%
  layout(title= "Brand ranking in 2020 versus 2021",
         xaxis = list(range = xlim0, 
                      zeroline=FALSE,
                      title=paste(Year-1, "Ranking")),
         yaxis = list(range = ylim0, 
                      autorange="reversed", 
                      zeroline=FALSE, 
                      title=paste(Year, "Ranking"))
)

# --- 1e ---
bigTechValue = filter(dfDecade, dfDecade$Company == "Apple" | dfDecade$Company == "Google" |
                        dfDecade$Company == "Amazon" | dfDecade$Company == "Microsoft" |
                        dfDecade$Company == "Amazon.com")
bigTechValue = transform(bigTechValue, Value = as.vector(Value))
for (i in 1:nrow(bigTechValue)){
  bigTechValue$Value[i] = gsub("[^0-9///' ]","", bigTechValue$Value[i])
}
bigTechValue = transform(bigTechValue, Value = as.numeric(Value))
bigTechValue$Company[bigTechValue$Company == "Amazon.com"] = "Amazon"

bigTechDF = select(bigTechValue, c("Year", "Company", "Value"))
appleDF = filter(bigTechDF, bigTechValue$Company == "Apple")
googleDF = filter(bigTechDF, bigTechValue$Company == "Google")
amazonDF = filter(bigTechDF, bigTechValue$Company == "Amazon")
microDF = filter(bigTechDF, bigTechValue$Company == "Microsoft")

names(appleDF)[3] = "Apple"
names(googleDF)[3] = "Google"
names(amazonDF)[3] = "Amazon"
names(microDF)[3] = "Microsoft"
appleDF$Company = NULL
googleDF$Company = NULL
amazonDF$Company = NULL
microDF$Company = NULL

bigTechDF = Reduce(function(x, y) merge(x, y, all=TRUE), list(appleDF, googleDF, amazonDF, microDF))
bigTechDF$Year = as.Date(ISOdate(bigTechDF$Year, 1, 1))

bigTechDF = xts(x = bigTechDF[, -1], order.by = bigTechDF$Year)
dygraph(bigTechDF, main = "Values from 2011 to 2021") %>%
  dyRangeSelector()













