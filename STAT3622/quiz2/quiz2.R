library(tidyverse)
library(meta)


df = read.csv("/Users/guyverchan/Documents/HKU/STAT3622/quiz2/covtype_pca.csv")
df_jaha = read.csv("/Users/guyverchan/Documents/HKU/STAT3622/quiz2/jaha_paclitaxel.csv")

## k-means algorithm
set.seed(2021)
cl = kmeans(df,3)$cluster

pca_result <- prcomp(df)
pca_df <- as.data.frame(pca_result$x[,c(1:2)])
pca_df$cluster <- as.factor(cl)

ggplot(pca_df, aes(x = PC1, y = PC2, col = cluster)) + 
  geom_point(alpha = 0.5) +
  xlab("First Principal Component") +
  ylab("Second Principal Component") +
  ggtitle("First Two Principal Components of Cov Type")

# Q2
df_jaha = df_jaha[df_jaha$Period == '2', ]

m.bin <- metabin(P.Events,P.Total,C.Events,C.Total,
                 data = df_jaha,
                 studlab = paste(Study),
                 comb.fixed = T,comb.random = T,
                 method = 'MH',sm = "RR")

forest(m.bin, leftcols = c('studlab'))

funnel(m.bin)

metabias(m.bin, method.bias = 'linreg', plotit = T)





