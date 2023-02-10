library(dplyr)
library(ggplot2)
library(corrplot)
library(tidyr)
library(tidyverse)

# 1
# df = read.delim('/Users/guyverchan/Documents/HKU/STAT3622/seeds.txt', header = TRUE, sep = ",")
print('Hello')

# # 1a
# ggplot(df, aes(x=variety))+
#   geom_bar(width=0.7, stat = "identity")

# result = summarize(group_by(df,variety=variety),
#                    variety.freg=n())
# label=paste0(round(sort(result$variety.freg)/sum(result$variety.freg),2) * 100,"%")
# at = nrow(result) - as.numeric(cumsum(sort(result$variety.freg))-0.5*sort(result$variety.freg))

# ggplot(df, aes(x=factor(1), fill=variety))+
#   geom_bar(width = 1)+
#   coord_polar("y") +
#   theme_void() + 
#   ggtitle("Distribution for variety" ) 

# # 1b
# gather_df = gather(df, key = "key", value = "val", -variety)

# ggplot(gather_df, aes(x = variety, y = val, colour = variety)) +
#   geom_violin(adjust = 1) +
#   geom_boxplot(width=0.1) + 
#   facet_wrap(~key, scales = "free") +
#   theme_minimal()+
#   ggtitle("Distribution for all attributes") 

# # 1c
# mean_each_col = colMeans(df[sapply(df, is.numeric)])
# dst = data.matrix(dist(mean_each_col))
# heatmap(dst, Colv = NA, Rowv = NA, scale="column", cexCol=0.5, cexRow=0.7, main = "Euclidean distance matrix of samples")

# # 1d
# df$flag = ifelse(df$area > 15, "True", "False")
# ggplot(df, aes(variety, fill = flag)) +
#   geom_bar(position = "stack") +
#   ggtitle("Variety of seeds divided by flag") 

# # 1e
# ggplot(df, aes(x = length.of.kernel, y = width.of.kernel, colour = variety)) +
#   geom_point() +
#   theme_bw() +
#   ggtitle("Scatter plot of length vs width of kernel") 

# # 1f
# ggplot(df, aes(x = length.of.kernel, y = width.of.kernel)) +
#   facet_grid(. ~ variety) +
#   geom_point() +
#   theme_bw() + 
#   ggtitle("Scatter plot of length vs width of kernel on variety") 

# # 2
# df_q2 = read.delim('/Users/guyverchan/Documents/HKU/STAT3622/Boston.txt', header = TRUE, sep = ",")

# # 2a
# gather_df_q2 = gather(df_q2, key = "key", value = "val")
# ggplot(gather_df_q2, aes(x = val, y = key)) +
#   geom_violin(adjust = 1) +
#   geom_boxplot(width=0.1) + 
#   facet_wrap(~key, scales = "free") +
#   theme_minimal()+
#   ggtitle("Distribution for all attributes") 


# # 2b
# corrplot(cor(df_q2), method = "number", type = "upper", diag = FALSE, number.cex = .7)

# # 2c
# lm = lm(medv ~ . -indus -age, data = df_q2)
# summary(lm)


# # 2d
# df_q2 = select(df_q2,-indus, -age)
# lm_df_q2 = gather(df_q2, key = "key", value = "val", -medv)
# ggplot(lm_df_q2, aes(x = val, y = medv)) +
#   geom_point() +
#   stat_smooth(method = "lm", se = TRUE, col = "blue") +
#   facet_wrap(~key, scales = "free") +
#   theme_gray() +
#   ggtitle("Scatter plot of dependent variables vs Median Value") 

# par(mfrow = c(2, 2))
# plot(lm)

# # 3
# df_q3 = read.delim('/Users/guyverchan/Documents/HKU/STAT3622/mpg.txt', header = TRUE, sep = ",")

# # 3a
# avg_displ = summarize(group_by(df_q3, year=year), 
#                                 displ.mean=mean(displ))
# # View(avg_displ)

# #  3b
# median_hwy = summarize(group_by(df_q3, year=year, model=model), 
#                                  hwy.median=median(hwy))
# # View(median_hwy)

# # 3c
# five_obj = arrange(select(df_q3, displ, cyl), 
#                  desc(displ), desc(cyl))
# head(five_obj, 5)

# # 3d
# no_of_car_with_condi = summarize(group_by(filter(df_q3,cyl>4 & fl=="r"),
#                          year=year, class=class),
#                 count = n())
# ggplot(data=no_of_car_with_condi, aes(x=class, y=count, fill=year)) +
#   geom_bar(stat="identity") +
#   coord_flip() + 
#   ggtitle("Number of each type of car per year")

# # 3e
# affected_by_type = summarize(group_by(filter(df_q3,class == 'suv'),
#                                       manufacturer=manufacturer),
#                              displ.median=median(displ),
#                              cyl.median = median(cyl))
# ggplot(data=affected_by_type, aes(x=manufacturer, y=displ.median, fill=cyl.median)) +
#   geom_bar(stat="identity") +
#   coord_flip() + 
#   ggtitle("Median of displacement and cylinders of SUV by manufacturers")





