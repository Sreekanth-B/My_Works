
# File consists of usage of R language in different Data analysis conditions 


=====================================================================================================================================


# Getting All the files from the path which are ending with .csv with complete file name

files = list.files("/home/user/notebooks/model_output_X/", pattern="*.csv", full.names = T)

# Appending all the above csv files into one single file

X_input_file = do.call(rbind, lapply(files, fread))

=====================================================================================================================================

============================================================ Using R on DSVM
// opening the R concole
>R

// reading the csv file into R Data frame
> ot_file<-read.csv("Model_output_1.csv",T)

// getting the column names from dataframe 
> colnames(ot_file)

// printing the unique values from the column of the dataframe
>unique(ot_file$col_1)

// getting the minimun value of the column in the dataframe
>min(ot_file$col_2)
=====================================================================================================================================

=====================================================================================================================================
=================================== Some usefull work done using R Language
# Readin the file into R Dataframe
path_op= "C:/Users/Downloads/"

ot_out=read.csv(gsub(" ","",paste(path_op,"MODEL_OUTPUT_X.csv")),stringsAsFactors=FALSE,sep="|")

sapply(ot_out,typeof)
			
nrow(AS)
head(ot_output)

# Installing the required packages for operations
library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)
library(DBI)
library(dplyr)

 # Write the results into a CSV file
 write.csv(finalResults,"results.csv",row.names = FALSE)

-====================== For loop in R

for (unique.group in 1:length(unique(daysDiffData$main_group)))
  {
  }
  

===== reading excel with sheetwise ******

install.packages('readxl')
library(readxl)
try_xl <- readxl::read_xlsx("C:/Users/Downloads/sample_out.xlsx",sheet = 1)
=========================================================================================================================================================
========== Importing all csv files from one location and binding into one dataframe
files <- list.files(path = "C:/Users/ku906/Documents/insite_miles.csv", pattern = ".csv")
files <- file.path("C:/Users/ku906/Documents/insite_miles.csv",files)
myfiles <- lapply(files, read.csv, header=T, stringsAsFactors = F)
insite.data <- do.call(what = rbind.data.frame,args = myfiles)
insite.data$VALUE <- as.numeric(insite.data$VALUE)
insite.data$DATES <- as.Date(insite.data$DATES)
insite.data.rev <- insite.data %>% dplyr::distinct(.)
insite.data.rev$ESN <- as.factor(insite.data.rev$ESN)

========= OR
# Get the files names
files = list.files(pattern="*.csv")
# First apply read.csv, then rbind
myfiles = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

========================== To select Randomly From dataframe in R

ok <- ot_output[sample(nrow(ot_output),1000),]
				
				
====== rbinding of two dfs

final <- rbind.data.frame(1st_dataset,2nd_dataset)

=====================================================================================================================================
# Rename columns in the "Fault Code Info" file
  names(fcData)[1] <- paste("fault.code")
  names(fcData)[2] <- paste("description")
  
# Covert type of the description field from factor to character
  fcData$fault.code  <- as.character(fcData$fault.code)
  fcData$description <- as.character(fcData$description)

==============================================================================================
library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)

# using the SQL commands directly on data in R
sd <- sqldf('SELECT CALC_ID,sum(VAL) FROM df_1 GROUP BY CALC_ID having sum(VAL)<15')
print(sd)

=====================================================================================================================================

# Performing the Data tranformation operations

#if ((ot_out %>% dplyr::(filter(E_S=="X" & Met_a=="H" & CALC_DATE == max(CALC_DATE) & VAL>0.0005) || (ot_out %>% dplyr::filter(E_S=="X" & Met_a=="J" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(VAL)>5) %>% dplyr::group_by(CALC_ID)) || (ot_out %>% dplyr::filter(E_S=="X" & Met_a=="J" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(VAL)>=15) %>% dplyr::group_by(CALC_ID)))
#print(pass)
#frst_s <- ot_output %>% dplyr::filter(E_S=="X" & Met_a=="H" & CALC_DATE == max(CALC_DATE) & VAL>0.0005)
e_s <-c("B","L")
df_1 <- om_out %>% dplyr::filter(E_S %in% e_s & Met_a=="J" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7)) %>% dplyr::group_by(CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP)

