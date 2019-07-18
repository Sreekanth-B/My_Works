
# File consists of usage of R language in different Data analysis conditions 


============================================================= Using R on DSVM
>R

> bld_file<-read.csv("WEIBULL_2019-04-18_b_BUILD_MONTH.csv",T)
> colnames(bld_file)
>unique(bld_file$MESSAGE)
>min(bld_file$NUM_FAILURES)
=====================================================================================================================================


=====================================================================================================================================
=================================== Some usefull work done using R Language

path_op= "C:/Users/qx816/Downloads/"

om_out=read.csv(gsub(" ","",paste(path_op,"OM_MODEL_OUTPUT_2019-03-12.csv")),stringsAsFactors=FALSE,sep="|")

sapply(om_out,typeof)

library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)
library(DBI)
library(dplyr)


#if ((om_output %>% dplyr::(filter(ENGINE_SERIES=="X" & OM_METRIC=="RPH" & CALC_DATE == max(CALC_DATE) & OM_NBR>0.0005) || (om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(OM_NBR)>5) %>% dplyr::group_by(CALC_ID)) || (om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(OM_NBR)>=15) %>% dplyr::group_by(CALC_ID)))
#print(pass)
#frst_s <- om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="RPH" & CALC_DATE == max(CALC_DATE) & OM_NBR>0.0005)
e_s <-c("B","L")
df_1 <- om_out %>% dplyr::filter(ENGINE_SERIES %in% e_s & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7)) %>% dplyr::group_by(CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP)

df_2 <- sqldf('SELECT CALC_ID,sum(OM_NBR) FROM df_1 GROUP BY CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP having sum(OM_NBR)<15')

df_AA <-om_out %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7)) %>% dplyr::group_by(CALC_ID)

df_BB <- df_AA %>% dplyr ::filter(sum(OM_NBR)<15)%>% dplyr::select(CALC_ID,OM_NBR) %>% dplyr::group_by(CALC_ID,sum(OM_NBR))

for (i in 1:2)
{
  c1=0
  c2=0
  c3=0
  if (nrow(df_2)>0)
  {
    c1 = c1+1
    
    df_3 <- df_1 %>% dplyr::filter(as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7)) %>% dplyr::group_by(CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP)
    df_4 <- sqldf('SELECT CALC_ID,sum(OM_NBR) FROM df_3 GROUP BY CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP having sum(OM_NBR)<=5 and CALC_ID in (select CALC_ID from df_2)')
    #df_4 <- df_3 %>% dplyr ::filter(sum(OM_NBR)<=5) %>% dplyr::group_by(CALC_ID)
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

===================================
library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)

sd <- sqldf('SELECT CALC_ID,sum(OM_NBR) FROM df_1 GROUP BY CALC_ID having sum(OM_NBR)<15')
print(sd)


#cat ("\n Test Case 13: Passed")
#else if (nrow(om_output %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(12*7) & sum(OM_NBR)<=5))>100)
#cat("y","\n")

#| (as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7) & sum(OM_NBR)>=15)) %>% dplyr::group_by(CALC_ID)
#stg <- om_output %>% dplyr::filter(CALC_DATE == max(CALC_DATE))  %>%  dplyr::group_by(ENGINE_SERIES)

===================================================================

path_op= "C:/Users/qx816/Downloads/"

wb_fail_grp=read.csv(gsub(" ","",paste(path_op,"failmode_group_map_b.csv")),stringsAsFactors=FALSE,sep=",")

dfrm <- as.data.frame(om_output)
nrow(dfrm)

AS <- om_output[om_output$CALC_DATE == '2017-03-07']
sd <-as.Date(max(om_output$CALC_DATE))-48*7
out <- om_output[as.Date(om_output$CALC_DATE) >= sd & om_output$OM_METRIC == "COUNT_NBR" & om_output$OM_ALGO =="MA_Ribbon",]
length(unique(out$CALC_ID))
sapply(out,typeof)

library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)

sq <- sqldf('SELECT * FROM wb_fail_grp group by POPULATION,FAILMODE_GROUP ')
print(sq)
length(unique(sq$CALC_ID))
pop <- sqldf('SELECT FAILMODE_GROUP FROM sq')
spq <- sqldf('SELECT * FROM wb_fail_grp where FAILMODE_GROUP not in pop')

mid <- sqldf('SELECT POPULATION from wb_fail_grp where FAILMODE_GROUP == "LOW" and FAILMODE_GROUP == "MEDIUM"')

print(mid)

======================================================

