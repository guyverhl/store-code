library(magick)
## url 
image_read
tiger = image_read_svg('http://jeroen.github.io/images/tiger.svg',width = 350)
print(tiger)

image_write(tiger,path = "tiger.png",format = "png")

tiger_png = image_convert(tiger,format = "png")
tiger_png

## file connection!
zz = file("ex.txt","w")
cat("1 2 3 4","5 6 7 8","9 10 11 12",file = zz,sep = "\n")
## close the file connection!
close(zz)
## error, invalid connection!
cat("1 2 3 4","5 6 7 8","9 10 11 12",file = zz,sep = "\n")

library(car)
pairs(~mpg+disp+drat+wt,data=mtcars,main="Simple Scatterplot Matrix")
library(lattice)
library(lattice)
scatterplotMatrix(~mpg+disp+drat+wt|cyl, data=mtcars, main="Three Cylinder Options")

head(mtcars)

dat = mtcars
head(dat)
write.csv(dat,file = "mtcars.csv",quote=F)

library(gclus)
dta <- mtcars[c(1,3,5,6)] # get data
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
dta.o <- order.single(dta.r)
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5,
       main="Variables Ordered and Colored by Correlation" )


library(hexbin)
x <- rnorm(1000)
y <- rnorm(1000)
bin<-hexbin(x, y, xbins=50)
plot(bin, main="Hexagonal Binning")
# High Density Scatterplot with Color Transparency

################
pdf("scatterplot.pdf")
x <- rnorm(1000)
y <- rnorm(1000)
plot(x,y, main="PDF Scatterplot Example", col=rgb(0,100,0,50,maxColorValue=255), pch=16)
dev.off()

png("scatterplot.png")
x <- rnorm(1000)
y <- rnorm(1000)
plot(x,y, main="PDF Scatterplot Example", col=rgb(0,100,0,50,maxColorValue=255), pch=16)
dev.off()

# 3D Scatterplot
library(scatterplot3d)
attach(mtcars)
scatterplot3d(wt,disp,mpg, main="3D Scatterplot")


library(rgl)
plot3d(wt, disp, mpg, col="red", size=3)

library(Rcmdr)
attach(mtcars)
scatter3d(wt, disp, mpg)

plot(pressure$temperature, pressure$pressure, type="b",col="blue")
points(pressure$temperature, pressure$pressure)
lines(pressure$temperature, pressure$pressure/2, col="red")
points(pressure$temperature, pressure$pressure/2, col="red")

barplot(table(mtcars$cyl))

hist(mtcars$mpg, breaks=20,freq = T,main = "Mtcars")


###
boxplot(len ~ supp, data = ToothGrowth)

### function curvew
curve(x^3 - 5*x, from=-4, to=4)

myfun <- function(xvar) {
  1/(1 + exp(-xvar + 10))
}
curve(myfun(x), from=0, to=20)
curve(1-myfun(x), add = TRUE, col = "red")

library(gcookbook) # For the data set
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity") #values
ggplot(BOD, aes(x=factor(Time), y=demand)) + geom_bar(stat="identity")

ggplot(pg_mean, aes(x=group, y=weight)) +
  geom_bar(stat="identity", fill="lightblue", colour="black")

x = rnorm(1000)
## one row, two columns 
par(mfrow=c(1,2))
hist(x)
boxplot(x)

library(gcookbook) # For the data set
csub <- subset(climate, Source=="Berkeley" & Year >= 1900)
csub$pos <- csub$Anomaly10y >= 0
csub
ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) +
  geom_bar(stat="identity", position="identity")

ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity", width=0.5)


library(gcookbook) # For the data set
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity")

library(plyr)
tg <- ddply(ToothGrowth, c("supp", "dose"), summarise, length=mean(len))
ggplot(tg, aes(x=dose, y=length, colour=supp)) + geom_line()
ggplot(tg, aes(x=dose, y=length, linetype=supp)) + geom_line()


library(ggplot2)
library(gganimate)
theme_set(theme_bw())
library(gapminder)
p <- ggplot(
  gapminder, 
  aes(x = gdpPercap, y=lifeExp, size = pop, colour = country)
) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")
p

p + transition_time(year) +
  labs(title = "Year: {frame_time}")

p + transition_time(year) +
  labs(title = "Year: {frame_time}") +
  shadow_mark(alpha = 0.3, size = 0.5)


############
sample(1:50,10,replace = F)
sample(c("A","B","C"),1)

sample(c("succ", "fail"), 10, replace=T, prob=c(0.1, 0.9))
### bootstrap resampling 
sample(1:5,5,replace = T)

####
prod(5:4)
prod(1:20)

40*39*38*37*36
prod(c(3,2,1))
#####
x <- seq(-4,4,0.1)
plot(x,dnorm(x),type="l") ## line 

dnorm(0) # pdf
pnorm(0) ## CDF
pnorm(1.96) ## confidence intervals 
rbinom(10,size = 2,prob = 0.5)
#####