df_2 <- sqldf('SELECT CALC_ID,sum(VAL) FROM df_1 GROUP BY CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,E_S,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP having sum(VAL)<15')

df_AA <-om_out %>% dplyr::filter(E_S=="X" & Met_a=="J" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7)) %>% dplyr::group_by(CALC_ID)

df_BB <- df_AA %>% dplyr ::filter(sum(VAL)<15)%>% dplyr::select(CALC_ID,VAL) %>% dplyr::group_by(CALC_ID,sum(VAL))

for (i in 1:2)
{
  c1=0
  c2=0
  c3=0
  if (nrow(df_2)>0)
  {
    c1 = c1+1
    
    df_3 <- df_1 %>% dplyr::filter(as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7)) %>% dplyr::group_by(CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP)
    df_4 <- sqldf('SELECT CALC_ID,sum(VAL) FROM df_3 GROUP BY CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP having sum(VAL)<=5 and CALC_ID in (select CALC_ID from df_2)')
    #df_4 <- df_3 %>% dplyr ::filter(sum(VAL)<=5) %>% dplyr::group_by(CALC_ID)
    if (nrow(df_4)>0)
    {
      c2 =c2+1
    }
    if(nrow(df_4)==0){
      c3 = c3+1
    }
  }
}
print(c1)
print(c2)
print(c3)
if (c1 <1)
{
  cat("\n scenario 2 pass")
}
if(c2 <1)
{
  cat("\n scenario 3 pass")  
}
if (c1 >=1)
{
  cat("\n scenario 2 failed")
}
if (c2 >=1)
{
  cat("\n ALL scenario 3 failed")
}
if(c3>=1)
{
  cat("\n No data present for df after 2nd scenario for 3rd scenario")
}

#cat ("\n Test Case 13: Passed")
#else if (nrow(ot_output %>% dplyr::filter(ENGINE_SERIES=="X" & Met_a=="J" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(VAL)<=5))>100)
#cat("y","\n")

#| (as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(VAL)>=15)) %>% dplyr::group_by(CALC_ID)
#stg <- ot_output %>% dplyr::filter(CALC_DATE == max(CALC_DATE))  %>%  dplyr::group_by(ENGINE_SERIES)

===================================================================

path_op= "C:/Users/qx816/Downloads/"

fail_grp=read.csv(gsub(" ","",paste(path_op,"failmode_group_map_b.csv")),stringsAsFactors=FALSE,sep=",")

dfrm <- as.data.frame(ot_output)
nrow(dfrm)

AS <- ot_output[ot_output$CALC_DATE == '2017-03-07']
sd <-as.Date(max(ot_output$CALC_DATE))-48*7
out <- ot_output[as.Date(ot_output$CALC_DATE) >= sd & ot_output$Met_a == "J" & ot_output$ALG =="MA_R",]
length(unique(out$CALC_ID))
sapply(out,typeof)

library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)

sq <- sqldf('SELECT * FROM fail_grp group by POPULATION,FAILMODE_GROUP ')
print(sq)
length(unique(sq$CALC_ID))
pop <- sqldf('SELECT FAILMODE_GROUP FROM sq')
spq <- sqldf('SELECT * FROM fail_grp where FAILMODE_GROUP not in pop')

mid <- sqldf('SELECT POPULATION from fail_grp where FAILMODE_GROUP == "LOW" and FAILMODE_GROUP == "MEDIUM"')

print(mid)

======================================================

library(plyr)
cnt <- count(ot_output, c("CALC_ID"))
cnt
df1=ot_output[ot_output$ALG=="MA_R" & ot_output$E_S=="X" & ot_output$Met_a=="COST_NBR"  & as.Date(ot_output$CALC_DATE)==as.Date(max(ot_output$CALC_DATE)),]
unique(ot_output$col_1)
unique(ot_output$col_2)
unique(ot_output$col_3)
unique(ot_output$col_4)
unique(df1$col_5) 

library(ggplot2)

df1=ot_output[ot_output$OM_ALGO=='TREND_without_BB',]
df2=df1[order(df1$OM_CRRT_PRIORITY_SCORE,decreasing=TRUE),]
df3 = df2[0:5,] 