library(plyr)
cnt <- count(om_output, c("CALC_ID"))
cnt
df1=om_output[om_output$OM_ALGO=="MA_Ribbon" & om_output$ENGINE_SERIES=="X" & om_output$OM_METRIC=="COST_NBR"  & as.Date(om_output$CALC_DATE)==as.Date(max(om_output$CALC_DATE)),]
unique(om_output$OM_SCORE_REL_BUCKET)
unique(om_output$OM_SCORE_REL_PREV_BUCKET)
unique(om_output$OM_NBR_CUMUL_BUCKET)
unique(om_output$OM_CRRT_PRIORITY_SCORE_BUCKET)
unique(df1$OM_CRRT_PRIORITY_SCORE_BUCKET) 


nrow(AS)
head(om_output)
library(ggplot2)

df1=om_output[om_output$OM_ALGO=='TREND_without_BB',]
df2=df1[order(df1$OM_CRRT_PRIORITY_SCORE,decreasing=TRUE),]
df3 = df2[0:5,] 

ggplot() + 
  geom_point(data = df3, aes( x= CODE,y = OM_CRRT_PRIORITY_SCORE), color = "red",size =2.5) +
  geom_point(data = df3, aes( x=CODE,y = OM_PREV_PRIORITY_SCORE),color="blue",size =2.5) +theme(axis.text.x = element_text(angle=90, vjust=0.6,))+
  xlab('CODES') +
  ylab('Top Priority Scores')+geom_point()+geom_segment()

unique(om_output$c)
library(sqldf)
library(gsubfn)
library(proto)
library(RSQLite)
require(sqldf)

sq <- sqldf('SELECT COUNT(*) FROM out')
print(sq)

sd <-as.Date(max(om_output$CALC_DATE))
sd
st <- sd-48*7
st
class(om_output$OM_NBR)
unique(om_output$OM_METRIC),

df <- om_output[om_output$CALC_DATE == max(om_output$CALC_DATE) & om_output$OM_METRIC == "RPH" & om_output$OM_NBR>0.0005,]
out <- om_output[as.Date(om_output$CALC_DATE) >= st,]
unique(out$OM_METRIC)
write.csv(out, file = "path/MyData.csv")

=========================================
path_op= "C:/Users/qx816/Downloads/"

om_out=read.csv(gsub(" ","",paste(path_op,"OM_MODEL_OUTPUT_2019-03-12.csv")),stringsAsFactors=FALSE,sep="|")

sapply(om_out,typeof)

library(gsubfn)
library(proto)
library(RSQLite)
library(sqldf)
library(DBI)
library(dplyr)

df_1 <- om_out %>% dplyr::filter(ENGINE_SERIES=="X" & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7)) %>% dplyr::group_by(CALC_ID)

df_2 <- sqldf('SELECT CALC_ID,sum(OM_NBR) FROM df_1 GROUP BY CALC_ID having sum(OM_NBR)<15')

#df_2 <- df_1 %>% dplyr ::filter(sum(OM_NBR)<15) %>% dplyr::group_by(CALC_ID,sum(OM_NBR))

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
    df_4 <- sqldf('SELECT CALC_ID,sum(OM_NBR) FROM df_3 GROUP BY CALC_ID having sum(OM_NBR)<=5 and CALC_ID in (select CALC_ID from df_2)')
    #df_4 <- df_3 %>% dplyr ::filter(sum(OM_NBR)<=5) %>% dplyr::group_by(CALC_ID)
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
df_1 <- om_out %>% dplyr::filter(ENGINE_SERIES %in% e_s & OM_METRIC=="COUNT_NBR" & as.Date(CALC_DATE)>= as.Date(max(CALC_DATE))-(48*7)) %>% dplyr::group_by(CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP)

df_2 <- sqldf('SELECT CALC_ID,sum(OM_NBR) FROM df_1 GROUP BY CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP having sum(OM_NBR)<15')

#df_2 <- df_1 %>% dplyr ::filter(sum(OM_NBR)<15) %>% dplyr::group_by(CALC_ID,sum(OM_NBR))

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
    df_4 <- sqldf('SELECT CALC_ID,sum(OM_NBR) FROM df_3 GROUP BY CODE,SOURCE,BUILD_YEAR,REL_USER_APPL_DESC,REL_ENGINE_NAME_DESC,ENGINE_SERIES,REL_MONTH_BUILD_DATE,REL_OEM_NORMALIZED_GROUP having sum(OM_NBR)<=5 and CALC_ID in (select CALC_ID from df_2)')
    #df_4 <- df_3 %>% dplyr ::filter(sum(OM_NBR)<=5) %>% dplyr::group_by(CALC_ID)
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
