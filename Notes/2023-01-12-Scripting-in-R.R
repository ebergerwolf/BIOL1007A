##### Learning how to program in R #####
#### 12 January 2023
#### EBW

#### Assignment operator: Used to assign a new value to a variable (<-) ####

x <- 5 #assigns x to be 5
print(x) #prints x in the console
x #does the same thing as print(x)

# = is also an assignment operator... It's legal, but not used except in function arguments
y = 4 #in R, bad for readability
print(y)
y = y + 1.1
y <- y + 1.1 #preferred!


#### Variables: Used to store information (like a container) ####
z <- 3 #single letter variables are good for unimportant storage
plantHeight <- 10 #camel case format
plant_height <- 10 #snake case format; preferred method
plant.Height <- 10 #avoid this, many functions use periods
. <- 5.5 #reserved for a temporary variable, doesn't show up in the environment


#### Functions: Pieces/blocks of code that perform a specific task; You can use a short command over and over again instead of writing the same code ####

## You can create your own functions!

# Create a function "square" that squares an input x
square <- function(x = NULL){ #x=NULL specifies the default of null
  x <- x^2
  print(x)
}

z <- 103
square(x=z) #the argument name is x

## There are also built-in functions

sum(109,3,10) #sums the numbers given; we can read more at ?sum or help(sum)

numbers <- c(2,40,13,26) #combines the values into a vector
sum(numbers) #sums all of the values in the vector "numbers"




#### 4 Different types of data in R ####

# 1- or 2/n- dimensions
# Homogenous (all the same type) or heterogenous (different types)

# Atomic vector: 1-dimension & homogenous
# Matrix: 2/n-dimensions & homogenous
# List: 1-dimension & heterogenous
# Data frame: 2/n-dimensions & heterogenous (often come from .csv)


#### Atomic vectors ####
# one dimensional (a single row)
# fundamental data structures in R programming

## Types:
# character strings (usually within quotes)
# integers (whole numbers)
# doubles (real numbers, decimal)
# *int and double are both numeric
# logical (binary, TRUE or FALSE)
# factor (categorizes, groups variables)


# c function (combine): concatenates different elements to create one vector
z <- c(3.2,5, 5, 6)
print(z)
class(z) #tells us what class of data is in the variable/vector
typeof(z) #all of the data in a vector is the same type (character > double > int > logical)
is.numeric(z) #returns logical output (T/F)

# c() always "flattens" to a vector
z <- c(c(3,4),c(5,6)) #same as c(3,4,5,6), no point in doing this
print(z)

# character vectors
z <- c("perch","bass",'trout') #quote type doesn't matter
print (z)
z <- c("this is only 'one' character string","a second",'a third') #interchange quote types to get quotes within the element
print(z)
typeof(z)
is.character(z) #is. tests whether it is that data type (logical output)

# logical, or Boolean, are T/F or TRUE/FALSE
z <- c(T,F,FALSE,TRUE) # logical vector; can use either notation
print(z)
is.logical(z)
z <- as.character(z) #as. coerces data type to that data type (z is now character)
print(z)
is.logical(z)


#### Properties of Vectors ####

# Type: see above

# Length (number of elements in the vector)
length(z) #length of z
dim(z) #NULL, because z only has one dimention

# Names
z <- runif(5) #random uniform distribution of length n (5 in this case); default min 0, max 1
names(z) #NULL for now, how do we add names?
names(z) <- c("chow","pug","beagle","greyhound","akita") #assigns names to each element in z
print(z)
names(z) #now, this outputs the names of z
names(z) <- NULL #resets the names of z

# NA Values: missing data
z <- c(3.2,3.5,NA)
typeof(z)
sum(z) #not possible because NA

# check for NAs
anyNA(z) #one output
is.na(z) #returns logical vector same size as z
which(is.na(z)) #gives specific index of NA value; best for exploring data and determining NA value indices


#### Subsetting Vectors ####

z <- c(3.1,9.2,1.3,0.4,7.5)

# Vectors are indexed (starting at 1 in R) using []
z[4] #returns 4th element of z; subsets by index
z[c(4,5)] #returns 4th and 5th elements of z
z[4:5] #same as above
z[-c(2,3)] #everything except 2nd and 3rd elements of z

# Logical statements within [] let us subset by conditions
z[z==7.5] #returns element that is 7.5
z[z==3.4] #returns element that is 3.4 (empty vector bc there's no element)
z[z<7.5] #returns all elements that are less than 7.5
which(z<7.5) #just gives us the indices
z[which(z<7.5)] #same as z[z<7.5], rarely used but has its applications in indexing
q <- z < 7.5 #logical vector based off of z

# Subsetting using characters
names(z) <- letters[1:5] #gives us 5 letters
z["a"] #subsetting based off of the name
z[c("a","d")] #subsetting based off of multiple letters

# Subset function: subset(x,subset); x=value to be subsetted, subset=condition
subset(x = z, subset = z>1.5) #same as z[z>1.5]

# Randomly sampling using sample function
story_vec <- c("A","Frog","Jumped","Here")
sample(story_vec) #with no size parameters, just shuffles the vector
sample(story_vec, size=3) #randomly samples vector with size 3 

# Adding elements to a vector
story_vec <- c(story_vec[1],"Green", story_vec[2:length(story_vec)]) #adds the word "Green"
print(story_vec)

# Reassigning elements
story_vec[2] <- "Blue" #reassigns "Green" to "Blue"
print(story_vec)


#### Vector functions ####

# vector function
vec <- vector(mode="numeric",length=5) #zero vector size 5, placeholder

# rep function (repeating function)
z <- rep(x=0,times=100) #repeats "x" (0) "times" (100) times 
z <- rep(x=1:4,each=3) #repeats numbers 1-4, each 3 times
z <- rep(x=1:4,times=3) #repeats numbers 1-4, 3 times as a sequence

#seq function (dequencing function)
z <- seq(from = 2, to = 4) #sequences of numbers from 2 to 4
z <- seq(from = 2, to = 4, by = 0.5) #sequences of numbers from 2 to 4, by 0.5
z <- runif(5)
seq(from=1,to=length(z)) #if our variable will change, we can avoid hardcoding using things like length





