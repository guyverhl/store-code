# Tutorial 03
# R Basics: Debugging, Data IO and Plotting Basics

#-------------------------------------------------------------------
# Debugging
# Example: previous tutorial exercise
n <- 0
y <- 1
while (y < 100) {
  y <- n * y
  n <- n + 1
}
n

# 1. Left click the blank space to the left of line number to set red breakpoint(s)
# 2. use Source (instead of Run)
# 3. F10 to run line by line or Shift+F4 to step into a function
# 4. Shift+F8 to exit the debug mode



#-------------------------------------------------------------------
# Data IO
# Read tabular data (either from local files or urls)

# file path specifying
file = "demo.txt" # from local working directory
file = "D:/Software/R-3.6.2/demo.txt"
file = "D:\\Software\\R-3.6.2\\demo.txt"
file = "http://www.sthda.com/upload/boxplot_format.txt"
file = file.choose() # choose in a pop-up window


# General function
read.table(file, header = FALSE, sep = "", dec = ".")

# For different separators and decimal signs
read.csv(file, header = TRUE, sep = ",", dec = ".")
read.csv2(file, header = TRUE, sep = ";", dec = ",")
read.delim(file, header = TRUE, sep = "\t", dec = ".")
read.delim2(file, header = TRUE, sep = "\t", dec = ",")

# Careful with the header!


#----------------------------------
# Read large dataset using package "readr"
install.packages("readr")
library(readr)

# General function reading data file using different delimiter
read_delim(file, delim)

# For different delimiter
read_csv(file) # comma separated
read_csv2(file) # semicolon separated
read_tsv(file) # tab separated

# Read n_max lines
read_lines(file, n_max)


#----------------------------------
# Read Excel files using package "xlsx"
install.packages("xlsx")
library(xlsx)
read.xlsx(file, sheet)


#----------------------------------
# Load R built-in datasets
data() # check all available datasets
data(iris) # load a specific dataset


#----------------------------------
# Read R files
# Read a single R object
readRDS("xxx.rds")

# Read multiple R objects/workspace
load("xxx.RData")


#----------------------------------
# Read images using package "magick"
install.packages("magick")
library(magick)
image_read(path) # General function
image_read_svg(path) # for svg
image_read_pdf(path) # for pdf


#-------------------------------------------------------------------
# Write data to local files

# Built-in general function
write.table(data, path, sep)


# General function in package "readr"
# set appand=T to write line by line
write_delim(data, path, delim, appand)


# Write Excel files by package "xlsx"
write.xlsx(data, path)


#----------------------------------
# Save R files
# Save a single R object to a file
saveRDS(obj, "xxx.rds")

# Save multiple R objects to a file
saveRDS(obj1, obj2, "xxx.RData")

# Save workspace
save.image("xxx.RData")


#----------------------------------
# Save images
image_write(img, path, format)


#----------------------------------
# Exercise
# Write the iris data in txt and csv files, then read them back into R-studio











write.table(iris, "demo.txt")
write.csv(iris, "demo.csv", row.names = F)
write.xlsx(iris, "demo.xlsx", row.names = F)

read.table("demo.txt")
read.csv("demo.csv")
read.xlsx("demo.xlsx", sheetIndex = 1)



#-------------------------------------------------------------------
# Plotting Basics
# The built-in plotting function 'plot':
plot(x, y, type, col, pch, lty, main, sub, xlab, ylab)

# col: color
# pch: point character
# lty: line style
# other arguments: (refer to ?plot -> Generic X-Y Plotting)


#----------------------------------
# Scatter plots
plot(iris$Sepal.Length, iris$Sepal.Width)

# plot new points on the current plot
points(iris$Sepal.Length, iris$Petal.Length, col = 'red')


#----------------------------------
# Line plots
plot(x, y, type = "l")
plot(pressure$temperature, pressure$pressure, type = "l")

# plot new line(s) on the current plot
lines(pressure$temperature, pressure$pressure/2, col = "red")

# plot a straight line to the current plot
abline(a, b, h, v)
abline(h = 0, col = 'blue')

#----------------------------------
# Bar plots
barplot(height)
barplot(table(iris$Sepal.Length))
barplot(matrix(c(1,4,5,1),2,2)) # stacked
barplot(GNP ~ Year, data = longley) # expression


#----------------------------------
# Histograms
hist(x)
hist(iris$Sepal.Length)


#----------------------------------
# Boxplots
boxplot(x)
boxplot(iris$Sepal.Length)

# boxplot by groups in factor variable
boxplot(x ~ factor)
boxplot(Sepal.Length ~ Species, data = iris)


#----------------------------------
# Function plots
curve(fun(x), from, to)
curve(x^3 - 5*x, from = -4, to = 4)


#----------------------------------
# Multiple plots per figure
par(mfrow=c(rows,cols)) # plot row-by-row
# plot()
# plot()
# ...

# or

par(mfcol=c(rows,cols)) # plot column-by-column
# plot()
# plot()
# ...


#----------------------------------
# Layout
attach(mtcars)
layout(matrix(c(1,1,2,0,3,4), 3, 2))
# layout(matrix(c(1,1,2,0,3,4), 3, 2, byrow = TRUE))

hist(wt)
hist(mpg)
hist(disp)
hist(carb)
detach(mtcars)


#----------------------------------
# Other functions
title(main)
legend(x, y, legend)
text(x, y) # draws the strings at the coordinates given by x and y
grid(nx, ny) # adds an nx by ny rectangular grid to an existing plot.
