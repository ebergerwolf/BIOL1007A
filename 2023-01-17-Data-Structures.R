###### Vectors, Matrices, Data Frames, and Lists #####
##### 17 January 2023
##### EBW

#### Vectors (cont'd) ####

## Coercion
# All atomic vectors are of the same data type
# If you use c() to assemble different types, R coerces them
# logical -> integer -> double -> character

a <- c(2,2.2)
typeof(a)
b <- c("purple","green")
d <- c(a,b) #concatenate a and b
typeof(d) #character trumps double


## comparison yields a logical result
a <- runif(10) #random uniform distribution
print(a)
a > 0.5 #conditional statement

sum(a>0.5) #number of elements in a > 0.5
mean(a>0.5) #proportion of elements in the vector > 0.5
# rnorm randomly generates a normal distribution

## Vectorization
# adds a constant to a vector
z <- c(10,20,30)
z+1 #adds 1 to each element of z
z^2 #squares each element of z

# Adding vectors together
y <- c(1,2,3)
z + y #element by element operation on the vector

## Recycling
# what if vector lengths are not equal?

x <- c(1,2)
z + x #starts over from the top (recycled) in the shorter vector (see the issued warning)


#### Simulating data: runif() and rnorm() ####

runif(n=5, min=5, max=10) #where n = sample size, min = min value, max = max value
# ^^ will be different every time
# can be replicated with a seed 
# if you want people to be able to reproduce your results exactly, you can set a seed
set.seed(123) #can be any number, sets random number generator (is reprodcible)
uniformNumbers <- runif(n=5, min=5, max=10) #this will be the same every time
hist(uniformNumbers)


## rnorm: random normal values with mean 0 and sd 1
randomNormalNumbers <- rnorm (100)
mean(randomNormalNumbers)
hist(rnorm(n=100,mean=100,sd=300)) #histogram of normal distribution



#### Matrices ####

## Matrices are 2-dimensional homogeneous data structures
# A matrix is an atomic vector organized into rows and columns
my_vec <- 1:12

m <- matrix(data = my_vec, nrow = 4) #organize my_vec into a matrix w/ 4 rows
m <- matrix(data = my_vec, ncol = 3) #organize my_vec into a matrix w/ 3 columns
m <- matrix(data = my_vec, ncol = 3, byrow = T) #organize my_vec into a matrix w/ 3 columns, organized by row
dim(m) # gives the dimensions of m as (rows,columns)


#### Lists ####
## Atomic vectors BUT each element can hold different data types (and different sizes)

my_list <- list(1:10, matrix(1:8, nrow=4, byrow=T), letters[1:3], pi)
class(my_list)
str(my_list) #summarizes the list in the Console

## Subsetting lists
# Using [] gives you a single item but not the elements
my_list[4]
my_list[4] - 3 #single brackets gives you only elements in slot which is always type list
# To grab object itself, use [[]]
my_list[[4]]
my_list[[4]]-3

# grab just the matrix
my_list[[2]][4,1] #matrix from the list, 4th row, 1st column; dim subsetting

my_list[1:2] #to obtain multiple compartments within the list
c(my_list[[1]],my_list[[2]]) #to obtain multiple elements within the list

## Name list items when they're created
my_list2 <- list(Tester=FALSE, littleM = matrix(1:9, nrow=3))
# Now we can reference elements in the list by name, kind of like a structure
my_list2$Tester #accesses just the element associated with the name
my_list2$littleM[2,3] #returns the value in the matrix in the 2nd row, 3rd column
my_list2$littleM[2,] #returns all the values in the matrix in the 2nd row 
# [2,] = [2nd row, all columns]
my_list2$littleM[2] #returns the value in the 2nd index position
# [2] = [nth element]

## Unlist strings everything back to vectors
unrolled <- unlist(my_list2)
unrolled #names each element according to its name in the list; FALSE is coerced into 0



#### Accessing iris and manipulating data ####

data(iris) #built-in dataset in R
head(iris) #shows first 6 rows of the dataset
plot(Sepal.Length ~ Petal.Length, data = iris) # plot(yVariable ~ xVariable, data = dataset)
model <- lm(Sepal.Length ~ Petal.Length, data = iris) #fits a linear model to the data
results <- summary(model) #summary statistics/list of the lm stats for the model
# We care about the Pr(>|t|) of the yVariable, aka its p-value
str(results) #lays out the general structure of the list

# extract just the Petal.Length p-value using indexing and unlist()
pval <- results$coefficients["Petal.Length","Pr(>|t|)"] #or [2,4], but it's better not to hardcode tbh
unlisted_results <- unlist(results)
pval <- unlisted_results$coefficients8[1] #p-value will always be coefficients8 in a linear model










#### Data Frames ####
## "List" of equal-length vectors, each of which is a column
## HAS to be equal lengths

varA <- 1:12
varB <- rep(c("Con", "LowN", "HighN"), each=4) #repeats each char 4 times
varC <- runif(12)

dFrame <- data.frame(varA,varB,varC, stringsAsFactors = F) #avoid making strings groups

## Adding another row
new_data <- list(varA = 13, varB = "HighN", varC = 0.668)
# use rbind() to add the row
dFrame <- rbind(dFrame, new_data) #essentially concatenation for data frames
# why can't we use c?
new_data2 <- c(14, "HighN", 0.668)
dFrame2 <- rbind(dFrame, new_data2) #all character data types now oops :(((

## Adding a column is much easier
new_var <- runif(12)
# use cbind() to add the column
dFrame <- cbind(dFrame, new_var) #name of variable is inserted as the column name


#### Data Frames vs. Matrices ####

zMat <- matrix(data = 1:30, ncol = 3, byrow = TRUE)
zDframe <- as.data.frame(zMat) #coerces the matrix into a data frame w/ default headings

zMat[3,3] 
zDframe[3,3] #indexes in the same way

zMat[,3] #all rows, 3rd column
zDframe[,3] #same as above
zDframe$V3 #data frames can index by name too
zDframe["V3"] #silly way to do this

zMat[3,] #3rd row, all columns
zDframe[3,] #same as above

zMat[3] #3rd element: element in index 3
zDframe[3] #3rd element: 3rd "column"


#### Eliminating NAs ####

## complete.cases() function

zD <- c(NA, rnorm(10), NA, rnorm(3)) 
complete.cases(zD) #returns logical output based on whether the value is "complete" or not (NA)
# Clean out NAs
zD[complete.cases(zD)] #automatically removes the NAs
which(!complete.cases(zD)) #indices of NAs in the vector
which(is.na(zD)) #same as above
zD[!is.na(zD)] #same as above

# Clean out NAs from a matrix
m <- matrix(1:20,nrow=5)
m[1,1] <- NA #assigns NA to that position
m[5,4] <- NA
complete.cases(m) #only gives T/F about whether the whole row is complete
# we can subset rows that are complete
m[complete.cases(m),]

## Get complete cases for only certain rows
m[complete.cases(m[,1:2]),] #judge only based off of the first 2 columns



