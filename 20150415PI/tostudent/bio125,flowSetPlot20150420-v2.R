
# youtube video is http://youtu.be/r7Mf6joCNzM 

# clean workspace
rm(list=ls())

# Flow cytometer data can be downloaded from  http://tinyurl.com/pdcqyo9

### install packages. You need to install them once. 
# source("http://bioconductor.org/biocLite.R")
# biocLite("flowCore")
# biocLite("flowClust")
# biocLite("flowViz")
### 

#load packages into R. 
require(flowCore);  require(flowClust); require(flowViz)

#tell R where to look for data
mypath='fcs'

# read all the flow data
fs = read.flowSet(path=mypath)

tf = transformList(from=colnames(fs), tfun=log10) #define a transform method
fs2 = tf %on% fs    #perform the transformation

rgate1 = rectangleGate('FSC-H'=c(2, 4), 'SSC-H'=c(2,4)) #define a gate
my.filter = filter(fs2, rgate1)   # define a filter
fs3 = Subset(fs2, my.filter)  #apply the gate-filter

print(fs3)
 
pdf( "HQin,bio125-flow-report.pdf", width=6, height=4)
 densityplot(~ ., fs3, channels=c("FL2-H"), 
            filter= curv1Filter("FL2-H") )

 densityplot(~ ., fs3, channels=c("FL2-H", "FL3-H"), 
             filter=list(curv1Filter("FL2-H"), curv1Filter("FL3-H")))
 
 xyplot(`FSC-H` ~ `FL2-H`, data=fs3, filter=rgate1);
 xyplot(`SSC-H` ~ `FSC-H`, data=fs3, filter=rgate1);
dev.off()
 
