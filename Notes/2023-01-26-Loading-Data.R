###### Loading Data #####
##### 1/26/23
##### EBW

#### Reading and writing data ####

#### Functions to read in a data set
## **Save your data as .csv when you can! Best practice**

### read.table()
## reads in data set, more flexible and can specify comments
## read.table(file="path/to/data.csv", header=TRUE, sep=",") 
# header pulls in header names as column names
# sep indicates what type of separation the file uses

### read.csv()
## Less flexible, more direct
## read.csv(file="data.csv", header=T) 

#### Create and save a data set with write.table()
## write.table(x=varName, file="outputFileName.csv", header=TRUE, sep=",")

#### Use RDS objects when only working in R
## saveRDS() saves R variables as their own R objects
# saveRDS(varName, file="FileName.RDS")
## readRDS() opens previously created R variables
# varName <- readRDS("FileName.RDS")
## These functions are great for when a variable/data takes a while to make and you don't want to have to do it every time you run the script; good for large datasets


#### Long vs. Wide data formats ####
### wide format: contains values that do not repeat in the ID column
### long format: contains values that DO repeat in the ID column

library(tidyverse)
glimpse(billboard) #each week has its own columns (wide format)
# let's make it long format
b1 <- billboard %>%
  pivot_longer(
    cols = starts_with("wk"), #specify which columns to make longer
    names_to = "Week", #name of new column containing header names
    values_to = "Rank", #name of new column containing values
    values_drop_na = TRUE #removes NA values
      )
View(b1) #btw RMarkdown does NOT like View()

# What if we want to make the data wider? pivot_wider()
## Best for making occupancy matrix
glimpse(fish_encounters)
# let's make it wider
f1 <- fish_encounters %>%
  pivot_wider(
    names_from = station, #column we want to turn into multiple rows
    values_from = seen, #column we want to take values from for new columns,
    values_fill = 0 #fills NA (missing) values with 0
  )
View(f1)


#### Let's actually load in some data ####

### Dryad: makes research data freely reusable, citable, and discoverable
## https://datadryad.org/search

# Let's read in some data we downloaded
dryadData <- read.table(file="Data/veysey-babbitt_data_amphibians.csv", header=T, sep=",") #load in data
glimpse(dryadData)
head(dryadData)
table(dryadData$species) #allows you to see different groups of character column
summary(dryadData$mean.hydro) #summarizes numerical data from a column


## Recreating a plot from a paper

dryadData$species<-factor(dryadData$species, labels=c("Spotted Salamander", "Wood Frog")) #creating 'labels' to use for the plot
str(dryadData$species)

class(dryadData$treatment)
dryadData$treatment <- factor(dryadData$treatment,
                              levels=c("Reference",
                                       "100m","30m"))


p<- ggplot(data=dryadData, 
           aes(x=interaction(wetland, treatment), 
               y=count.total.adults, fill=factor(year))) + 
  geom_bar(position="dodge", stat="identity", color="black") +
  ylab("Number of breeding adults") +
  xlab("") +
  scale_y_continuous(breaks = c(0,100,200,300,400,500)) +
  scale_x_discrete(labels=c("30 (Ref)", "124 (Ref)", "141 (Ref)", "25 (100m)",
                            "39 (100m)","55 (100m)","129 (100)", "7 (30m)","19 (30m)",
                            "20 (30m)","59 (30m)")) +
  facet_wrap(~species, nrow=2, strip.position="right") +
  theme_few() + scale_fill_grey() + 
  theme(panel.background = element_rect(fill = 'gray94', color = 'black'), 
        legend.position="top",  legend.title= element_blank(), 
        axis.title.y = element_text(size=12, face="bold", colour = "black"),
        strip.text.y = element_text(size = 10, face="bold", colour = "black")) + 
  guides(fill=guide_legend(nrow=1,byrow=TRUE)) 

p









