# Charge libraries:
library(ggplot2)
library(naniar)
library (readr)
library(plotly)
library(forcats)
library(cowplot)
library(ggstance)
library(RColorBrewer)
library(gridExtra)

#setwd("/Users/haoluo/Dropbox/BB. Project Management/COVID Prediction/Data")
#setwd("C:/Users/haolu/Dropbox/BB. Project Management/COVID Prediction/Data")
setwd("C:/Users/haoluo/Dropbox/BB. Project Management/COVID Prediction/Data")


# Import Data ####
# urlfile.daily="https://raw.githubusercontent.com/BillJiang1/COVID-19_Project/master/Code/data/daily_data_firstCase_210131.csv?token=AQ3HYQPMNPKM2RLDNFGDXKDAQMF3O"
# daily<-read_csv(url(urlfile.daily))
# urlfile.weekly="https://raw.githubusercontent.com/BillJiang1/COVID-19_Project/master/Code/data/weekly_data_firstCase_210131.csv?token=AQ3HYQJ4XABG3U3LOOBDMCLAQMGAU"
# weekly<-read_csv(url(urlfile.weekly))
#save(daily, weekly, file = "covid.RData")

load("covid.Rdata")

# Analysis start ####
#View(weekly)

gg_miss_upset(daily)
mydaily <- daily[complete.cases(daily$New_cases), ]


mydaily$Day <- as.Date(mydaily$Datetime, "%b")
mydaily$New_cases[mydaily$New_cases<0] <- 0
mydaily$New_deaths[mydaily$New_deaths<0] <- 0

end <- mydaily[mydaily$Day=="2021-01-31",]

case.top10 <- end[end$Cumulative_cases > quantile(end$Cumulative_cases)[4] ,] %>%
  mutate(Country = fct_reorder(Country, Cumulative_cases)) %>%
  ggplot(aes(x=Country, y=Cumulative_cases, col=Country)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  ylab("Cumulative # of cases") +
  theme(legend.position="none")

death.top10 <- end[end$Cumulative_deaths > quantile(end$Cumulative_deaths)[4] ,] %>%
  mutate(Country = fct_reorder(Country, Cumulative_deaths)) %>%
  ggplot(aes(x=Country, y=Cumulative_deaths, col=Country)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  ylab("Cumulative # of deaths") +
  theme(legend.position="none")

plot_grid(case.top10, death.top10)


top5 <- c("United States of America", "India", "Brazil", "Russian Federation", "The United Kingdom")
chosen3 <- c("Italy", "Sweden", "China")
my8 <- c(top5, chosen3)
mydata <- mydaily[mydaily$Country %in% my8,]

mydata <- mydata %>% 
  dplyr::rename(
    C1_school = "C1_School closing", C2_workplace = "C2_Workplace closing", C3_public_events = "C3_Cancel public events", 
    C4_gathering = "C4_Restrictions on gatherings", C5_transport = "C5_Close public transport", 
    C6_stayathome = "C6_Stay at home requirements", C7_internal_move = "C7_Restrictions on internal movement",
    C8_inter_travel = "C8_International travel controls", E1_income = "E1_Income support",
    E2_relief= "E2_Debt/contract relief", H1_campaigns = "H1_Public information campaigns",
    H2_testing = "H2_Testing policy", H3_contact_tracing = "H3_Contact tracing",
    H6_mask = "H6_Facial Coverings", H7_vaccination = "H7_Vaccination policy" 
  )


US <- mydata[mydata$Country=="United States of America",]
UK <- mydata[mydata$Country=="The United Kingdom",]
China <- mydata[mydata$Country=="China",]
Sweden <- mydata[mydata$Country=="Sweden",]

myfour <- mydata[mydata$Country %in% c("United States of America","The United Kingdom","China","Sweden"),]

ggplot(myfour, aes(x=New_cases, y=New_deaths, color=Country)) + geom_point(alpha=0.3)
ggplot(myfour, aes(x=New_cases, y=New_deaths, color=Country)) + xlim(0,5000) +  ylim(0,1000) + geom_point(alpha=0.3)

display.brewer.all(colorblindFriendly=FALSE)
brewer.pal(8,"Dark2")
mycol <- brewer.pal(8,"Dark2")

CC <- ggplot(mydata, aes(x = Day, y = C1_school, col=mycol[1])) +
  geom_point(na.rm=T) +
  geom_point(aes(y=C2_workplace+0.1), col=mycol[2]) +
  geom_point(aes(y=C3_public_events+0.2), col=mycol[3]) +
  geom_point(aes(y=C4_gathering+0.3), col=mycol[4]) +
  geom_point(aes(y=C5_transport+0.4), col=mycol[5]) +
  geom_point(aes(y=C6_stayathome+0.5), col=mycol[6]) +
  geom_point(aes(y=C7_internal_move+0.6), col=mycol[7]) +
  geom_point(aes(y=C8_inter_travel+0.7), col=mycol[8]) +
  ylab("Containment and closure") +
  facet_wrap( ~ Country, ncol=4) +
  theme(legend.position = "none")

fig.CC <- ggplotly(CC)
fig.CC

Health <- ggplot(mydata, aes(x = Day, y = H1_campaigns, col=mycol[1])) +
  geom_point(na.rm=T) +
  geom_point(aes(y=H2_testing+0.1), col=mycol[2]) +
  geom_point(aes(y=H3_contact_tracing+0.2), col=mycol[3]) +
  geom_point(aes(y=H6_mask+0.3), col=mycol[4]) +
  geom_point(aes(y=H7_vaccination+0.4), col=mycol[5]) +
  ylab("Health system") +
  facet_wrap( ~ Country, ncol=4) +
  theme(legend.position = "none")

fig.Health <- ggplotly(Health)
fig.Health


#### Try four countries with all policy measures ####
p.us.policy <- ggplot(US, aes(x=Day)) +
  geom_jitter(aes(y=C8_inter_travel, col=mycol[1]), alpha = 0.5, width = 0, height = 0.1) + 
  geom_jitter(aes(y=H2_testing,col=mycol[2]), alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H3_contact_tracing, col=mycol[3]),  alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H6_mask, col=mycol[4]), alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H7_vaccination, col=mycol[5]), alpha = 0.5, width = 0, height = 0.1) +
  xlab("Date") + ylab("Policy measures") +
  scale_color_identity(guide = "legend",
                       name = "Government responses:",
                       breaks = mycol[1:5],
                       labels = c("International travel","Testing","Contact tracing","Mask","Vaccination")) + 
  theme(legend.position = "bottom")

