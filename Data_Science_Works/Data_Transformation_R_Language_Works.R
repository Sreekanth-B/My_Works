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

o_output=read.csv(gsub(" ","",paste(path_op,"Input_",date_part,"_l_","File","_Data.csv")),stringsAsFactors=FALSE)

# Writting the output into csv file

write.csv(Dataframe, file = "path/MyData.csv") 

# Schema Check 
# Command gives the columns and their datatype description of dataframe
sapply(o_output,typeof)

# Packages loading
library(ggplot2)
# Packages intalling when required directly from carn repository 
install.packages('sqldf', repos='http://cran.us.r-project.org')

install.packages('sqldf')

# Count of Dataframe 

nrow(f1)

# Filtering and aggregation opperations

f1 = o_output[o_output$CALC_DATE == "2019-03-07",]

# Below command gives past 48 weeks of data for model

df1=df_output[as.Date(df_output$CALC_DATE)>= as.Date(max(df_output$CALC_DATE))-(48*7),]

# Sample aggregation functions

df2=df1[df1$MET=='COUNT_1' & df1$COL_Alg=='MAR',]
date1=unique((df2$CALC_ID))
df3=aggregate(df2$col_NR, by=list(Calc_id=df2$CALC_ID), FUN=sum) 
df4=df3[df3$x>15,]
length(df4$Calc_id)

df1=df_output[df_output$COL_A=='A_B',]
df2=df1[order(df1$COL_P,decreasing=TRUE),]
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

st = sqldf('SELECT E_S,max(CALC_DATE) FROM df1 GROUP BY E_S')
print(st)

s1 = sqldf('SELECT DISTINCT(E_S) FROM df1')
print(s1)

sq <- sqldf('SELECT CALC_ID,SUM(A_S) FROM out GROUP BY CALC_ID having SUM(VAL) >15')
print(sq)


library(sqldf)   -------- To write SQL quires
sqldf(select database.table from om_output limit 10)

sqldf("SELECT COUNT(*) FROM df2 WHERE state = 'CA'")

sqldf("SELECT df2.firstname, df2.lastname, df1.var1, df2.state FROM df1
INNER JOIN df2 ON df1.personid = df2.id WHERE df2.state = 'TX'")

# Dplyr commands for Data wrangling

library(DBI)
library(dplyr)
library(dbplyr)

frst_s <- o_output %>% dplyr::filter(E_S=="A" & A_S=="H" & CALC_DATE == max(CALC_DATE) & VAL>0.0005)
scnd_s <- (o_output %>% dplyr::filter(E_S=="B" & A_S=="I" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(VAL)>5) %>% dplyr::group_by(CALC_ID)) 
thrd_s <-  (o_output %>% dplyr::filter(E_S=="C" & A_S=="J" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(VAL)>=15) %>% dplyr::group_by(CALC_ID) 

Censor.Shipments <- shipments.to.use %>% select(E_S_N,COl_2) %>% dplyr::filter(E_S_N %in% ESNs2InclFromShipments)
Censor.IncidentTracker <- MCF.Set %>% dplyr::filter(is.na(Faults))
Censor <- Censor %>% dplyr::filter(!ESN %in% Censor.ESNs)  ===== ESN not in Censor ESN's

#if ((o_output %>% dplyr::(filter(E_S=="A" & A_S=="H" & CALC_DATE == max(CALC_DATE) & VAL>0.0005) || (o_output %>% dplyr::filter(E_S=="B" & A_S=="H" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(VAL)>5) %>% dplyr::group_by(CALC_ID)) || (o_output %>% dplyr::filter(E_S=="A" & A_S=="H" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(VAL)>=15) %>% dplyr::group_by(CALC_ID)))
     #print(pass)

     
if (nrow(o_output %>% dplyr::filter(E_S=="A" & A_S=="H" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(VAL)<15))>100)
    cat ("\n Scenario Case 13: Passed")
    #else if (nrow(om_output %>% dplyr::filter(E_S=="A" & A_S=="H" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(VAL)<=5))>100)
        #cat("y","\n")
    
    #| (as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(VAL)>=15)) %>% dplyr::group_by(CALC_ID)
#stg <- o_output %>% dplyr::filter(CALC_DATE == max(CALC_DATE))  %>%  dplyr::group_by(ENGINE_SERIES)



