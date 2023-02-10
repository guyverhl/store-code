# Tutorial 02
# R Basics: Functions Defining and Control Statements


#-------------------------------------------------------------------
# Build-in functions: c(), help(), print(), ...

# A self-defined function contains:
#   function name
#   arguments (optional)
#     assign by order
#     use default assignment
#     assign multiple values
#   function body

# function with no arguments
myfun1 <- function(){
  print("Hello World!")
}
myfun1()
myfun1 # wrong!


# function with one argument
myfun2 <- function(something){
  print(something)
}
myfun2() # wrong!
myfun2("Hello World!")
myfun2(something = "Hello World!") # <argument name> = <value>

myfun2(" ")
myfun2( ) # wrong! spaces are ignored


# argument with default value
myfun3 <- function(something="Hello World!"){
  print(something)
}
myfun3()
myfun3("something else")


# passing two or more arguments to a function by ...
myfun4 <- function(...){
  c(...)**2 # equivalent to c(...)^2
}
myfun4(1,2,3)

myfun5 <- function(...){
  print(...) # wrong!
  cat(...) # correct
}
myfun5(1,2,3)


# confliction
c <- function(x){
  x + 1
}
c(1)
c(1,2,3) # wrong!
base::c(1,2,3) # correct

#-------------------------------------------------------------------
# Exercises: what is the output below?
product_of <- function(num1, num2=2, num3=3){
  num1*num2*num3
}
product_of(1,1)








# Answer: same as `product_of(1, num2=1)`

# What about
product_of <- function(num1, num2=2, num3){
  num1*num2*num3
}
product_of(1,1)
product_of(num1 = 1, num3 = 1)

# assign values to the arguments in the same order as the function defined!



#-------------------------------------------------------------------
# Scope: environment where variables are accessible

num3 # error! the scope of `num3` is within the function
num3 <- Inf; # now the scope of variable `num3` is the current workspace
num3

product_of(1) # wrong!
product_of(num1=1, num2=2, num3=) # equivalence

# variables (even with the same variable name) inside
#   different environments are not identical!


# solution 1:
product_of(1, num3 = num3)

# solution 2:
new.product_of <- function(num1, num2=2){
  num1*num2*num3
}
new.product_of(1)
# R searches variable from the environment inside to the one outside



#-------------------------------------------------------------------
# Control Statements

#----------------------------------
# if-else

# if (<condition1>) {
#   <do something>
# } else if (<condition2>) {
#   <do something else>
# } else if (<condition3>) {
#   <do something else>
# }
#
# ...
#
# } else {
#   <do something else>
# }


check.data_type <- function(something) {
  if (is.numeric(something)) {
    cat(something, "is a numeric data.\n")
  } else if (is.character(something)) {
    cat(something, "is a character data.\n")
  } else {
    cat("Unrecognized data type.\n")
  }
}
check.data_type(123)
check.data_type("123")
check.data_type(TRUE)


check.is_inside <- function(x, vec) {
  if (x %in% vec) {
    cat(x, "found in", as.character(vec))
  } else {
    cat("Cannot find", x, "in", as.character(vec))
  }
}
check.is_inside("ds", list(1L, "ds"))


# shorten version
abs1 <- function(x) {
  if (x >= 0) {
    return(x)
  } else {
    return(-x)
  }
}

abs2 <- function(x) {
  y <- if (x >= 0) {
    x
  } else {
    -x
  }

  return(y)
}

abs3 <- function(x) {
  ifelse(x >= 0, x, -x)
}



#----------------------------------
# for loops

# for (<variable> in <a data structure>) {
#   <do something>
# }

sum <- 0
for (i in 1:10) {
  sum <- sum + i
}
sum


x <- list(1, "a", TRUE, 1+4i)
for (i in x) {
  print(i)
}


M <- matrix(c(1:4), nrow = 2, ncol = 2)
M
for (i in M) {
  print(i)
}


dat <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
dat
for (i in dat) {
  print(i)
}

# equivalance
for (i in 1:ncol(dat)) {
  print(dat[,i])
}

#----------------------------------
# while loops

# while (<condition>) {
#   <do something>
# }

# Calculate the smallest n such that n! >= 100
n <- 1
y <- 1
while (y < 100) {
  y <- n * y
  n <- n + 1
}
n


#-------------------------------------------------------------------
# Exercise: what if we start n from 0?

n <- 0
y <- 1
while (y < 100) {
  y <- n * y
  n <- n + 1
}
n