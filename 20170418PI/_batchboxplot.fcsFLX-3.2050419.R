rm(list=ls())
require(flowCore);  require(flowClust); require(hexbin)
debug = 1; 

#facFlList = list.files( path="fcs/");  facFlList
facFlList = list.files( path="fcs.v2/");  facFlList


#generate a dataframe
Row.Len = 5E3; 
merged.FLX = data.frame( matrix(data=NA, nrow=Row.Len,ncol=1) )
names(merged.FLX) = c("tmp")

#for( i in 1:8) {
for (  i in 1: length(facFlList) ) {
 myfl.full = paste( 'fcs/', facFlList[i], sep='');
 myfcs = read.FCS( myfl.full );
 
 #remove debris. pcp1D has much broad distribution and has to be done separately
 my.gate = rectangleGate(filterId="Cells", list("FSC-H"=c(0.55E2, Inf), "SSC-H"=c(5E2, Inf), "FL2-H"=c(0, Inf) ))
 my.filter = filter( myfcs, my.gate)
 myfcs2 = Subset( myfcs, my.filter )
 
 mydata = data.frame(log10(myfcs2@exprs))
 mynames = names(mydata)
 current.FLX = mydata$FL2.H   ### change here
# col.names(current.FL3) = facFlList[i]
 merged.FLX = cbind( merged.FLX, current.FLX[1:Row.Len])  #20150417 add 1:Row.Len
 oldnames = colnames( merged.FLX )
 if ( length(oldnames>1)) {
  newnames = c(oldnames[-length(oldnames)], facFlList[i]) 
  colnames( merged.FLX ) = newnames
 } else {
   colnames( merged.FLX ) = facFlList[1]
 }
 
} #i loop

merged.FLX = merged.FLX[,-1] ###2012 June 10, change

#boxplot
pdf( "batch-boxplot.pdf", width=10,height=11)
par(oma=c(2,12,2,2), las=1) #adjust margin for labels, 2012June10 add las=1
#par(mar=c(2,20,2,2), las=1) #adjust margin for labels
boxplot( as.data.frame(merged.FLX), horizontal=TRUE, main=getwd())
dev.off()

