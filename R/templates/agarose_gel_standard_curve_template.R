
#First, let input our experiment data
Sizeladder = c(0.3, 0.4, 0.5, 0.6, 1.0) # kb  Change here!
distance   = c(7.0, 6.0, 5.0, 4.0, 3.0) # cm  Change here!

#semi-log plot
plot( log10(Sizeladder) ~ distance, xlim = c(min(distance)/2, max(distance)*1.2),
      ylim= c(log10(min(Sizeladder)/2), log10(max(Sizeladder)*1.5)) )

#Now, fit a linear model to the data
m = lm(log10(Sizeladder) ~ distance ); m
abline(m, col='red') #put the linear model on the plot
summary(m)

unknownDistance = c( 6.5, 2.7) #change here

unknownSize = m$coef[1] + m$coef[2]*unknownDistance
points(unknownSize, unknownDistance, pch=19, col="blue")

sizeofUnknown = 10^(unknownSize)
sizeofUnknown