ggplot() + 
  geom_point(data = df3, aes( x= CODE,y = OM_CRRT_PRIORITY_SCORE), color = "red",size =2.5) +
  geom_point(data = df3, aes( x=CODE,y = OM_PREV_PRIORITY_SCORE),color="blue",size =2.5) +theme(axis.text.x = element_text(angle=90, vjust=0.6,))+
  xlab('CODES') +
  ylab('Top Priority Scores')+geom_point()+geom_segment()

unique(ot_output$c)
library(sqldf)
library(gsubfn)
library(proto)
library(RSQLite)
require(sqldf)

sq <- sqldf('SELECT COUNT(*) FROM out')
print(sq)

sd <-as.Date(max(ot_output$CALC_DATE))
sd
st <- sd-48*7
st
class(ot_output$VAL)
unique(ot_output$Met_a),

df <- ot_output[ot_output$CALC_DATE == max(ot_output$CALC_DATE) & ot_output$Met_a == "H" & ot_output$VAL>0.0005,]
out <- ot_output[as.Date(ot_output$CALC_DATE) >= st,]
unique(out$Met_a)
write.csv(out, file = "path/MyData.csv")

=========================================
path_op= "C:/Users/qx816/Downloads/"

om_out=read.csv(gsub(" ","",paste(path_op,"MODEL_OUTPUT_S.csv")),stringsAsFactors=FALSE,sep="|")

sapply(om_out,typeof)

library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)
library(DBI)
library(dplyr)

df_1 <- om_out %>% dplyr::filter(E_S=="X" & Met_a=="J" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7)) %>% dplyr::group_by(CALC_ID)

df_2 <- sqldf('SELECT CALC_ID,sum(VAL) FROM df_1 GROUP BY CALC_ID having sum(VAL)<15')

#df_2 <- df_1 %>% dplyr ::filter(sum(VAL)<15) %>% dplyr::group_by(CALC_ID,sum(VAL))

for (i in 1:2)
{
  c1=0
  c2=0
  c3=0
  if (nrow(df_2)>0)
  {
    c1 = c1+1
    clc_id <- (df_2$CALC_ID[i])
    df_3 <- df_1 %>% dplyr::filter(as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7)) %>% dplyr::group_by(CALC_ID)
    df_4 <- sqldf('SELECT CALC_ID,sum(VAL) FROM df_3 GROUP BY CALC_ID having sum(VAL)<=5 and CALC_ID in (select CALC_ID from df_2)')
    #df_4 <- df_3 %>% dplyr ::filter(sum(VAL)<=5) %>% dplyr::group_by(CALC_ID)
    if (nrow(df_4)>0)
    {
      c2 =c2+1
    }
    if(nrow(df_4)==0){
      c3 = c3+1
    }
  }
}
print(c1)
print(c2)
print(c3)
if (c1 <1)
{
  cat("\n scenario 2 pass")
}
if(c2 <1)
{
  cat("\n scenario 3 pass")  
}
if (c1 >=1)
{
  cat("\n scenario 2 failed")
}
if (c2 >=1)
{
  cat("\n ALL scenario 3 failed")
}
if(c3>=1)
{
  cat("\n No data present for df after 2nd scenario for 3rd scenario")
}



e_s <-c("B","L")
df_1 <- om_out %>% dplyr::filter(E_S %in% e_s & Met_a=="J" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7)) %>% dplyr::group_by(CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP)

df_2 <- sqldf('SELECT CALC_ID,sum(VAL) FROM df_1 GROUP BY col_1,col_2,col_3,col_4,col_5,col_6 having sum(VAL)<15')

#df_2 <- df_1 %>% dplyr ::filter(sum(VAL)<15) %>% dplyr::group_by(CALC_ID,sum(VAL))

