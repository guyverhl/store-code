STAT 2604 Lecture 4
========================================================
author: 
date: 
autosize: true

Random sampling
========================================================

```r
sample(1:40,5)
```

```
[1] 16 36  9 19 10
```

```r
sample(c("H","T"), 10, replace=T)
```

```
 [1] "T" "H" "T" "H" "H" "T" "H" "T" "H" "T"
```

```r
sample(c("succ", "fail"), 10, replace=T, prob=c(0.9, 0.1))
```

```
 [1] "succ" "succ" "succ" "succ" "succ" "fail" "succ" "fail" "succ" "succ"
```

Probability calculations and combinatorics
========================================================

```r
1/prod(40:36)
```

```
[1] 1.266449e-08
```

```r
prod(5:1)/prod(40:36)
```

```
[1] 1.519738e-06
```

```r
1/choose(40,5)
```

```
[1] 1.519738e-06
```


Probability Distributions in R
========================================================


```r
x <- seq(-4,4,0.1)
plot(x,dnorm(x),type="l")
```

![plot of chunk unnamed-chunk-3](Lecture4-figure/unnamed-chunk-3-1.png)

```r
#curve(dnorm(x), from=-4, to=4)
```

Probability Distributions
========================================================


```r
x <- 0:50
plot(x,dbinom(x,size=50,prob=.33),type="h")
```

![plot of chunk unnamed-chunk-4](Lecture4-figure/unnamed-chunk-4-1.png)

Cumulative  Distribution Function
========================================================

```r
1-pnorm(160,mean=132,sd=13)
```

```
[1] 0.01562612
```

```r
pbinom(16,size=20,prob=.5)
```

```
[1] 0.9987116
```

```r
1-pbinom(15,size=20,prob=.5)
```

```
[1] 0.005908966
```

```r
1-pbinom(15,20,.5)+pbinom(4,20,.5)
```

```
[1] 0.01181793
```


Confidence intervals
========================================================

```r
 xbar <- 83
 sigma <- 12
 n <- 5
 sem <- sigma/sqrt(n)
 xbar + sem * qnorm(0.025)
```

```
[1] 72.48173
```

```r
 xbar + sem * qnorm(0.975)
```

```
[1] 93.51827
```

Random numbers
========================================================

```r
 rnorm(10)
```

```
 [1]  1.4856254 -0.1510210  1.7062998  1.2770871  0.2111603 -1.0864857
 [7] -0.9446752  1.1755238  1.6462447 -0.4987080
```

```r
 rbinom(10,size=20,prob=.5)
```

```
 [1] 10 10 15  8 11  9  8  9 11  9
```


Random normal mixtures
========================================================

```r
require(ggplot2)
sampa=rnorm(1000000,0,1)
sampb=rnorm(1500000,3,1)
combined = c(sampa, sampb)
plt = ggplot(data.frame(combined), aes(x=combined)) + stat_bin(binwidth=0.25, position="identity")
plt
```


Random normal mixtures
========================================================

```r
pop1=rnorm(2000000)
pop2=rnorm(1000000, 1, 2)
combined = c(pop1, pop2)
plt= ggplot(data.frame(data=c(combined, pop1, pop2), labels=rep(c("combined", "pop1", "pop2"), c(3e6, 2e6, 1e6))), aes(x=data)) + stat_bin(aes(fill=labels), position="identity", binwidth=0.25, alpha=0.5) + theme_bw()
plt
```


Monte Carlo Integration
========================================================
Compute the integral $\int_0^1 (cos(50x) + sin(20x))^2dx$

```r
g <- function(x){
  (cos(50*x) + sin(20*x))^2
}
integrate(g, 0, 1)
```

```
0.9652009 with absolute error < 1.9e-10
```

```r
n.sam <- 1000
x.sam <- runif(n.sam)
theta.mc <- sum(sapply(x.sam, g))/n.sam
print(theta.mc)
```

```
[1] 0.982941
```


Monte Carlo Integration 
========================================================
Compute the area of  $A:\{(x,y), x^2+y^2 <1\}$.

```r
x.sam <- runif(10000, min = -1, max = 1)
y.sam <- runif(10000, min = -1, max = 1)
joint.sam <- cbind(x.sam, y.sam)
g.indA <- function(point){
  if ((point[1]^2 + point[2]^2) <= 1) return (1.0)
  else return(0)
}
theta.mc <- sum(apply(joint.sam, 1, g.indA))/nrow(joint.sam)
4*theta.mc
```

```
[1] 3.164
```


Visualize it 
========================================================

```r
joint.data <- data.frame(joint.sam)
colnames(joint.data) <- c("x", "y")
# create a factor variable to see which were accepted
joint.data$Accepted <- (joint.data$x^2 + joint.data$y^2 < 1)
library(ggplot2)
plot_ar <- ggplot(joint.data, aes(x=x, y=y)) + 
  geom_point(shape=20, aes(color=Accepted)) +
  stat_function(fun = function(x) sqrt(1-x^2), size=1.5) + 
  stat_function(fun = function(x) -1*sqrt(1-x^2), size=1.5) +
  coord_fixed()
```

