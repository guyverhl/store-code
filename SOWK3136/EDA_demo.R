library(ISwR)

# 1. An overgrown calculator
# An addition
5 + 5 

# A subtraction
5 - 5 

# A multiplication
3 * 5

# A division
(5 + 5) / 2 

# Exponentiation
2^5

# Modulo
28%%6

# 2. Assignments
# You often need some way to store intermediate results, so that you don't have to key them in over and over again.
# R has sympbolic variables that it names can be used to represent values. 
# Assign value 2 to x
x <- 2  #"<-" is the assignment operator

x + x

# Names of variables can be chosen quite freely in R.
# They can be built from letter, digit, and dot symbol
# Limitations: Must no start with a digit or a period 
# Names are case-sensitive

my.height <- 170

my.weight <- "secret"

my.weight.known <- FALSE 

# Check class of my_numeric
class(my.height )

# Check class of my_character
class(my.weight)

# Check class of my_logical
class(my.weight.known)

# 3. Vectorized arithmetic
weight <- c(60, 72, 57, 90, 95, 72)
weight

height <- c(1.75, 1.80, 1.65, 1.90, 1.74, 1.91)
height

bmi <- weight/height^2
bmi

sum(weight)

sum(weight)/length(weight)

xbar <- sum(weight)/length(weight)

sqrt(sum((weight - xbar)^2)/(length(weight)-1))

mean(weight)

sd(weight)

# 4. Graphic
plot(height, weight)

plot(height,weight, pch = 2)

# If a normal BMI should be about 22.5, you should expect that a healthy weight ~ 22.5 * height^2

hh <- c(1.65, 1.70, 1.75, 1.80, 1.85, 1.90)

hh <- seq(1.65, 1.90, 0.05)

lines(hh, 22.5*hh^2)


# 5. An example

# Import data
library(readr)
marvel_wikia_data <- read_csv("C:/Users/haoluo/Dropbox/AA1. Teaching/A.Teaching 2021-2022 Autumn/SOWK3136/Lecture 2 EDA/marvel-wikia-data.csv")

comics <- marvel_wikia_data

# Print the first rows of the data
comics

View(comics)

unique(comics$ALIGN)

unique(comics$ID)

# Create a 2-way contingency table
table(comics$ID, comics$ALIGN)

library(ggplot2)

ggplot(comics, aes(x = ID, fill = ALIGN)) +
  geom_bar()

comics$align <- factor(comics$ALIGN)


# Count vs. proportions
tab_cnt <- table(comics$ID, comics$ALIGN)
tab_cnt

prop.table(tab_cnt)

sum(prop.table(tab_cnt))

# Conditional proportions
prop.table(tab_cnt, 1) # Conditional on row
prop.table(tab_cnt, 2) # Conditional on column

ggplot(comics, aes(x = ID, fill = ALIGN)) +
  geom_bar(position = "fill") +
  ylab("proportion")

# Distribution of one variable
table(comics$ID)

ggplot(comics, aes(x = ID)) + 
  geom_bar()

# Faceting (breaks the data into subsets)
ggplot(comics, aes(x = ID)) + 
  geom_bar() + 
  facet_wrap(~ALIGN)


# Exploring numerical data
# The mtcars dataset is natively available
head(mtcars)
str(mtcars)

ggplot(mtcars, aes(x=wt)) + 
  geom_histogram() 

ggplot(mtcars, aes(x=wt)) + 
  geom_density() 

# A really basic boxplot.
ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot(fill="slateblue", alpha=0.2) + 
  xlab("cyl")

# Bottom Right
ggplot(mpg, aes(x=class, y=hwy, fill=class)) + 
  geom_boxplot(alpha=0.3) +
  theme(legend.position="none") +
  scale_fill_brewer(palette="Dark2")


# L3 Simple data summary - One dimension
data()

View(airquality)

?airquality

names(airquality)

summary(airquality$Ozone)

boxplot(airquality$Ozone)

boxplot(airquality$Ozone, col = "blue")

abline(h=70, col = "red")

hist(airquality$Ozone, col = "green")

rug(airquality$Ozone)

hist(airquality$Ozone, col = "green", breaks = 30)

abline(v = 70, col = "red")

## Dont remove missing value
abline(v = median(airquality$Ozone), lwd = 3)

abline(v = median(airquality$Ozone, na.rm = T), lwd = 3)

unique(airquality$Month)

barplot(table(airquality$Month))

# Two or more dimension
boxplot(Ozone ~ Month, data = airquality, col = "blue")

par(mfrow = c(1,2), mar = c(4,4,2,1))
  hist(subset(airquality, Month == 5)$Ozone, col = "blue", 
       xlim = c(0,150), ylim = c(0,15))
  hist(subset(airquality, Month == 8)$Ozone, col = "red",
       xlim = c(0,150), ylim = c(0,15))

## Same scale
par(mfrow = c(1,2), mar = c(4,4,2,1))
  with(subset(airquality, Month == 5), plot(Temp, Ozone, main = "May"))
  with(subset(airquality, Month == 8), plot(Temp, Ozone, main = "August"))

with(airquality, plot(Temp, Ozone, col = Month))
  abline(h=70, lwd = 1, lty = 2)
  
#The base plotting system
dev.off() # Reset to default par() settings
data(cars)
with(cars, plot(speed, dist))

# The Lattice system  
library(lattice)

data() ## Check dataset chunk
state = data.frame(state.x77, region = state.region)

xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

## The ggplots system
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)