p.us.cases <- ggplot(US, aes(x=Day)) + 
  geom_line(aes(y=New_cases)) + ggtitle("US") +
  xlab("Date") + ylab("New Cases") +  
  theme(legend.position = "none")

us.combine <- grid.arrange(p.us.cases,p.us.policy,nrow=2)

p.uk.policy <- ggplot(UK, aes(x=Day)) +
  geom_jitter(aes(y=C8_inter_travel, col=mycol[1]), alpha = 0.5, width = 0, height = 0.1) + 
  geom_jitter(aes(y=H2_testing,col=mycol[2]), alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H3_contact_tracing, col=mycol[3]),  alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H6_mask, col=mycol[4]), alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H7_vaccination, col=mycol[5]), alpha = 0.5, width = 0, height = 0.1) +
  xlab("Date") + ylab("Policy measures") + ylim(0,4) + 
  scale_color_identity(guide = "legend",
                       name = "Government responses:",
                       breaks = mycol[1:5],
                       labels = c("International travel","Testing","Contact tracing","Mask","Vaccination")) + 
  theme(legend.position = "bottom")

p.uk.cases <- ggplot(UK, aes(x=Day)) + 
  geom_line(aes(y=New_cases)) + ggtitle("UK") +
  xlab("Date") + ylab("New Cases") +  
  theme(legend.position = "none")

uk.combine <- grid.arrange(p.uk.cases,p.uk.policy,nrow=2)



p.china.policy <- ggplot(China, aes(x=Day)) +
  geom_jitter(aes(y=C8_inter_travel, col=mycol[1]), alpha = 0.5, width = 0, height = 0.1) + 
  geom_jitter(aes(y=H2_testing,col=mycol[2]), alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H3_contact_tracing, col=mycol[3]),  alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H6_mask, col=mycol[4]), alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H7_vaccination, col=mycol[5]), alpha = 0.5, width = 0, height = 0.1) +
  xlab("Date") + ylab("Policy measures") + ylim(0,4) + 
  scale_color_identity(guide = "legend",
                       name = "Government responses:",
                       breaks = mycol[1:5],
                       labels = c("International travel","Testing","Contact tracing","Mask","Vaccination")) + 
  theme(legend.position = "bottom")

p.china.cases <- ggplot(China, aes(x=Day)) + 
  geom_line(aes(y=New_cases)) + ggtitle("China") +
  xlab("Date") + ylab("New Cases") +  
  theme(legend.position = "none")

china.combine <- grid.arrange(p.china.cases,p.china.policy,nrow=2)

p.sweden.policy <- ggplot(Sweden, aes(x=Day)) +
  geom_jitter(aes(y=C8_inter_travel, col=mycol[1]), alpha = 0.5, width = 0, height = 0.1) + 
  geom_jitter(aes(y=H2_testing,col=mycol[2]), alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H3_contact_tracing, col=mycol[3]),  alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H6_mask, col=mycol[4]), alpha = 0.5, width = 0, height = 0.1) +
  geom_jitter(aes(y=H7_vaccination, col=mycol[5]), alpha = 0.5, width = 0, height = 0.1) +
  xlab("Date") + ylab("Policy measures") + ylim(0,4) + 
  scale_color_identity(guide = "legend",
                       name = "Government responses:",
                       breaks = mycol[1:5],
                       labels = c("International travel","Testing","Contact tracing","Mask","Vaccination")) + 
  theme(legend.position = "bottom")

p.sweden.cases <- ggplot(Sweden, aes(x=Day)) + 
  geom_line(aes(y=New_cases)) + ggtitle("Sweden") +
  xlab("Date") + ylab("New Cases") +  
  theme(legend.position = "none")

sweden.combine <- grid.arrange(p.sweden.cases,p.sweden.policy,nrow=2)




cases <- ggplot(mydaily, aes(x=Day, y=New_cases, colour = Country)) +
  geom_line() +
  theme(legend.position="none")

fig.cases <- ggplotly(cases)
fig.cases


 
 deaths <- ggplot(mydaily, aes(x=Day, y=New_deaths, colour = Country)) +
   geom_line() +
   theme(legend.position="none")
 
 fig.deaths <- ggplotly(deaths)
 fig.deaths
 
 ccases <- ggplot(mydaily, aes(x=Day, y=Cumulative_cases, fill=Country)) + 
   geom_area()+
   theme(legend.position="none")
 fig.ccases <- ggplotly(ccases)
 fig.ccases
 
 cdeaths <- ggplot(mydaily, aes(x=Day, y=Cumulative_deaths, fill=Country)) + 
   geom_area()+
   theme(legend.position="none")
 fig.cdeaths <- ggplotly(cdeaths)
 fig.cdeaths