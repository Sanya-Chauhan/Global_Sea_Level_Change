#--------------------------------------------------------------
#RESEARCH PROJECT
#Analysis of Global Mean Sea Level Data Set by NASA
#--------------------------------------------------------------

library(tseries)

data <- read.csv("sealeveldata1.csv")
View(data)
t <- data$t
GMSL <- data$GMSL_GIA

#Time period for differenced data
t1 <- t[-1]

#--------------------------------
#SCATTER PLOTS
#--------------------------------
plot(t,GMSL,type = "l",xlab="Time",main="Plot of Global Mean Sea Level",xlim=c(0,30))
plot(t1,diff(GMSL),type = "l",xlab="Time",
     main="Plot of First Differences of The Data",xlim=c(0,30))

#---------------------------------------
#TESTING STATIONARITY OF THE DATA
#---------------------------------------

#PP.test
#H0: The time series has a unit root 
#H1: There is no unit root

PP.test(GMSL)
#p-value = 0.01
#Hence H0 is rejected

PP.test(diff(GMSL))
#p-value = 0.01
#Hence H0 is rejected

#adf.test

#H0:unit root is present in a time series sample
#H1: Absence of unit root

adf.test(GMSL)
#p-value = 0.01
#Hence 

adf.test(diff(GMSL))
#p-value = 0.01

#kpss.test

#H0:The univariate time series is trend stationary 
#H1: The time series is not stationary 

kpss.test(GMSL)
#p-value = 0.01
#Hence not stationary

kpss.test(diff(GMSL))
#p-value = 0.1
#Hence stationary


#------------------------------------
#TESTING SEASONALITY OF THE DATA
#------------------------------------

tsgmsl <- ts(GMSL,frequency = 37)
library(seastests)

isSeasonal(tsgmsl)
#TRUE

isSeasonal(diff(tsgmsl))
#TRUE

isSeasonal(diff(diff(tsgmsl)))
#FALSE

isSeasonal(diff(diff(diff(tsgmsl))))
#TRUE


#-------------------------------
# DECOMPOSITION OF DATA
#-------------------------------

#Additive Model
desgmsl <- decompose(tsgmsl, type = "additive")
plot(desgmsl, col="navy blue")

#Multiplicative Model
desgmslm <- decompose(tsgmsl, type = "multiplicative")
plot(desgmslm,col="dark blue")

#Decision: Rejecting multiplicative model since the random component 
#doesn't appear to be random 


#Extracting the random component
rand.ser <- desgmsl$random
head(rand.ser) #Checking the head of the random component
#[1] NA NA NA NA NA NA

tail(rand.ser) #Checking the tail of the random component
#[1] NA NA NA NA NA NA

#Head and tail contains NA since the initial and last k(=18) observations 
#have been lost due to moving average of extent m = 2k + 1 =37

ran.series <- rand.ser[19:1012] #Extracting non NA values 


# kpss.test(desgmsl$random)
# PP.test(desgmsl$random)
# adf.test(desgmsl$random)

ran.ts <- ts(ran.series,frequency = 37)
#not specifying start and end dates

isSeasonal(ran.ts)
#FALSE

#NOTE: Some part of the analysis like fitting of trend component was performed
# on SPSS for efficiency. Kindly refer presentation deck for detailed flow.


acf(ran.ts,main="ACF of Decomposed Data")
pacf(ran.ts,main="Partial ACF of Decomposed Data")

#-----------------------------------------------------
# FITTING OF ARIMA MODEL TO DECOMPOSED DATA
#-----------------------------------------------------

fit1 <- arima(ran.ts,order=c(1,0,0))
fit2 <- arima(ran.ts,order=c(1,0,1))
fit3 <- arima(ran.ts,order=c(1,0,2))
fit4 <- arima(ran.ts,order=c(2,0,0))
fit5 <- arima(ran.ts,order=c(2,0,1))
fit6 <- arima(ran.ts,order=c(2,0,2))
fit7 <- arima(ran.ts,order=c(0,0,1))
fit8 <- arima(ran.ts,order=c(0,0,2))

#Extracting residuals of all models
res1 <- fit1$residuals
res2 <- fit2$residuals
res3 <- fit3$residuals
res4 <- fit4$residuals
res5 <- fit5$residuals
res6 <- fit6$residuals
res7 <- fit7$residuals
res8 <- fit8$residuals

#Applying Ljung Box Test to test the fir of the model
test1 <- Box.test(res1,fitdf=1,lag=2)
test2 <- Box.test(res2,fitdf=2,lag=3)
test3 <- Box.test(res3,fitdf=3,lag=4)
test4 <- Box.test(res4,fitdf=2,lag=3)
test5 <- Box.test(res5,fitdf=3,lag=4)
test6 <- Box.test(res6,fitdf=4,lag=5)
test7 <- Box.test(res7,fitdf=1,lag=2)
test8 <- Box.test(res8,fitdf=2,lag=3)

#Checking P-Values

test1$p.value
#0.1852536
test2$p.value
#0.03673714
test3$p.value
#0.0003645418
test4$p.value
#0.06282837
test5$p.value
#0.0001110724
test6$p.value
#0.0003221116
test7$p.value
#0
test8$p.value
#1.729527e-07


