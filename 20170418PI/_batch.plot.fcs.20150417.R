rm(list=ls())

debug = 0; 
require(flowCore);  require(flowClust); require(hexbin)

facFlList = list.files( path="fcs/");  facFlList

for (  i in 1: length(facFlList) ) {
 # i = 1; 
 myfl.full = paste( 'fcs/', facFlList[i], sep='');
 myfcs = read.FCS( myfl.full );

 if(debug>0) {    myfcs@exprs = myfcs@exprs[1000:3000, ]   }
 
 #remove debris, 
 my.gate = rectangleGate(filterId="Cells", list("FSC-H"=c(0.5E1, Inf), "SSC-H"=c(1E1, Inf), "FL2-H"=c(0, Inf) ))
 my.filter = filter( myfcs, my.gate)
 myfcs2 = Subset( myfcs, my.filter )
 
 mydata = data.frame(log10(myfcs2@exprs))
 mynames = names(mydata)
 
 pdf(paste("sandbox/_", facFlList[i], ".pdf", sep=""), width=8, height=11);
 par(new=T)
 par(mfrow = c(3, 3)) 
 
 for (j in 1:14 ) {
    hist( mydata[,j], breaks=100, xlab=mynames[j], main= facFlList[i], xlim=c(0,4.5), freq=F )
 }
 plot( mydata[,2] ~ mydata[,1], pch=3, xlab=mynames[1], ylab=mynames[2], xlim=c(0,4.5), ylim=c(0,4.5))
 plot( mydata[,5] ~ mydata[,1], pch=3, xlab=mynames[1], ylab=mynames[5], xlim=c(0,4.5), ylim=c(0,4.5))
 plot( mydata[,4] ~ mydata[,1], pch=3, xlab=mynames[1], ylab=mynames[4], xlim=c(0,4.5), ylim=c(0,4.5)) 
 dev.off();
 
} #i loop


#quit("yes")
 
 
