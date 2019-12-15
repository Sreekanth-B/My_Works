library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)
library(ggplot2)

path_op1= "C:/Users/qx816/Documents/Recived_files/"
path_op2= "C:/Users/qx816/Documents/Recived_files/DEV/Filter/"
path_op3= "C:/Users/qx816/Documents/Recived_files/UAT/Filter/"

wb_b_month_DEV = read.csv(gsub(" ","",paste(path_op2,"DEV_Filter_WEIBULL_2019-04-11_l_BUILD_MONTH.csv")),stringsAsFactors=FALSE,sep=",")

wb_b_month_UAT = read.csv(gsub(" ","",paste(path_op3,"UAT_Filter_WEIBULL_2019-04-11_l_BUILD_MONTH.csv")),stringsAsFactors=FALSE,sep=",")



#----------------------------------------------------------------- RPH_MEDIAN

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="YNEB" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="YNEB" and CALC_DATE =="2019-04-11" ')

diff <- Con2_UAT$RPH_MILEAGE_MEDIAN-Con1_DEV$RPH_MILEAGE_MEDIAN
print(diff)

hist(diff)
p1 <- hist(diff,main="Difference of UAT$RPH_MILEAGE_MEDIAN - DEV$RPH_MILEAGE_MEDIAN ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$RPH_MILEAGE_MEDIAN
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$RPH_MILEAGE_MEDIAN
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.5)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_RPH_MEDIAN (RED) vs UAT_RPH_MEDIAN (Blue) ")

#----------------------------------------------------------------- RPH_UPPER_BOND

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="YNEB" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="YNEB" and CALC_DATE =="2019-04-11" ')

diff_upr <- Con2_UAT$RPH_MILEAGE_UPPER_BOUND-Con1_DEV$RPH_MILEAGE_UPPER_BOUND

hist(diff)

p1 <- hist(diff_upr,main="Difference of UAT$RPH_MILEAGE_UPPER_BOUND - DEV$RPH_MILEAGE_UPPER_BOUND ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$RPH_MILEAGE_UPPER_BOUND
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$RPH_MILEAGE_UPPER_BOUND
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.5)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_RPH_MILEAGE_UPPER_BOUND (RED) vs UAT_RPH_MILEAGE_UPPER_BOUND (Blue) ")


#======================================================================= CPE_MILEAGE_MEDIAN

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="YNEB" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="YNEB" and CALC_DATE =="2019-04-11" ')

diff_cpe_mid <- Con2_UAT$CPE_MILEAGE_MEDIAN-Con1_DEV$CPE_MILEAGE_MEDIAN

hist(diff)

p1 <- hist(diff_cpe_mid,main="Difference of UAT$CPE_MILEAGE_MEDIAN - DEV$CPE_MILEAGE_MEDIAN ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$CPE_MILEAGE_MEDIAN
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$CPE_MILEAGE_MEDIAN
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.6)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_CPE_MILEAGE_MEDIAN (RED) vs UAT_CPE_MILEAGE_MEDIAN (Blue) ")

#======================================================================= CPE_MILEAGE_UPPER_BOUND

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="YNEB" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="YNEB" and CALC_DATE =="2019-04-11" ')

diff_cpe_upr <- Con2_UAT$CPE_MILEAGE_UPPER_BOUND-Con1_DEV$CPE_MILEAGE_UPPER_BOUND

hist(diff)

p1 <- hist(diff_cpe_upr,main="Difference of UAT$CPE_MILEAGE_UPPER_BOUND - DEV$CPE_MILEAGE_UPPER_BOUND ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$CPE_MILEAGE_UPPER_BOUND
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$CPE_MILEAGE_UPPER_BOUND
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.6)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_CPE_MILEAGE_UPPER_BOUND (RED) vs UAT_CPE_MILEAGE_UPPER_BOUND (Blue) ")


#=======================================================================
#----------------------------------------------------------------- RPH_MEDIAN

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="THAC" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="THAC" and CALC_DATE =="2019-04-11" ')

diff <- Con2_UAT$RPH_MILEAGE_MEDIAN-Con1_DEV$RPH_MILEAGE_MEDIAN

hist(diff)
p1 <- hist(diff,main="Difference of UAT$RPH_MILEAGE_MEDIAN - DEV$RPH_MILEAGE_MEDIAN ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$RPH_MILEAGE_MEDIAN
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$RPH_MILEAGE_MEDIAN
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.5)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_RPH_MEDIAN (RED) vs UAT_RPH_MEDIAN (Blue) ")

