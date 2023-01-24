##### Entering the tidyverse #####
##### 1/23/23
##### EBW

### tidyverse Background ####
### collection of packages that share philosophy, grammar (how the code is structured), and data structures

## Operators: symbols that tell R to perform different operations
# Are usually between variables/functions/etc

## Examples:
# Arithmetic operators: + - * / ~ =
# Assignment operator: <- 
# Logical operators: ! | &
# Relational operators: == != > < >= <=
# Miscellaneous operators: 
# %>% (forward pipe operator), %in%



#### Installing the tidyverse package ####

### You only need to install packages once

library(tidyverse) # library function to load in packages

### dplyr: new(er) package that provides a set of tools for manipulating datasets
# more intuitive, specifically written to be fast
# individual functions that correspond to common operations

### The core verbs:
## filter()
## arrange()
## select()
## group_by() and summarize()
## mutate()



#### Let's practice ####

## built-in dataset
data(starwars)
class(starwars)

## Tibble: modern take on data frames
# great aspects of dfs and drops frustrating ones (changing variables, etc.)

glimpse(starwars) #better, cleaner version of str()

### NAs
anyNA(starwars) #is.na, complete.cases
starwars_clean <- starwars[complete.cases(starwars[,1:10]),]
anyNA(starwars_clean[,1:10]) #now gone

### filter(): picks/subsets observations (rows) by their values
filter(starwars_clean, gender == "masculine" & height < 180) #can use & or ,
filter(starwars_clean, gender == "masculine", height < 180, height > 100)
# multiple conditions for the same variable
filter(starwars_clean, gender == "masculine" | gender == "feminine") #can also use |

### %in% operator (matching operator)
## similar to == but you can compare vectors of different lengths

# sequence of letters
a <- LETTERS[1:10]
length(a) #length of vector

b<- LETTERS[4:10]
length(b)

# Output of %in% depends on first vector
a %in% b
b %in% a

# Can use %in% to subset
eyes <- filter(starwars, eye_color %in% c("blue","brown")) #cleaner than using | (or)
View(eyes)

### arrange(): reorders rows
arrange(starwars_clean, by=height) #default is ascending order
# can use helper function desc()
arrange(starwars_clean, by=desc(height)) #descending order
#additional arguments
arrange(starwars_clean, height, desc(mass)) #second variable used to break ties of the first

sw <- arrange(starwars, by=height) 
tail(sw) #all NAs/missing values are at the end

### select(): chooses variables (Columns) by their names
select(starwars_clean, 1:11) #subset by column index
select(starwars_clean, name:species) #subset by column names
select(starwars_clean, -(films:starships)) #"subtracting" works too
starwars_clean[,1:11] #same as above

### Rearrange columns
names(starwars_clean)
select(starwars_clean, name, gender, species, everything())
#everything(): helper function that takes everything else and adds it to the end; useful if you want to move variables to the beginning
# contains() helper function
select(starwars_clean, name, contains("color"))

## other helper functions: ends_with(), starts_with(), numrange(), etc.

# select() can also rename columns
select(starwars_clean, haircolor = hair_color) #only returns renamed column
rename(starwars_clean, haircolor = hair_color) #returns whole data frame with renamed column

### mutate(): creates new variables using functions of existing variables
# let's create a new column that is height divided by mass
mutate(starwars_clean, ratio = height/mass)
# convert mass from kg to lb
starwars_lbs <- mutate(starwars_clean, mass_lbs = mass*2.2, .after=mass)

# transmute() function
transmute(starwars_clean, mass_lbs = mass*2.2) #only returns mutated columns
transmute(starwars_clean, mass, mass_lbs = mass*2.2, height) #returns all referenced columns

### group_by() and summarize() functions
summarize(starwars_clean, meanHeight = mean(height)) #gets mean height of all characters in data frame
# if you have any NAs, need to use na.rm
summarize(starwars_clean, meanHeight = mean(height), totalNumber = n()) #n(): total number of observations

# use group_by() for maximum usefulness
starwars_genders <- group_by(starwars, gender) #sets up the tibble into groups
summarize(starwars_genders, meanHeight = mean(height, na.rm=T), totalNumber = n()) #now can get summaries by group
## Like splitapply() in Matlab



#### Piping %>% ####

## Used to emphasize a sequence of actions
## Allows you to pass on intermediate results onto the next function (uses output of one function as input of the next function)
## Avoid if you need to manipulate more than one object/variable at a time; or if the variable is meaningful
## formatting: should have a space before the %>% followed by a new line

# Let's practice!
starwars_clean %>%
  group_by(gender) %>% #don't need data frame name, because now the first argument has been piped in
  summarize(meanHeight=mean(height,na.rm=T), totalNumber= n()) #much cleaner with piping!

## case_when() is useful for multiple if/ifelse statements
starwars_clean %>%
  mutate(sp = case_when(species=="Human" ~ "Human", TRUE ~ "Non-Human")) #uses condition, puts "Human" if TRUE in sp column, puts "Non-Human" if it's false