Visualize it 
========================================================

```r
# beautify : Increase font size in axes 
plot_ar + theme(axis.text.x = 
                 element_text(face = "bold",size = 12),
               axis.text.y = 
                 element_text(face = "bold", size = 12),
               axis.line = element_line(colour = "black", 
                      size = 1, linetype = "solid"))
```



Summary statistics for a single group
========================================================

```r
x <- rnorm(50)
 mean(x)
```

```
[1] -0.09159968
```

```r
 sd(x)
```

```
[1] 0.9203176
```

```r
 var(x)
```

```
[1] 0.8469844
```

```r
median(x)
```

```
[1] 0.0566774
```

```r
quantile(x)
```

```
        0%        25%        50%        75%       100% 
-2.3357926 -0.6636374  0.0566774  0.5017530  1.4912526 
```

Summary statistics for a single group
========================================================

```r
x = c(seq(1:10),NA)
mean(x)
mean(x,na.rm=T)
```


Summary statistics for a single group
========================================================

```r
x = c(seq(1:10),NA)
mean(x)
```

```
[1] NA
```

```r
mean(x,na.rm=T)
```

```
[1] 5.5
```

```r
sum(!is.na(x))
```

```
[1] 10
```

```r
summary(x)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   1.00    3.25    5.50    5.50    7.75   10.00       1 
```

Empirical CDF
========================================================

```r
x = rnorm(100)
n <- length(x)
plot(sort(x),(1:n)/n,type="s",ylim=c(0,1))
```

QQ plot
========================================================

```r
qqnorm(x)
```

tapply 
========================================================

```r
data(iris)  # Load the dataset iris
mean(iris$Sepal.Length)
```

```
[1] 5.843333
```

```r
tapply(iris$Sepal.Length, iris$Species, mean)
```

```
    setosa versicolor  virginica 
     5.006      5.936      6.588 
```

Tables
========================================================

```r
caff.marital <- matrix(c(652,1537,598,242,36,46,38,21,218 ,327,106,67), nrow=3,byrow=T)
colnames(caff.marital) <- c("0","1-150","151-300",">300")
rownames(caff.marital) <- c("Married","Prev.married","Single")
caff.marital
```

```
               0 1-150 151-300 >300
Married      652  1537     598  242
Prev.married  36    46      38   21
Single       218   327     106   67
```

```r
names(dimnames(caff.marital)) <- c("marital","consumption")
caff.marital
```

```
              consumption
marital          0 1-150 151-300 >300
  Married      652  1537     598  242
  Prev.married  36    46      38   21
  Single       218   327     106   67
```

```r
as.data.frame(as.table(caff.marital))
```

```
        marital consumption Freq
1       Married           0  652
2  Prev.married           0   36
3        Single           0  218
4       Married       1-150 1537
5  Prev.married       1-150   46
6        Single       1-150  327
7       Married     151-300  598
8  Prev.married     151-300   38
9        Single     151-300  106
10      Married        >300  242
11 Prev.married        >300   21
12       Single        >300   67
```

Convert to data frame
========================================================

```r
as.data.frame(as.table(caff.marital))
```

```
        marital consumption Freq
1       Married           0  652
2  Prev.married           0   36
3        Single           0  218
4       Married       1-150 1537
5  Prev.married       1-150   46
6        Single       1-150  327
7       Married     151-300  598
8  Prev.married     151-300   38
9        Single     151-300  106
10      Married        >300  242
11 Prev.married        >300   21
12       Single        >300   67
```

```r
total.caff <- margin.table(caff.marital,2)
barplot(total.caff, col="white")
```

![plot of chunk unnamed-chunk-21](Lecture4-figure/unnamed-chunk-21-1.png)

Boxplot
========================================================

```r
total.caff <- margin.table(caff.marital,2)
barplot(total.caff, col="white")
```

![plot of chunk unnamed-chunk-22](Lecture4-figure/unnamed-chunk-22-1.png)


Boxplot
========================================================

```r
par(mfrow=c(2,2))
barplot(caff.marital, col="white")
barplot(t(caff.marital), col="white")
barplot(t(caff.marital), col="white", beside=T)
barplot(prop.table(t(caff.marital),2), col="white", beside=T)
```

![plot of chunk unnamed-chunk-23](Lecture4-figure/unnamed-chunk-23-1.png)

Dotchart
========================================================

```r
dotchart(t(caff.marital), lcolor="black")
```

![plot of chunk unnamed-chunk-24](Lecture4-figure/unnamed-chunk-24-1.png)


Pie chart
========================================================

```r
 opar <- par(mfrow=c(2,2),mex=0.8, mar=c(1,1,2,1))
 slices <- c("white","grey80","grey50","black")
 pie(caff.marital["Married",], main="Married", col=slices)
 pie(caff.marital["Prev.married",], main="Previously married", col=slices)
 pie(caff.marital["Single",], main="Single", col=slices)
 par(opar)
```

![plot of chunk unnamed-chunk-25](Lecture4-figure/unnamed-chunk-25-1.png)