for (i in 1:2)
{
  c1=0
  c2=0
  c3=0
  if (nrow(df_2)>0)
  {
    c1 = c1+1
    clc_id <- (df_2$CALC_ID[i])
    df_3 <- df_1 %>% dplyr::filter(as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7)) %>% dplyr::group_by(CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP)
    df_4 <- sqldf('SELECT CALC_ID,sum(VAL) FROM df_3 GROUP BY col_1,col_2,col_3,col_4,col_5,col_6 having sum(VAL)<=5 and CALC_ID in (select CALC_ID from df_2)')
    #df_4 <- df_3 %>% dplyr ::filter(sum(VAL)<=5) %>% dplyr::group_by(CALC_ID)
    if (nrow(df_4)>0)
    {
      c2 =c2+1
    }
    if(nrow(df_4)==0){
      c3 = c3+1
    }
  }
}
print(c1)
print(c2)
print(c3)
if (c1 <1)
{
  cat("\n scenario 2 pass")
}
if(c2 <1)
{
  cat("\n scenario 3 pass")  
}
if (c1 >=1)
{
  cat("\n scenario 2 failed")
}
if (c2 >=1)
{
  cat("\n ALL scenario 3 failed")
}
if(c3>=1)
{
  cat("\n No data present for df after 2nd scenario for 3rd scenario")
}



# Basic Setup ------------------------------------------------------------------------------------------------
cat("\014") #clears screen
graphics.off() # clears old plots
rm(list=ls()) # removes all objects
setwd("~/Product_Quality") # Set current location, where clustering results have been stored
=====================================================================================================================================
============= How to collect data from cluster using R 
# Data

Data was retrieved from the server "SDWPSQL6001/CAPABILITYDB" server. This has not been brought into the cluster. Need be, this can be done. 

