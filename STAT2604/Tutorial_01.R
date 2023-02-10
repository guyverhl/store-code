# Tutorial 01
# R Basics: Introduction, Data Types and Data Structure

#-------------------------------------------------------------------
# Tutorial time: Wed 11:30-12:20 (Session 1), Thu 17:30-18:20 (Session 2)
# Venue: RR101 for both session
# Tutor: Mr. Xu Yuyuang (Session 1), Mr. Yao Minhao (Session 2)

#-------------------------------------------------------------------
# R and RStudio:
# R: a programming language (download: https://cran.r-project.org)
# RStudio: a popular IDE (Integrated Development Environment) for R language
#   (download: https://rstudio.com)
# R.exe: a command line software that is used to run R in the old days (rarely use now)

#-------------------------------------------------------------------
# R scripts and console:
# 1. Both can run codes
# 2. In R scripts, it's easier to write multiple lines code and easy to save them a file
#   press Ctrl + Enter to run
#   select to run multiple lines
#   R script is essentially a text file with ".R" filename extension
# 3. Console is normally used for getting help, functional testing and viewing output
#   press Enter to run
#   use Shift+Enter to write multiple lines code in the console

#-------------------------------------------------------------------
# R management
# Install R packages:
# 1. install.packages("<package name>")
# 2. Use the Packages tab in the bottom right pane

# Load R packages: (careful! vs install R packages)
# library(<package name>)

# Update R packages:
# Upper Menu -> Tools -> Check for Package Updates

# Upgrade R:
install.packages("installr")
library(installr)
updateR()

# Customizing options:
# Upper Menu -> Tools -> Global Options
#   R version
#   workspace
#   working directory: IO
#   completion: Tab
#   appearance

#-------------------------------------------------------------------
# Comment: "#"
# shortcut: Ctrl + Shift + C

#-------------------------------------------------------------------
# Getting help:
# When you do know the function (or in general, the object) name and want to know how to use it
help(c)
?":"

# When you don't know the function name
# 1. use "??"
??combine
# 2. Google!!

#-------------------------------------------------------------------
# Check command history:
# 1. Through shortcuts in the console
#   look back one by one: Up or Down
#   look for the whole history and choose from it: Ctrl + Up or Down
#   look for command starting with specific characters:
#     type the characters and press Ctrl + Up or Down

# 2. Use the History tab in the upper right pane

#-------------------------------------------------------------------
# Other programming basics in R:

# Multiple spaces and blank lines are auto-ignored
# 	(used to prettified codes)

# Be careful with halfwidth/fullwidth characters:
#   comma: "," vs "，"
#   colon: ":" vs "："
#   single quote: "'" vs "’"
#   double quote: """ vs "“"

# Variable naming:
# 	case sensitive
#	  must start with "." or letter
#	  followed by any alphanumeric character or "_", "."
#   careful with built-in names/keywords
pi
pi <- 5
pi

c <- 10
c(c, 11)

# Auto print vs the functions `print()` and `cat()`
# auto print
a <- 1
a
# the `print` function
print(a)
print(1)
# the `cat` function
cat(a)
cat(1)
cat("The value of the variable `a` is: \n", a)

# Variable assignment:
a <- 1
b = 2

a = b
b = a

a <- b
b <- a

# *Argument assignment
sum(5, 15, NaN, na.rm = TRUE)
sum(5, 15, NaN, na.rm <- TRUE)

# show objects in the workspace
a <- 1
b <- "bee"
c <- b
ls()

# remove specific variable(s) from the current environment
rm(a)
rm(b, c)
# remove all variables: click "broom" icon under the Environment tab in the top right pane


#-------------------------------------------------------------------
#-------------------------------------------------------------------
# 5 basic data types

# character (string): ('' vs "")
"a"
"hello world!"

# numeric (real number):
2
15.5

# integer (the L tells R to store this as an integer):
1L # UPPER case L

# logical: (TRUE/FALSE or simply T/F)
T
FALSE # all UPPER case
1 > 5
1 == 1L

# complex:
1 + 1i # small case i

# Coerce:
as.integer(b) # change data type to integer
as.complex(b) # change data type to complex

# Order of coerce
# character <- complex <- numeric <- integer <- logical
as.integer(1.1)
as.logical(2)

# special values (case sensitive)
pi
Inf
NaN
	0/0
	is.nan(NaN)
	NaN == NaN
NA
	is.nan(NA)
	is.na(NaN)

# find the data type
typeof(Inf)
typeof(NaN)
typeof(NA)


# Exercise
as.logical(Inf)
as.logical(NaN)
as.logical(NA)
as.integer(Inf)
as.integer(NaN)
as.integer(NA)
as.character(Inf)
as.character(NaN)
as.character(NA)



#-------------------------------------------------------------------
# Data structure
# index start from 1 (vs python)

# (atomic) vector: can only contain objects of the SAME type
x <- c(1,4,5,6)
x <- numeric(3) # create empty numeric vector
x <- character(5) # create empty character vector
x <- 1:10
x <- 2*1:10
x <- 30:1
x <- seq(from = 1, to = 10, by = 0.1)
x <- rep(x, times=5)
x <- rep(x, each=5)
x <- c("a", NA, "c", "d", NA) # not applicable
x <- c(3, 1/0, NA, 2, 0/0)
x <- c(1:5,6:10)

#-------------------------------------------------------------------
# list: can contain elements of different types
x <- list(1, "a", TRUE, 1 + 4i)
x <- as.list(1:10)

# indexing
# use [] indead of () when indexing
x <- 1:10
x[1:10]
x[c(1,10)]
x[-2] # remove the second one
x[10:1] # reversing
# boolean indexing
x[rep(c(T,F),times=5)]
x[c(T,F)]


length(x)
sort(x)
head(x) # for the first six observations
# head(x,n)
tail(x) # for the last six observations
# tail(x,n)

#--------------------------------
# matrix: can contain elements of different types
M <- matrix(nrow = 2, ncol = 2) # empty matrix
M <- matrix(c(1:4), nrow = 2, ncol = 2)
colnames(M) <- c('a', 'b')
M + M
M - M
M * M # elemet-wise product
M / M # elemet-wise divsion
M %*% M # matrix multiplication

# indexing
M[c(1,3),] # first and third rows
M[,-2] # all columns except the second
M[,"a"]

t(M) # transpose
solve(M) # inverse
eigen(M)
cbind(M,M)
rbind(M,M)
det(M) # determinant
diag(M) # diagonal
dim(M)
nrow(M)
ncol(M)

#--------------------------------
# data frame: elements within each column must be of the same type
dat <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
dat$id
dat[,1]
dat[2,]

head(dat) # shows first 6 rows
tail(dat) # shows last 6 rows
dim(dat) # returns the dimensions of data frame (i.e. number of rows and number of columns)
nrow(dat)
ncol(dat)
str(dat) # structure of data frame - name, type and preview of data in each column
names(dat) # or colnames() # both show the names attribute for a data frame
sapply(dat, typeof) # shows the type of each column in the data frame

#--------------------------------
# factors: categorical data
data <- c("East", "West", "East", "North", "North", "East", "West", "West", "West", "East", "North")
factor_data <- factor(data)
levels(factor_data)
nlevels(factor_data)