#=======================================================================

#----------------------------------------------------------------- RPH_UPPER_BOND

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="THAC" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="THAC" and CALC_DATE =="2019-04-11" ')

diff_upr <- Con2_UAT$RPH_MILEAGE_UPPER_BOUND-Con1_DEV$RPH_MILEAGE_UPPER_BOUND

hist(diff)

p1 <- hist(diff_upr,main="Difference of UAT$RPH_MILEAGE_UPPER_BOUND - DEV$RPH_MILEAGE_UPPER_BOUND ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$RPH_MILEAGE_UPPER_BOUND
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$RPH_MILEAGE_UPPER_BOUND
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.5)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_RPH_MILEAGE_UPPER_BOUND (RED) vs UAT_RPH_MILEAGE_UPPER_BOUND (Blue) ")


#======================================================================= CPE_MILEAGE_MEDIAN

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="THAC" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="THAC" and CALC_DATE =="2019-04-11" ')

diff_cpe_mid <- Con2_UAT$CPE_MILEAGE_MEDIAN-Con1_DEV$CPE_MILEAGE_MEDIAN

hist(diff)

p1 <- hist(diff_cpe_mid,main="Difference of UAT$CPE_MILEAGE_MEDIAN - DEV$CPE_MILEAGE_MEDIAN ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$CPE_MILEAGE_MEDIAN
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$CPE_MILEAGE_MEDIAN
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.6)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_CPE_MILEAGE_MEDIAN (RED) vs UAT_CPE_MILEAGE_MEDIAN (Blue) ")

#======================================================================= CPE_MILEAGE_UPPER_BOUND
Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="THAC" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="THAC" and CALC_DATE =="2019-04-11" ')

diff_cpe_upr <- Con2_UAT$CPE_MILEAGE_UPPER_BOUND-Con1_DEV$CPE_MILEAGE_UPPER_BOUND

hist(diff)

p1 <- hist(diff_cpe_upr,main="Difference of UAT$CPE_MILEAGE_UPPER_BOUND - DEV$CPE_MILEAGE_UPPER_BOUND ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$CPE_MILEAGE_UPPER_BOUND
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$CPE_MILEAGE_UPPER_BOUND
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.6)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_CPE_MILEAGE_UPPER_BOUND (RED) vs UAT_CPE_MILEAGE_UPPER_BOUND (Blue) ")


#=======================================================================
#----------------------------------------------------------------- RPH_MEDIAN

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="THAS" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="THAS" and CALC_DATE =="2019-04-11" ')

diff <- Con2_UAT$RPH_MILEAGE_MEDIAN-Con1_DEV$RPH_MILEAGE_MEDIAN

hist(diff)
p1 <- hist(diff,main="Difference of UAT$RPH_MILEAGE_MEDIAN - DEV$RPH_MILEAGE_MEDIAN ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$RPH_MILEAGE_MEDIAN
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$RPH_MILEAGE_MEDIAN
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.5)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_RPH_MEDIAN (RED) vs UAT_RPH_MEDIAN (Blue) ")

#=======================================================================

#----------------------------------------------------------------- RPH_UPPER_BOND

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="THAS" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="THAS" and CALC_DATE =="2019-04-11" ')

diff_upr <- Con2_UAT$RPH_MILEAGE_UPPER_BOUND-Con1_DEV$RPH_MILEAGE_UPPER_BOUND

hist(diff)

p1 <- hist(diff_upr,main="Difference of UAT$RPH_MILEAGE_UPPER_BOUND - DEV$RPH_MILEAGE_UPPER_BOUND ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$RPH_MILEAGE_UPPER_BOUND
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$RPH_MILEAGE_UPPER_BOUND
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.5)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_RPH_MILEAGE_UPPER_BOUND (RED) vs UAT_RPH_MILEAGE_UPPER_BOUND (Blue) ")


#======================================================================= CPE_MILEAGE_MEDIAN

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="THAS" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="THAS" and CALC_DATE =="2019-04-11" ')

diff_cpe_mid <- Con2_UAT$CPE_MILEAGE_MEDIAN-Con1_DEV$CPE_MILEAGE_MEDIAN

hist(diff)

p1 <- hist(diff_cpe_mid,main="Difference of UAT$CPE_MILEAGE_MEDIAN - DEV$CPE_MILEAGE_MEDIAN ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$CPE_MILEAGE_MEDIAN
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$CPE_MILEAGE_MEDIAN
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.6)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_CPE_MILEAGE_MEDIAN (RED) vs UAT_CPE_MILEAGE_MEDIAN (Blue) ")

