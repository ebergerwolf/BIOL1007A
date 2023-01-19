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





