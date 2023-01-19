##### Data Structures (cont'd) and Functions #####
##### 1/19/23
##### EBW

#### Matrices and Data Frames (cont'd) ####

### Matrices

m <- matrix(data = 1:12, nrow = 3) #3 rows, data is 1:12

## Subsetting based on elements
m[1:2, ] #first 2 rows
m[, 2:4] #columns 2-4

## Subsetting with logical (conditional) statements

# Select all columns for which totals are > 15
colSums(m) #gives us the sum for each column
colSums(m) > 15 #gives us logical statement based on columns w/ sums > 15
m[,colSums(m)>15] #subsets based on that conditional statement

# Select all rows with sum = 22
m[rowSums(m)==22,] #grabs all rows whose sum = 22
# What about rows that DONT equal 22?
m[!rowSums(m)==22,] #grabs all rows whose sum != 22

## Logical operators:
# == : equals
# != : does not equal
# >  : greater than
# <  : less than

## Subsetting to a vector changes the data type
z <- m[1,] #1-dimensional, so now it's a vector
class(z) #integer
z2 <- m[1, , drop=FALSE] #forces subsetting to stay a matrix
class(z2) #matrix, array

## Simulate a new matrix
m2 <- matrix(data = runif(9), nrow = 3) #square matrix w/ 9 random numbers (3x3)
m2[3,2] #3rd row, 2nd column

## Use assignment operator to substitute values
m2[m2 > 0.6] #grabs all the values (by index) > 0.6
m2[m2 > 0.6] <- NA #assigns NA to all values > 0.6

### Data Frames

data(iris)
head(iris) #first 6 rows
tail(iris) #last 6 rows

# Subset data
iris[3,2] # numbered indices still work
dataSub <- iris[,c("Species","Petal.Length")] # specify based on column names

## Sort a data frame by values
order(iris$Petal.Length) #row indices in order of Petal.Length
orderedIris <- iris[order(iris$Petal.Length),] #orders the rows by Petal.Length
head(orderedIris)








#### Functions in R ####

## Everything in R is a function

sum(3,2) #sum() is a function
3+2 # + is a function too! (operators are functions)
sd #run just the function name to see the code for the function

## User-Defined Functions:
# We can create our very own functions
# Anatomy of a function:
# 
# functionName <- function(argX = defaultX, argY = defaultY) {
#   ## Curly bracket starts the body of the function
#   
#   ## Lines of code and notes
#   ## Can also create local variables (variables that are only defined in the function)
#   # i.e. x <- 1
#   
#   ## return(z) #what the function will return/define (different from print)
# }

# Let's make our own function!
myFunc <- function(a=3, b=4) {
  ## Function that sums 2 values
  # Arguments:
  #   a: default value of 3
  #   b: default value of 4
  # Returns: sum of a and b
  
  z <- a + b
  return(z)
}
myFunc() #runs defaults
myFunc(a=100,b=3.4) #defines our own values
print(z) #z wasn't globally defined so it doesn't exist
z <- myFunc() #now we've defined z
print(z) #now it works :)

# Let's make a bad function :(
myFuncBad <- function(a=3) {
  ## Function that sums 2 values
  # Arguments:
  #   a: default value of 3
  # Returns: sum of a and b
  
  z <- a + b # this will give an error
  return(z)
}
myFuncBad() #returns error (b wasn't defined)
b <- 50 #if we define b globally, the function will work but that's BAD coding practice
myFuncBad()

## We can have multiple return statements

##########################################
# FUNCTION: HardyWeinberg
# input: a dominant allele frequency p (0,1)
# output: p and the frequencies of 3 genotypes: AA, AB, BB
#----------------------------------------
HardyWeinberg <- function(p = runif(1)){
  
  if(p > 1.0 | p < 0.0){
    return("Function failure: p must be between 0 and 1")
  }
  
  q <- 1-p #recessive allele
  fAA <- p^2 #frequency of AA
  fAB <- 2*p*q #frequency of AB
  fBB <- q^2 #frequency of BB
  vecOut <- signif(c(p=p, A=fAA, AB = fAB, BB = fAB), digits = 3) #vector with all values rounded to 3 significant digits
  
  return(vecOut)
}
##########################################

HardyWeinberg() #runs the default
freqs <- HardyWeinberg()
HardyWeinberg(p=3) #returns failure message

## Create a complex default value

##########################################
# FUNCTION: fitLinear2
# fits a simple regression line
# inputs: list (p) of predictor (x) and response (y)
# outputs: slope and p-value
#-----------------------------------------
fitLinear2 <- function(p=NULL){
  #if no arguments, create a list of random values
  if(is.null(p)){
    p <- list(x=runif(20),y=runif(20))
    } 
  
  myMod <- lm(p$x~p$y) #fit a linear model to output y based on input x
  myOut <- c(slope = summary(myMod)$coefficients[2,1],
             pValue = summary(myMod)$coefficients[2,4]) #create a vector with the p-value and slope of the model
  plot(x=p$x,y=p$y) #plots a quick scatter plot
  return(myOut) #returns the slope and p-value
}

fitLinear2() #runs default random uniform values
myPars <- list(x=1:10,y=runif(10))
fitLinear2(myPars)


