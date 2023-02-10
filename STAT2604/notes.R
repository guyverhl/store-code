addFunc = function(x,y) {
  x + y
}

addFunc(2,3)

## source a file 
# source()

## Doc all scripts to local
# sink()
# closeAllConnections()

# Func for creating vector
firstVec = c(1,3,2)
# c("andy", "mike")

# Sorting
sort(firstVec, decreasing = T)

# Order
order(firstVec)

# 1-10
secVec = 1:10

# sequence
seqVec =seq(1, 10, 2)

# Repeat
repVec = rep(c(2,3),5)
# Combined
c(rep(1,5), rep(2,5))

# Check any N/A
is.na(firstVec)
# 0 = false, 1 = true
sum(is.na(firstVec))

# combine string
paste("Hello", "World", sep='-')
paste0("Hello", "World", sep='-')

# Show
cat("Hello World", "User")

# exclude NA
x = c(1, 2, NA)
x[c(T, T, F)]
x[!is.na(c(1, 2, NA))]

# Give Name
fruit = c(5, 10, 1, 20)
names(fruit) = c('apple', 'banana', 'grapes', 'tree')

# Change as factor
gender = as.factor(c("m", "f"))

# Matrix (func)
matrix(c(1,2,3,4), ncol=2)
matrix(c(1,2,3,4), ncol=2, byrow=TRUE)

A = matrix(rep(3,4), ncol=2)
B = matrix(rep(2,4), ncol=2)

A * B
A %*% B

