
rm(list=ls())

debug = 0; 
require(flowCore);  require(flowClust); require(flowViz)

mydate = ''
#mypatterns = c('BY', 'M5'); 
myp = ''
mypath='fcs.v2'

#for( myp in mypatterns ) {
 fs = read.flowSet(path=mypath, pattern=myp)
 print(myp)
 pData(phenoData(fs))
# xyplot(`SSC-H` ~ `FSC-H`, data=fs);

 tf = transformList(from=colnames(fs), tfun=log10)
 fs2 = tf %on% fs
 rgate1 = rectangleGate('FSC-H'=c(2, 4), 'SSC-H'=c(2,4))
 my.filter = filter(fs2, rgate1)
 fs3 = Subset(fs2, my.filter)
 print(fs3)
 
 pdf(paste(mypath, myp, mydate, 'FSC-FL3scatter', 'pdf', sep='.'))
 xyplot(`FSC-H` ~ `FL2-H`, data=fs3, filter=rgate1);
 dev.off()

  pData(phenoData(fs3))
# fs3@phenoData@data$name = c('0% glu', '0.01% glu', '0.1% glu', '0.25% glu', '0.5% glu', '1% glu', '2% glu') #2012 July 11 change
 
 pdf(paste(mypath, myp, mydate, 'FL2Marginal', 'pdf', sep='.'), width=6, height=4)
 #densityplot(~ `FL2-H`, data=fs3, filter=curv1Filter("FL2-H")) 

 densityplot(~ ., fs3, channels=c("FL2-H"), 
            filter= curv1Filter("FL2-H") )

 densityplot(~ ., fs3, channels=c("FL2-H", "FL3-H"), 
             filter=list(curv1Filter("FL2-H"), curv1Filter("FL3-H")))

 #            dev.off()
 
 #pdf(paste(mypath, myp, mydate, 'SSC-FSC', 'pdf', sep='.'));
 xyplot(`SSC-H` ~ `FSC-H`, data=fs3, filter=rgate1);
 dev.off()
 
#}


#quit("no")
