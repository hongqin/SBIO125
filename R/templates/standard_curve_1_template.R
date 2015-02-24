
#First, let input our experiment data
concentration = c(100.0, 50,  25,  12.5,  5, 0.0 ) # ug/mL Change here!
OD            = c(1.0,  0.5, 0.25,  0.12,  0.05, 0.0  ) #   Change here

# a plot see the the result
plot( concentration ~ OD,
      ylim = c(min(concentration)/2, max(concentration)*1.2),
      xlim= c(0, max(OD)*1.2))

#Now, fit a linear model to the data
m = lm(concentration ~ OD )
abline(m, col='red') #put the linear model on the plot
summary(m)

unknownOD = c(0.001, 0.9999 ) #Change here
unknowConcentration = m$coef[1] + m$coef[2]*unknownOD
unknowConcentration
points(unknownOD, unknowConcentration, pch=19, col="blue")

orig = unknowConcentration * 1000/100
orig
