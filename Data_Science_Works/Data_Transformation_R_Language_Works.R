# This NoteBook is having the Works that are done using R language 

# For Data Analysis R language gives more compatability than other languages 

# the builtin packages and methods are more in this language

# Data Processing takes place in less point of time compared to other languages

# Created By Sreekanth_B

# Reading the file

# Below comand reades the new file based on the timestamp 
#useful to automatically reading the new data for model creation

date_part=gsub("[[:punct:]]","",Sys.Date())

path_op="/data/data/sreekanth_b/Input/data_folder/"

Input_L=read.csv(gsub(" ","",paste(path_op,"Input_",date_part,"_l_","File","_Data.csv")),stringsAsFactors=FALSE)

# Writting the output into csv file

write.csv(Dataframe, file = "path/MyData.csv") 

# Schema Check 
# Command gives the columns and their datatype description of dataframe
sapply(om_output,typeof)

# Packages loading
library(ggplot2)
# Packages intalling when required directly from carn repository 
install.packages('sqldf', repos='http://cran.us.r-project.org')

install.packages('sqldf')

# Count of Dataframe 

nrow(f1)

# Filtering and aggregation opperations

f1 = om_output[om_output$CALC_DATE == "2019-03-07",]

# Below command gives past 48 weeks of data for model

df1=df_output[as.Date(df_output$CALC_DATE)>= as.Date(max(df_output$CALC_DATE))-(48*7),]

# Sample aggregation functions

df2=df1[df1$METRIC=='COUNT_1' & df1$ALGO=='MA_Ribbon',]
date1=unique((df2$CALC_ID))
df3=aggregate(df2$col_NBR, by=list(Calc_id=df2$CALC_ID), FUN=sum) 
df4=df3[df3$x>15,]
length(df4$Calc_id)

df1=df_output[df_output$ALGO=='TREND_without_BB',]
df2=df1[order(df1$PRIORITY_SCORE,decreasing=TRUE),]
df3 = df2[0:5,] 



# Using SQL Query in R language using sqldf package

# In R if data set is having more values SQL quiry dont work (it will work at max of 50k r 1 lakh)

library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)

unique(df1$ENGINE_SERIES)

sd <- sqldf('SELECT COUNT(*) FROM df1')
print(sd)

st = sqldf('SELECT ENGINE_SERIES,max(CALC_DATE) FROM df1 GROUP BY ENGINE_SERIES')
print(st)

s1 = sqldf('SELECT DISTINCT(ENGINE_SERIES) FROM df1')
print(s1)

sq <- sqldf('SELECT CALC_ID,SUM(OM_NBR) FROM out GROUP BY CALC_ID having SUM(OM_NBR) >15')
print(sq)


library(sqldf)   -------- To write SQL quires
sqldf(select om_output.calc_date from om_output limit 10)

sqldf("SELECT COUNT(*) FROM df2 WHERE state = 'CA'")

sqldf("SELECT df2.firstname, df2.lastname, df1.var1, df2.state FROM df1
INNER JOIN df2 ON df1.personid = df2.id WHERE df2.state = 'TX'")

# Dplyr commands for Data wrangling

library(DBI)
library(dplyr)
library(dbplyr)

frst_s <- om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="RPH" & CALC_DATE == max(CALC_DATE) & OM_NBR>0.0005)
scnd_s <- (om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(OM_NBR)>5) %>% dplyr::group_by(CALC_ID)) 
thrd_s <-  (om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(OM_NBR)>=15) %>% dplyr::group_by(CALC_ID) 

Censor.Shipments <- shipments.to.use %>% select(engine_serial_num,Expected.Miles) %>% dplyr::filter(engine_serial_num %in% ESNs2InclFromShipments)
Censor.IncidentTracker <- MCF.Set %>% dplyr::filter(is.na(Faults))
Censor <- Censor %>% dplyr::filter(!ESN %in% Censor.ESNs)  ===== ESN not in Censor ESN's

#if ((om_output %>% dplyr::(filter(ENGINE_SERIES=="X" & OM_METRIC=="RPH" & CALC_DATE == max(CALC_DATE) & OM_NBR>0.0005) || (om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(OM_NBR)>5) %>% dplyr::group_by(CALC_ID)) || (om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(OM_NBR)>=15) %>% dplyr::group_by(CALC_ID)))
     #print(pass)

#frst_s <- om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="RPH" & CALC_DATE == max(CALC_DATE) & OM_NBR>0.0005)
     
if (nrow(om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(OM_NBR)<15))>100)
    cat ("\n Test Case 13: Passed")
    #else if (nrow(om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(OM_NBR)<=5))>100)
        #cat("y","\n")
    
    #| (as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(OM_NBR)>=15)) %>% dplyr::group_by(CALC_ID)
#stg <- om_output %>% dplyr::filter(CALC_DATE == max(CALC_DATE))  %>%  dplyr::group_by(ENGINE_SERIES)



