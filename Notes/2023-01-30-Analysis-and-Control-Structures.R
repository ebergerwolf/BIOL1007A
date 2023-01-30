##### Simple Data Analysis and More Complex Control Structures #####
##### 1/30/23
##### EBW


## Load in data
dryadData <- read.table(file="Data/veysey-babbitt_data_amphibians.csv", header=T, sep=",")

## Set up libraries
library(tidyverse)
library(ggthemes)

### Analyses
### Experimental designs
### independent/explanatory var (x) vs. dependent/response var (y)
### continuous (range of #, quantitative) vs. discrete (qualitative/categorical)

### continuous x & continuous y: linear regression (scatter plot)
### discrete x & continuous y: t-test/ANOVA (bar graph, box plot)
### discrete x & discrete y: chi-square (table, mosaic)
### continuous x & discrete y: logistic regression (logistic curve)

glimpse(dryadData)

### Basic linear regression analysis (2 continuous variables)
## Is there a relationship between the mean pool hydroperiod and the number of breeding frogs caught?
## Basic formula: y ~ x

regModel <- lm(count.total.adults ~ mean.hydro, data=dryadData) #linear model
summary(regModel) #gives the summary
hist(regModel$residuals) #helps show us if the linear model was the way to go, we want it to look normal
summary(regModel)$"r.squared" #extract r squared

View(summary(regModel))

## Scatter plot
regPlot <- ggplot(data=dryadData, aes(x=mean.hydro, y=count.total.adults)) +
  geom_point(alpha=0.5) +
  stat_smooth(method="lm",se=0.99)

regPlot + theme_few()


### Basic ANOVA
## Was there a statistically significant difference in the # of adults between wetlands?
## Basic formula: y ~ x

dryadData$wetland <- factor(dryadData$wetland)

ANOmodel <- aov(count.total.adults ~ wetland, data=dryadData) #make sure that categorical var is categorical (see: factor)
summary(ANOmodel)

dryadSummary <- dryadData %>%
  group_by(wetland) %>%
  summarize(avgHydroPeriod = mean(count.total.adults, na.rm=T), N = n())

## Box plot
ANOplot <- ggplot(data=dryadData, aes(x=wetland, y=count.total.adults, fill=species)) +
  geom_boxplot() +
  scale_fill_grey()
ANOplot
ggsave(file="SpeciesBoxPlots.pdf",plot=ANOplot, device="pdf") #save image as pdf


### Logistic regression

## Simulate a data frame
# gamma probabilities: best for continuous variables that are always positive and have a skewed distribution
xVar <- sort(rgamma(n=200, shape=5, scale=5))
hist(xVar)
yVar <- sample(rep(c(1,0), each=100), prob=seq_len(200)) #equal probability of sampling 1 or 0
logRegData <- data.frame(xVar,yVar)
glimpse(logRegData)

# Analysis
logRegModel <- glm(yVar ~ xVar, data=logRegData, family="binomial"(link=logit))
summary(logRegModel)

# Logistic regression plot
logRegPlot <- ggplot(data=logRegData, aes(x=xVar, y=yVar)) +
  geom_point() +
  stat_smooth(method= "glm", method.args=list(family="binomial"))
logRegPlot


### Contingency table (chi-squared) Analysis
## Are there differences in counts of males and females between species?

countData <- dryadData %>%
  group_by(species) %>%
  summarize(Males = sum(No.males, na.rm=T), 
            Females = sum(No.females, na.rm=T)) %>%
  select(-species) %>%
  as.matrix()

row.names(countData) <- c("SpS","WF")

# chi-squared test
chiTest <- chisq.test(countData)
chiTest$residuals #distances from expected values

# Mosaic plot (base R)
mosaicplot(x=countData, col=c("goldenrod","maroon"))

# Reshape data for bar graph
countDataLong <- countData %>%
  as_tibble() %>%
  mutate(Species = c(rownames(countData))) %>%
  pivot_longer(cols=Males:Females, names_to="Sex", values_to="Count")

# Bar graph
ggplot(countDataLong, aes(x=Species, y=Count, fill=Sex)) +
  geom_bar(stat="identity", position="dodge") + #plot bars next to each other
  scale_fill_manual(values=c("darkslategrey","midnightblue"))


##########################################################

#### Control Structures

# if and ifelse statements

### if (condition) {expression 1}
# If <condition> is true, run <expression 1>

### if (condition) {expression 1}
### else {expression 2}
# If <condition>, run <expression 1>. Otherwise, <run expression 2>

### if (condition 1) {expression 1} else
### if (condition 2) {expression 2} else
### {expression 3}
# If <condition 1>, run <expression 1>. If <condition 2>, <run expression 2>. Otherwise, run <expression 3>.

### If there is a final unspecified else, captures the rest of unspecified conditions
### else must appear on the same line as the expression

# use it for single values
z <- signif(runif(1),digits=2) #random uniform single number
z >  0.5 #example of a condition

### use {} or not
if (z > 0.8) {cat(z, "is a large number", "\n") #cat() strings together strings; "\n" is a line break
  } else
    if (z < 0.2) {cat(z, "is a small number", "\n")
      } else 
      {cat(z, "is a number of typical size","\n")
        cat("z^2 =", z^2, "\n")}


#### ifelse to fill vectors

### ifelse(condition, yes, no)

#### insect population where females lay 10.2 eggs on average, following a Poisson distribution (discrete probability distribution showing the likely number of times an event will occur). 35% parasitism where no eggs are laid. Let's make a distribution for 1000 individuals
tester <- runif(1000) #1000 random uniform numbers
eggs <- ifelse(tester > 0.35, rpois(n=1000, lambda=10.2), 0)
hist(eggs)

#vector of p-values from a simulation and we want to create a vector to highlight the significant ones for plotting.
pVals <- runif(1000)
z <- ifelse(pVals <= 0.025, "lowerTail", "nonSig")
table(z)
z[pVals >= 0.975] <- "upperTail"
table(z)

#### for loops
### workhorse function for doing repetitive tasks
### universal in all computer languages
### Controversial in R
## -often unnecessary (vectorization in R)
## -very slow with certain operations
## -family of apply functions (learn more for final project??)

### Anatomy of a for loop
### for(var in seq) { #starts for loop
  ###   body of the for loop
### } end of the for loop
# var is a counter variable that holds the current value of the for loop
# sequence is an integer vector that defines start/end of loop

for (i in 1:5) {
  cat("stuck in a loop",i,"\n")
  cat(3+2,"\n")
  cat(3+i,"\n")
}
print(i)

## Use a counter variable that maps to the position of each element
my_dogs <- c("chow","akita","malamute","husky","samoyed")
for(i in 1:length(my_dogs)) {
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

## Use double for loops

# loop over rows (single loop)
m <- matrix(round(runif(20),digits=2), nrow=5)
for (i in 1:nrow(m)){
  m[i,] <- m[i,] + i
}

# loop over rows AND columns (nested loop)
m <- matrix(round(runif(20),digits=2), nrow=5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j
  } #end col for loop j
} #end row for loop i
print(m)