#======================================================================= CPE_MILEAGE_UPPER_BOUND


Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="THAS" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="THAS" and CALC_DATE =="2019-04-11" ')

diff_cpe_upr <- Con2_UAT$CPE_MILEAGE_UPPER_BOUND-Con1_DEV$CPE_MILEAGE_UPPER_BOUND

hist(diff)

p1 <- hist(diff_cpe_upr,main="Difference of UAT$CPE_MILEAGE_UPPER_BOUND - DEV$CPE_MILEAGE_UPPER_BOUND ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$CPE_MILEAGE_UPPER_BOUND
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$CPE_MILEAGE_UPPER_BOUND
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.6)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_CPE_MILEAGE_UPPER_BOUND (RED) vs UAT_CPE_MILEAGE_UPPER_BOUND (Blue) ")

#=======================================================================
#----------------------------------------------------------------- RPH_MEDIAN

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="EICM" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="EICM" and CALC_DATE =="2019-04-11" ')

diff <- Con2_UAT$RPH_MILEAGE_MEDIAN-Con1_DEV$RPH_MILEAGE_MEDIAN

hist(diff)
p1 <- hist(diff,main="Difference of UAT$RPH_MILEAGE_MEDIAN - DEV$RPH_MILEAGE_MEDIAN ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$RPH_MILEAGE_MEDIAN
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$RPH_MILEAGE_MEDIAN
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.5)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_RPH_MEDIAN (RED) vs UAT_RPH_MEDIAN (Blue) ")

#=======================================================================

#----------------------------------------------------------------- RPH_UPPER_BOND

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="EICM" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="EICM" and CALC_DATE =="2019-04-11" ')

diff_upr <- Con2_UAT$RPH_MILEAGE_UPPER_BOUND-Con1_DEV$RPH_MILEAGE_UPPER_BOUND

hist(diff)

p1 <- hist(diff_upr,main="Difference of UAT$RPH_MILEAGE_UPPER_BOUND - DEV$RPH_MILEAGE_UPPER_BOUND ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$RPH_MILEAGE_UPPER_BOUND
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$RPH_MILEAGE_UPPER_BOUND
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.5)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_RPH_MILEAGE_UPPER_BOUND (RED) vs UAT_RPH_MILEAGE_UPPER_BOUND (Blue) ")


#======================================================================= CPE_MILEAGE_MEDIAN

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="EICM" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="EICM" and CALC_DATE =="2019-04-11" ')

diff_cpe_mid <- Con2_UAT$CPE_MILEAGE_MEDIAN-Con1_DEV$CPE_MILEAGE_MEDIAN

hist(diff)

p1 <- hist(diff_cpe_mid,main="Difference of UAT$CPE_MILEAGE_MEDIAN - DEV$CPE_MILEAGE_MEDIAN ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$CPE_MILEAGE_MEDIAN
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$CPE_MILEAGE_MEDIAN
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.6)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_CPE_MILEAGE_MEDIAN (RED) vs UAT_CPE_MILEAGE_MEDIAN (Blue) ")

#======================================================================= CPE_MILEAGE_UPPER_BOUND

Con1_DEV <- sqldf('SELECT * from wb_b_month_DEV where CODE =="EICM" and CALC_DATE =="2019-04-11" ')

Con2_UAT <- sqldf('SELECT * from wb_b_month_UAT where CODE =="EICM" and CALC_DATE =="2019-04-11" ')

diff_cpe_upr <- Con2_UAT$CPE_MILEAGE_UPPER_BOUND-Con1_DEV$CPE_MILEAGE_UPPER_BOUND

hist(diff)

p1 <- hist(diff_cpe_upr,main="Difference of UAT$CPE_MILEAGE_UPPER_BOUND - DEV$CPE_MILEAGE_UPPER_BOUND ",xlab="Difference",
           col="gray")

df <- c()
df$DEV_RPH_MEDIAN<-Con1_DEV$CPE_MILEAGE_UPPER_BOUND
df<-as.data.frame(df)
df$UAT_RPH_MEDIAN<-Con2_UAT$CPE_MILEAGE_UPPER_BOUND
plot(df$DEV_RPH_MEDIAN,type="o",col="red",lwd =1.6)
lines(df$UAT_RPH_MEDIAN,type="o",col="blue" , lwd =1)
title("Comparission of DEV_CPE_MILEAGE_UPPER_BOUND (RED) vs UAT_CPE_MILEAGE_UPPER_BOUND (Blue) ")


