##### Learning to use nat #####
##### 2/1/23
##### EBW

library(nat)
library(rgl)

## nat creates 2 new classes of objects (aside from previous classes, such as numeric, character, etc.)
# neuron: individual neuron objects (see below)
# neuronlist: list of neuron objects

## Let's load some  example data:
data("Cell07PNs") #olfactory projection neurons from https://doi.org/10.1016/j.cell.2007.01.040
class(Cell07PNs) #neuronlist (nat) and list (base R)
head(Cell07PNs)

# because neuronlists are also lists, we can apply some functions to them that we can to lists
length(Cell07PNs) #number of objects (neurons) in this dataset

# we can also index them similarly
str(Cell07PNs[[1]]) #neuron objects are also lists

# let's pull out the first neuron in the neuronlist to learn about neuron objects
neur1 <- Cell07PNs[[1]]
plot(neur1) #plot.neuron function masked as plot function

### Neuron objects have numerous fields. The most important fields are the following:
# d: a data frame object describing the x,y,z positions of each of the nodes (projections) of the neuron and the diamater (w) of the projection
# NumPoints: number of points in general
# StartPoint, BranchPoints, EndPoints: all of the neuron's nodes
# SegList: Vertex indices of the neuron's segments

## We can look at a summary of a neuron using summary.neuron (masked as summary)
summary(neur1)

### Neuronlists:
# Primarily store all of the neurons in a dataset/subset.
# Can have an optional attached dataframe containing additional information about each of the neurons in the list, called metadata
# We can extract the metadata using as.data.frame()
meta_data <- as.data.frame(Cell07PNs)
head(meta_data) #gives us a sense of the qualities we can subset by

## Using metadata to index:
# Let's say we want to know all of the glomeruli represented in the dataset
with(Cell07PNs, table(Glomerulus)) #shows number of neurons in each glomerulus
# now we can subet neurons based on their glomerulus
va1d_n <- subset(Cell07PNs, Glomerulus=="VA1d") #new sub-neuronlist of neurons in glomerulus VA1d
# If we want a summary of the meta data, rather than the neuronlist:
summary(Cell07PNs[,]) #[,] accesses the data frame without as.data.frame()


## Plotting neurons:

# We can plot an individual neuron:
plot(neur1) #purple node = root/soma of the neuron, red nodes = branch points, green nodes = end points
plot(neur1, WithText=T) #we can label nodes based on their PointNo index from the data.frame d (see above)
plot(neur1, col="blue") #we can change the color of a neuron's axon using col

# We can also plot multiple neurons:
plot(Cell07PNs[1:4]) #plots first 4 neurons from the neuronlist
plot(Cell07PNs) #plots all of the neurons

# We can use subsetting to highlight a specific quality of the neurons
plot(Cell07PNs, subset=Glomerulus!="VA1d", col='grey', WithNodes=F, main="VA1d neurons") #main=title, removes nodes, plots all but the VA1d neurons in grey
plot(Cell07PNs, subset=Glomerulus=="VA1d", add=TRUE) #adds the Va1d neurons to the plot (superimposes using add=TRUE)

## 3D Plots!!
# 3D plotting is super important in anatomical mapping, since our bodies (specifically our brains) do not exist on a 2D plane
# nat uses the rgl package to plot 3D models of the neurons (remember that we had z coordinates too!)
open3d()
plot3d(neur1, col='blue')