```{r}
con <- odbc::dbConnect(odbc::odbc(), dsn = "Capability",Database = "HDPacific")
RYG_tbl <- dplyr::tbl(con,"qryRYG_New2")
Error_tbl <- dplyr::tbl(con,"tblErrorTable") %>% select(FaultCode,SoftwareVersion,SystemErrorName)
RYG.Data <- dplyr::left_join(RYG_tbl,Error_tbl,by = c("Error_Name" = "SystemErrorName", "CalibrationVersion" = "SoftwareVersion")) %>% 
  dplyr::collect()


# write.csv(RYG.Data,file = "RYGData.csv",row.names = F)
# RYG.Data <- read.csv(file = "RYGData.csv")

skimr::skim(RYG.Data)
=====================================================================================================================================


# Load libraries ---------------------------------------------------------------------------------------------
library("dplyr")
# Load data --------------------------------------------------------------------------------------------------
rawdata <- read.csv(file = "clustering_v2.csv")

# Get Cluster & associate Fail Code count (except where Fail code is "Unknown") 
interim_data <- filter(rawdata,Fail.Code!="Unknown") %>% group_by(Cluster_ID,Fail.Code) %>% summarise(cluster_fail_count=n())

# Get the total count of each Fail Code from "rawdata"
fail_data <- filter(rawdata) %>% group_by(Fail.Code) %>% summarise(total_fail_count=n())

# Join "interim_data" with "fail_data"
interim_data <- left_join(interim_data,fail_data,by="Fail.Code")

# Sort the above data in desc order of issue_count
highest_incidents1 <- highest_incidents[order(-highest_incidents$issue_count),]
=====================================================================================================================================

=====================================================================================================================================
# Convert into %age terms and round it to two decimal points
interim_data$pect_occr <- interim_data$pect_occr * 100
interim_data$pect_occr <- round(interim_data$pect_occr,2)

# Give descriptive names to all the columns ====== To Rename the Column
names(interim_data)[1] <- paste("Cluster_ID")
names(interim_data)[2] <- paste("Most Occuring Fail Code in Cluster")
=====================================================================================================================================
# Write the result into a CSV
write.csv(interim_data,"Clustering_Analysis.csv",row.names = FALSE)

write.table(MyData, file = "MyData.csv",row.names=FALSE, na="",col.names=FALSE, sep=",")

 # Calculate days difference column and perfome other cleansing procesess
  finalResults$days.diff <- finalResults$Earliest.Indication.Date - finalResults$lag.date
  finalResults$days.diff[is.na(finalResults$days.diff)] <- "" 
  finalResults$lag.date <- NULL 
  
  # Write the results into a CSV file
  write.csv(finalResults,"results.csv",row.names = FALSE)
  
=====================================================================================================================================
library(changepoint)
library(dplyr)
library(readr)

telematics_joined <- read_csv("C:/Users/oz234/telematics_joined/telematics_joined.csv", 
    col_types = cols(X1 = col_skip(), engine_serial_num = col_skip(), 
        occurrence_date = col_date(format = "%m/%d/%Y")))

library(hydroTSM)
plot(cpt.meanvar(with((telematics_filtered %>%
                         dplyr::filter(fault_code == 559) %>%
                         dplyr::group_by(date_week) %>%
                         dplyr::summarise(count = length(date_week)) %>%
                         dplyr::arrange(date_week)), zoo(count, date_week)),
                 test.stat='Poisson',
                 method='PELT',
                 penalty="BIC"),
     col = "darkgreen",
     lwd = 2,
     cpt.col='red',
     cpt.width = 3,
     main = "Fault Code 559",
     ylab = "Count",
     xlab = "Time",
     xaxt ="n")

	 
======== filtering colum values which are not there in other table column
	 
esnFaultCodeCombined <- dplyr::filter(esnFaultCodeCombined, !(unique.identifier %in% unique.identifier.1))	

========= Sorting the table based on Earliest.Indication.Date column

esnFaultCodeCombined <- esnFaultCodeCombined[order(esnFaultCodeCombined$Earliest.Indication.Date), ] 

------ Rbinding in R

# Rbind the datasets 

esnFaultCodeCombined <- rbind.data.frame(esnFaultCodeCombined_1, esnFaultCodeCombined_2)

===============
# For each ESN, we will create a flag that will help get the lag date specific to that ESN only 
      esnFaultCodeCombined$group.lag <- cumsum(c(0,as.numeric(diff(esnFaultCodeCombined$fault_code)) != 0))
      esnFaultCodeCombined <- esnFaultCodeCombined %>% dplyr::group_by(ESN,group.lag) %>% 
        dplyr::mutate(lag.date = dplyr::lag(Earliest.Indication.Date, n = 1, default = NA))
		
-- IN Above

diff == Example
temp = c(10,1,1,1,1,1,1,2,1,1,1,1,1,1,1,3,10)
diff(temp)
output:
[1] -9  0  0  0  0  0  1 -1  0  0  0  0  0  0  2  7
analysis ::

 1 - 10 = -9
 1 -  1 =  0
 1 -  1 =  0
.
.
.
 3 -  1 =  2
10 -  3 =  7
((MOving from back))

diff(temp, differences = 2) 
[1]  9  0  0  0  0  1 -2  1  0  0  0  0  0  2  5

diff(diff(temp))
[1]  9  0  0  0  0  1 -2  1  0  0  0  0  0  2  5
diff(temp, lag = 2)
[1] -9  0  0  0  0  1  0 -1  0  0  0  0  0  2  9
For example, if lag = 2, the differences between the third and the first value, 
between the fourth and the second value, between the fifth and the third value etc.

----======= Replacing na with ""

finalResults$days.diff <- finalResults$Earliest.Indication.Date - finalResults$lag.date
  finalResults$days.diff[is.na(finalResults$days.diff)] <- "" 
=====================================================================================================================================
============= Left outer join in R
RYG.Data <- dplyr::left_join(RYG_tbl,Error_tbl,by = c("Error_Name" = "SystemErrorName", "CalibrationVersion" = "SoftwareVersion")) %>% 
  dplyr::collect()
 
## here RYG_tbl,Error_tbl are tables to join in left outer and inside by = c() we need to mention columns

=== skimr::skim(RYG.Data) 
skim gives detailed summery of each columns present in dataset with histogram plots for respective columns also


=====================================================================================================================================
========= Creating Dummy values
below code do create column Data if category column values is "R" it takes 1 as value and if it is "Y" the number will be 2,3
 
RYG.Data <- RYG.Data %>% mutate(Cat = ifelse(Category == "R",1,ifelse(Category == "Y",2,3)))


=====================================================================================================================================
======== Ploting basics 

lattice::histogram(RYG.Data$DaysOfData,xlab = "Day of Data") 

## THis is usefull for creating histogram plot on RYG.Data 