summary(fit1)
plot(fit1)
#We know that for a series to be stationary, the modulus of unit roots should 
#be less than or equal to 1. Since the roots lie within the unit circle, 
#the series is stationary. 
plot(ran.ts,col="blue")
lines(r,col="Red")


#------------------------------------------
# FORECASTING THE TIME SERIES
#------------------------------------------

r <- predict(fit1,n.ahead = 209)$pred

finalpred <- c(52.52981794,	52.61057205,	52.70010861,	52.80239447,	52.79268222,	
              52.93620527,	53.0407206,	53.13488741,	53.22615732,	53.31843544	,
               53.41029516,	53.5019171,	53.59335291,	53.68460743	,53.77556466	,
               53.86637247,	53.95753847,	54.04811315,54.13708736,	54.25580685	,
               54.33551098,	54.42857864,54.51827549,	54.605327,	54.69832199	,
               54.78949616,	54.87908433,	54.9686992,	55.05990067,	55.1502672,	
               55.24111416,	55.33302159,	55.4233533,	55.51401706,	55.60529388,	
               55.69659332,	55.78791291,	55.88255023,55.9739155,	56.06729057	,
               56.1689587,	56.17982765,	56.31277006,56.41570253,	56.50959877	,
               56.60081812,	56.69305918,	56.78489497,56.87652134,	56.96794485	,
               57.05920838,	57.15015519,	57.24097278,57.33212863,	57.42271324	,
               57.51167744,	57.63040671,	57.71010095,57.80317861,	57.89286549	,
               57.97992699,	58.07291199,	58.16409616,58.25368433,	58.3432992	,
               58.43450067,	58.5248572,	58.61571416,	58.70761159,	58.7979533	,
               58.88860706,	58.97989388,	59.07118332,59.16251291,	59.25714023	,
               59.3485155,	59.44188057,	59.5435587,	59.55441765,	59.68737006,	
               59.79030253,	59.88419877,59.97541812,	60.06764918,	60.15949497	,
               60.25111134,	60.34254485,	60.43379838,	60.52475519,	60.61556278,	
               60.70672863,	60.79730324,	60.88627744,	61.00499671,	61.08470095,	
               61.17776861,	61.26746549,	61.35452699,	61.44751199,	61.53869616,	
               61.62827433,	61.7178992,	61.80909067,	61.8994572,	61.99030416	,
               62.08221159,	62.1725433,	62.26320706,	62.35448388,	62.44578332,	
               62.53710291,	62.63174023,	62.7231055,	62.81648057,	62.9181587	,
               62.92901765,	63.06197006,	63.16489253,	63.25879877,	63.35000812,	
               63.44224918,	63.53408497,	63.62571134,	63.71713485,	63.80839838	,
               63.89934519,	63.99016278,	64.08131863,	64.17190324,64.26086744	,
               64.37959671,	64.45930095,	64.55236861,	64.64206549,	64.72911699,	
               64.82211199,	64.91328616,	65.00287433,	65.0924892,	65.18369067	,
               65.2740472,	65.36490416,	65.45680159,	65.5471433,	65.63779706	,
               65.72908388,	65.82037332,	65.91170291,	66.00634023,	66.0977055,	
               66.19108057,	66.2927487,	66.30361765,	66.43656006,	66.53949253	,
               66.63338877,	66.72460812,	66.81683918,	66.90868497,	67.00030134,	
               67.09173485,	67.18298838,	67.27394519,	67.36475278,	67.45591863	,
               67.54650324,	67.63546744,	67.75419671,	67.83389095,	67.92696861	,
               68.01665549,	68.10371699,	68.19670199,	68.28788616,	68.37746433	,
               68.4670892,	68.55828067,	68.6486472,	68.73949416,	68.83140159	,
               68.9217333,	69.01239706,	69.10368388,	69.19497332,	69.28630291,	
               69.38093023,	69.4723055,	69.56567057,	69.6673487,	69.67820765	,
               69.81116006,	69.91408253,	70.00798877,	70.09919812,	70.19143918,	
               70.28327497,	70.37490134,	70.46632485,	70.55758838,	70.64853519	,
               70.73935278,	70.83051863,	70.92109324,	71.01006744,	71.12878671	,
               71.20849095,	71.30155861,	71.39125549,	71.47830699)



g <- predict(fit1,n.ahead = 200000000)$pred

ts.plot(tss1,col="blue",xlim = c(1993,2021), main="Forecast")
lines(r,col="red")

plot(Fin,col="blue", main="Forecasted Global Mean Sea Level",type="l")
tail(GMSL_GIA)
a <- c(57.87611368,	54.53793438,	53.80773864,
       54.13895144,	54.04226991,	53.16167129,	53.79196195,
       53.87704662,	53.487246,	52.80307082,	52.8887654,
       52.3202257,	52.0468011,	52.80234545,	52.02680871,
       51.3170978,	51.53802753,	51.77238067)


final <- as.data.frame(t)
head(final)
final$GMSL <- GMSL_GIA
Timess <- seq(1993+(1/37),to=2025,length.out=1221)
Fin <- as.data.frame(Time)
Fin$GMSL <- c(GMSL_GIA,rep(0,139))

plot(final,xlim=c(1993,2025),type="l",col="blue")

