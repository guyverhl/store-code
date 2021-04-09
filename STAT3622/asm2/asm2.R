library(magick)
library(plotly)
library(dplyr)
library(sp)

HKHomeCCL = read.csv("/Users/guyverchan/Documents/HKU/STAT3622/asm2/HKHomeCCL.csv")
HK18Districts = read.csv("/Users/guyverchan/Documents/HKU/STAT3622/asm2/HK18Districts.csv")
hkmap = readRDS("/Users/guyverchan/Documents/HKU/STAT3622/asm2/HKG_adm1.rds")

# Q1a
Symbol = names(HKHomeCCL)[-1]

fig <- plot_ly(HKHomeCCL, x = ~Date) %>% 
  add_trace(y = ~HK, name = 'HK',mode = 'lines', type = 'scatter') %>% 
  add_trace(y = ~KL, name = 'KL',mode = 'lines', type = 'scatter') %>% 
  add_trace(y = ~NTE, name = 'NTE',mode = 'lines', type = 'scatter') %>% 
  add_trace(y = ~NTW, name = 'NTW',mode = 'lines', type = 'scatter') %>%
  layout(title = "Home Price versus Date by regions")
fig

# Q1b
hkmapdf = fortify(hkmap)
ggplot(hkmapdf, aes(long, lat, group=group)) +
  geom_polygon(fill=hkmapdf$id) +
  ggtitle("Map of Hong Kong")

# Q1c
hkmapcode = data.frame(id=hkmap$ID_1, 
                       Code= gsub('HK.', '', as.character(hkmap$HASC_1)))
hkmapdf = merge(hkmapdf, hkmapcode, by="id")
hkmapdf = merge(hkmapdf, HK18Districts, by="Code")
ggplot(hkmapdf, aes(long, lat, group=group, fill=Region)) +
  geom_polygon() + 
  ggtitle("Hong Kong: Region")

# Q1d
Mar22 = filter(HKHomeCCL, Date == "2020/03/22")
Mar22 = data.frame(t(Mar22[, -1]))
Mar22$Region = rownames(Mar22)
colnames(Mar22)[1] <- "Home_Price"

hkmapdf = merge(hkmapdf, Mar22, by="Region")
ggplot(hkmapdf, aes(long, lat, group=group, fill=Home_Price)) +
  geom_polygon() + 
  scale_fill_gradient(limits=range(hkmapdf$Home_Price),
                      low="skyblue", high="yellow") + 
  ggtitle("Hong Kong: Home Price by Region")







