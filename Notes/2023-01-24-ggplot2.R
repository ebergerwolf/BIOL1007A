##### The tidyverse cont'd: ggplot2! #####
##### 1/24/23
##### EBW

# load in the right libraries
library(ggplot2) 
library(ggthemes)
library(patchwork)
library(dplyr)
library(viridis)

#### Template for ggplot code ####
## p1 <- ggplot(data=<DATA>, mapping = aes(x = xdata, y = ydata)) +
##      <GEOM FUNCTION> #i.e. geom_boxplot(), etc
## print(p1)

### Load in a built-in data set
d <- mpg
str(mpg)
glimpse(mpg)

#### qplot: quick plotting ####

# histogram
qplot(x=d$hwy) #automatically makes a histogram
qplot(x = d$hwy, fill=I("darkblue"), color=I("black")) #magical function I() to make sure it knows colors are colors

# scatterplot
qplot(x=d$displ, y=d$hwy, geom=c("smooth","point"), method = "lm") #smooth = smooth line; point = scatter

# boxplot
qplot(x=d$fl, y=d$cty, geom="boxplot", fill = I("forestgreen"))

# barplot
qplot(x=d$fl, geom="bar", fill=I("forestgreen"))

#### Create some data (specified counts)
x_trt <- c("Control","Low","High")
y_resp <- c(12,2.5,22.9)
qplot(x=x_trt, y=y_resp, geom="col", 
      fill=I(c("maroon","slategrey","skyblue"))) 
#colors found by googling "colors in r" and "virdis color map r"

#### ggplot: uses dataframes instead of vectors ####

p1 <- ggplot(data = d, mapping = aes(x=displ, y=cty, color=cyl)) + #color argument groups it by color
  geom_point()
p1

# theme arguments
p1 + theme_base()
p1 + theme_bw()
p1 + theme_classic()
p1 + theme_minimal()
p1 + theme_economist()
p1 + theme_solarized()

# change font
p1 + theme_bw(base_size=20, base_family="serif") #change font

# let's make a bar plot
p2 <- ggplot(data=d, aes(x=fl,fill=fl)) +
  geom_bar()
p2 + coord_flip() #flip coordinates
p2 + 
  coord_flip() +
  theme_classic(base_size=15, base_family = "sans") 

# Theme modifications
p3 <- ggplot(data=d, aes(x=displ,y=cty)) +
  geom_point(size=4, shape=25, 
             color="magenta",fill="black") + #need to use the correct shape to change outline and fill
  xlab("Count") +
  ylab("Fuel") +
  labs(title="My title here", subtitle="my subtitle here") #can also do x= and y= for axis titles here
p3 + #can change axis limits
  xlim(1,10) + 
  ylim(0,35) 

# Boxplot time
cols <- viridis(7, option="magma") #takes 7 hex color codes from the given palette
ggplot(d, aes(x=class, y=hwy, fill=class)) +
  geom_boxplot() +
  scale_fill_manual(values = cols) + 
  theme(legend.position = "none") #remove legend

# create subplots with patchwork
p1+p2+p3 #next to each other
p1/p2/p3 #above each other
(p1+p2)/p3 #more complex

