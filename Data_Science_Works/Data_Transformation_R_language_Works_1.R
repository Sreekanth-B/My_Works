# Below function gives the count of negative values present in the columns of data frame


date_part=gsub("[[:punct:]]","",Sys.Date())

source("/home/qx816/notebooks/qx816_Weibull/ds/Weibull/weibull_testscripts_L.R")
path_op="/data/data/Sreekanth_B/model_input/upload_folder/"

output_L=read.csv(gsub(" ","",paste(path_op,"Input_1",date_part,"_l_","final_","_BUILD.csv")),stringsAsFactors=FALSE)

check_cpe_L= function(df_output){
    
    print(length(which(df_output$col_1 <0)))
    print(length(which(df_output$col_2 <0)))
    print(length(which(df_output$col_3 <0)))
    print(length(which(df_output$col_4 <0)))
    print(length(which(df_output$col_5 <0)))
    print(length(which(df_output$col_6 <0)))
    
    #df1 <- which(df_output$CPE_MEDIAN <0)
    #length(df)
}

check_cpe_L(output_L)


# Below are the Validation functions used for Data science Models

cat("Testing Log Files",file="Log_File_test.log",append=FALSE)

library(dplyr)
library(data.table)

#1.Validate the Scenario 1 in output data
test_engine_type_output=function(df_output){
  Col_type=unique(df_output$E_S)
  if(("B" %in% Col_type) & ("L" %in% Col_type) & ("X" %in% Col_type) &(length(Col_type)==3))
  {
    cat("\n Test Case 1: Passed-Engine Types are 'X','B','L' ", file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 1: Failed-Engine Types are not 'X','B','L'", file= "Log_File_test.log",append=TRUE)
  }
}

#2.Validate the Scenario 1  in input data-om_stats
test_engine_type=function(df_input){
  Col_type=unique(df_input$E_S)
  if(("B" %in% Col_type) & ("L" %in% Col_type) & ("X" %in% Col_type) &(length(Col_type)==3))
  {
    cat("\n Test Case 2: Passed-Engine Types are 'X','B','L' ",Col_type, file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 2: Failed-Engine Types are not 'X','B','L'",Col_type, file= "Log_File_test.log",append=TRUE)
  }
}
#3.Check Max date and min date and check if the data is present for every week-for X input
test_date_count_data = function(df_input){
  unique_CODE_ID=unique(df_input$CODE)
  test_sample_code=sample(unique_CODE_ID,10,replace=FALSE)
  status=0
  for(i in 1:length(test_sample_code)){
    status=test_calc_ID_data(df_input,test_sample_code[i])
  } 
  if(status==1)
  {cat("\n Test case 3 passed:X input",file="Log_File_test.log",append=TRUE)}
  else
  {cat("\n Test Case 3 failed:X input Data is not Present for every week",file="Log_File_test.log",append=TRUE)}
}

test_calc_ID_data=function(df,CODE){
  data_cal=df[df$CODE==CODE,]
  max_date=max(as.Date(data_cal$CALC_DATE))
  min_date=min(as.Date(data_cal$CALC_DATE))
  date_strings=c(min_date,max_date)
  diff_in_weeks = difftime(date_strings[2],date_strings[1], units = "weeks")
  #diff_in_days=diff_in_weeks/7
  unique_caldate=unique(data_cal$CALC_DATE)
  CAL_DATE_Count=length(unique(data_cal$CALC_DATE))-1
  if(CAL_DATE_Count==diff_in_weeks)
  {
    return(1)
  }
  else
    return(0)
} 

#4.Check Max date and min date and check if the data is present for every week-for B-typo_e input
test_date_count_data_B_E = function(df_input){
  df_input=df_input[df_input$REL_CMP_ENGINE_NAME=="B",]  
  unique_CODE_ID=unique(df_input$CODE)
  #test_sample_code=sample(unique_CODE_ID,10,replace=FALSE)
  status=0
  for(i in 1:length(unique_CODE_ID)){
    status=test_calc_ID_data(df_input,unique_CODE_ID[i])
  } 
  if(status==1)
  {cat("\n Test case 4 passed:B-Emission",file="Log_File_test.log",append=TRUE)}
  else
  {cat("\n Test Case 4 failed:B-Emission Data is not Present for every week",file="Log_File_test.log",append=TRUE)}
}

test_calc_ID_data=function(df,CODE){
  data_cal=df[df$CODE==CODE,]
  max_date=max(as.Date(data_cal$CALC_DATE))
  min_date=min(as.Date(data_cal$CALC_DATE))
  date_strings=c(min_date,max_date)
  diff_in_weeks = difftime(date_strings[2],date_strings[1], units = "weeks")
  #diff_in_days=diff_in_weeks/7
  unique_caldate=unique(data_cal$CALC_DATE)
  CAL_DATE_Count=length(unique(data_cal$CALC_DATE))-1
  if(CAL_DATE_Count==diff_in_weeks)
  {
    return(1)
  }
  else
    return(0)
}

#5.Check Max date and min date and check if the data is present for every week-for B-warranty input
test_date_count_data_B_W = function(df_input){
   df_input=df_input[df_input$Name=="B",] 
  unique_CODE_ID=unique(df_input$CODE)
  #test_sample_code=sample(unique_CODE_ID,10,replace=FALSE)
  status=0
  for(i in 1:length(unique_CODE_ID)){
    status=test_calc_ID_data(df_input,unique_CODE_ID[i])
  } 
  if(status==1)
  {cat("\n Test case 5 passed:B-Warranty",file="Log_File_test.log",append=TRUE)}
  else
  {cat("\n Test Case 5 failed:B-warranty Data is not Present for every week",file="Log_File_test.log",append=TRUE)}
}

test_calc_ID_data=function(df,CODE){
  data_cal=df[df$CODE==CODE,]
  max_date=max(as.Date(data_cal$CALC_DATE))
  min_date=min(as.Date(data_cal$CALC_DATE))
  date_strings=c(min_date,max_date)
  diff_in_weeks = difftime(date_strings[2],date_strings[1], units = "weeks")
  #diff_in_days=diff_in_weeks/7
  unique_caldate=unique(data_cal$CALC_DATE)
  CAL_DATE_Count=length(unique(data_cal$CALC_DATE))-1
  if(CAL_DATE_Count==diff_in_weeks)
  {
    return(1)
  }
  else
    return(0)
}

#6.Check Max date and min date and check if the data is present for every week-for B-Emission+Warranty input
test_date_count_data_B_WE = function(df_input){
   df_input=df_input[df_input$Name=="B",] 
  unique_CODE_ID=unique(df_input$CODE)
  #test_sample_code=sample(unique_CODE_ID,10,replace=FALSE)
  status=0
  for(i in 1:length(unique_CODE_ID)){
    status=test_calc_ID_data(df_input,unique_CODE_ID[i])
  } 
  if(status==1)
  {cat("\n Test case 6 passed:B-warranty+emission",file="Log_File_test.log",append=TRUE)}
  else
  {cat("\n Test Case 6 failed:B-warranty+emission Data is not Present for every week",file="Log_File_test.log",append=TRUE)}
}

test_calc_ID_data=function(df,CODE){
  data_cal=df[df$CODE==CODE,]
  max_date=max(as.Date(data_cal$CALC_DATE))
  min_date=min(as.Date(data_cal$CALC_DATE))
  date_strings=c(min_date,max_date)
  diff_in_weeks = difftime(date_strings[2],date_strings[1], units = "weeks")
  #diff_in_days=diff_in_weeks/7
  unique_caldate=unique(data_cal$CALC_DATE)
  CAL_DATE_Count=length(unique(data_cal$CALC_DATE))-1
  if(CAL_DATE_Count==diff_in_weeks)
  {
    return(1)
  }
  else
    return(0)
}
#7.Check Max date and min date and check if the data is present for every week-for L-typo_e input
test_date_count_data_L_E = function(df_input){
  df_input=df_input[df_input$Name=="L",] 
  unique_CODE_ID=unique(df_input$CODE)
  #test_sample_code=sample(unique_CODE_ID,10,replace=FALSE)
  status=0
  for(i in 1:length(unique_CODE_ID)){
    status=test_calc_ID_data(df_input,unique_CODE_ID[i])
  } 
  if(status==1)
  {cat("\n Test case 7 passed:L-typo_e",file="Log_File_test.log",append=TRUE)}
  else
  {cat("\n Test Case 7 failed:L-typo_e Data is not Present for every week",file="Log_File_test.log",append=TRUE)}
}

test_calc_ID_data=function(df,CODE){
  data_cal=df[df$CODE==CODE,]
  max_date=max(as.Date(data_cal$CALC_DATE))
  min_date=min(as.Date(data_cal$CALC_DATE))
  date_strings=c(min_date,max_date)
  diff_in_weeks = difftime(date_strings[2],date_strings[1], units = "weeks")
  #diff_in_days=diff_in_weeks/7
  unique_caldate=unique(data_cal$CALC_DATE)
  CAL_DATE_Count=length(unique(data_cal$CALC_DATE))-1
  if(CAL_DATE_Count==diff_in_weeks)
  {
    return(1)
  }
  else
    return(0)
}

#8.Check Max date and min date and check if the data is present for every week-for L-typo_w input
test_date_count_data_L_W = function(df_input){
  df_input=df_input[df_input$Name=="L",]
  unique_CODE_ID=unique(df_input$CODE)
  #test_sample_code=sample(unique_CODE_ID,10,replace=FALSE)
  status=0
  for(i in 1:length(unique_CODE_ID)){
    status=test_calc_ID_data(df_input,unique_CODE_ID[i])
  } 
  if(status==1)
  {cat("\n Test case 8 passed:L-typo_w",file="Log_File_test.log",append=TRUE)}
  else
  {cat("\n Test Case 8 failed:L-typo_w Data is not Present for every week",file="Log_File_test.log",append=TRUE)}
}

test_calc_ID_data=function(df,CODE){
  data_cal=df[df$CODE==CODE,]
  max_date=max(as.Date(data_cal$CALC_DATE))
  min_date=min(as.Date(data_cal$CALC_DATE))
  date_strings=c(min_date,max_date)
  diff_in_weeks = difftime(date_strings[2],date_strings[1], units = "weeks")
  #diff_in_days=diff_in_weeks/7
  unique_caldate=unique(data_cal$CALC_DATE)
  CAL_DATE_Count=length(unique(data_cal$CALC_DATE))-1
  if(CAL_DATE_Count==diff_in_weeks)
  {
    return(1)
  }
  else
    return(0)
}

#9.Check Max date and min date and check if the data is present for every week-for B-typo_e+typo_w input
test_date_count_data_L_WE = function(df_input){
  df_input=df_input[df_input$Name=="L",]
  unique_CODE_ID=unique(df_input$CODE)
  #test_sample_code=sample(unique_CODE_ID,10,replace=FALSE)
  status=0
  for(i in 1:length(unique_CODE_ID)){
    status=test_calc_ID_data(df_input,unique_CODE_ID[i])
  } 
  if(status==1)
  {cat("\n Test case 9 passed:L-typo_w+typo_e",file="Log_File_test.log",append=TRUE)}
  else
  {cat("\n Test Case 9 failed:L-typo_w+typo_e Data is not Present for every week",file="Log_File_test.log",append=TRUE)}
}

test_calc_ID_data=function(df,CODE){
  data_cal=df[df$CODE==CODE,]
  max_date=max(as.Date(data_cal$CALC_DATE))
  min_date=min(as.Date(data_cal$CALC_DATE))
  date_strings=c(min_date,max_date)
  diff_in_weeks = difftime(date_strings[2],date_strings[1], units = "weeks")
  #diff_in_days=diff_in_weeks/7
  unique_caldate=unique(data_cal$CALC_DATE)
  CAL_DATE_Count=length(unique(data_cal$CALC_DATE))-1
  if(CAL_DATE_Count==diff_in_weeks)
  {
    return(1)
  }
  else
    return(0)
}
#10.Validate if recent output data is present for each engine series
recent_date_output=function(df_output){
    df_x=df_output[df_output$E_S=="X",]
    df_b=df_output[df_output$E_S=="B",]
    df_l=df_output[df_output$E_S=="L",]
    date_x=max(df_x$CALC_DATE)
    date_b=max(df_b$CALC_DATE)
    date_l=max(df_l$CALC_DATE)
    cat("\n Test case 10 passed:calc_dates are",date_x,date_b,date_l,file="Log_File_test.log",append=TRUE)
    }

#11.Validate if recent input data is present for each engine series
recent_date_input=function(df_input){
    df_x=df_input[df_input$E_S=="X",]
    df_b=df_input[df_input$E_S=="B",]
    df_l=df_input[df_input$E_S=="L",]
    date_x=max(df_x$CALC_DATE)
    date_b=max(df_b$CALC_DATE)
    date_l=max(df_l$CALC_DATE)
    cat("\n Test case 11 passed:calc_dates are",date_x,date_b,date_l,file="Log_File_test.log",append=TRUE)
    }
#12.validate if model has ran successfully on recent date for each engine series
recent_date_run=function(df_output){
    df_x=df_output[df_output$E_S=="X",]
    df_b=df_output[df_output$E_S=="B",]
    df_l=df_output[df_output$E_S=="L",]
    date_x=unique(df_x$Run_Date)
    date_b=unique(df_b$Run_Date)
    date_l=unique(df_l$Run_Date)
    cat("\n Test case 12 passed:run_dates are",date_x,date_b,date_l,file="Log_File_test.log",append=TRUE)
    }

#13.Validate the Engine name 
test_engine_name=function(df_output){
  Tpe_name=unique(df_output$Name_Des)
  if(("Coco" %in% Tpe_name) & ("Pepsi" %in% Tpe_name) & ("mix" %in% Tpe_name) 
     & ("fanta" %in% Tpe_name) & ("coc" %in% Tpe_name) & ("sprite" %in% Tpe_name) & ("majja" %in% Tpe_name) & ("majjo" %in% Tpe_name) & ("All" %in% Tpe_name))
    {
    cat("\n Test Case 13: Passed-Engine names are correct ", file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 13: Failed-Engine names are not correct", file= "Log_File_test.log",append=TRUE)
  }
  }

#14.validate the only source are type_1, DS and atics in X input
test_input_datasource_X=function(df_input){
  input_data_source=unique(df_input$SOURCE)
  if(("R" %in% input_data_source) & ("DS" %in% input_data_source) & ("ATICS" %in% input_data_source) & (length(input_data_source)==3))
  {
    cat("\n Test Case 14: Passed-type_1, DS and atics are present", file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 14: Failed-type_1, DS and atics are not present", file= "Log_File_test.log",append=TRUE)
  }
}

#15.validate the only source are type_1, DS and  in Emmission input
test_input_datasource_E=function(df_input){
  input_data_source=unique(df_input$SOURCE)
  if(("REL" %in% input_data_source) & ("DS" %in% input_data_source)  & (length(input_data_source)==2))
  {
    cat("\n Test Case 15: Passed-only type_1, DS are present", file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 15: Failed-only type_1, DS are not present", file= "Log_File_test.log",append=TRUE)
  }
}

#16.validate the only source are type_1, DS and  in warramty_Emmission input
test_input_datasource_WE=function(df_input){
  input_data_source=unique(df_input$SOURCE)
  if(("REL" %in% input_data_source) & ("DS" %in% input_data_source)  & (length(input_data_source)==2))
  {
    cat("\n Test Case 16: Passed-only type_1, DS are present", file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 16: Failed-only type_1, DS are not present", file= "Log_File_test.log",append=TRUE)
  }
}

#17.validate the only source are type_1, DS and  in warramty input
test_input_datasource_W=function(df_input){
  input_data_source=unique(df_input$SOURCE)
  if(("REL" %in% input_data_source) & ("DS" %in% input_data_source)  & (length(input_data_source)==2))
  {
    cat("\n Test Case 17: Passed-only type_1, DS are present", file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 17: Failed-only type_1, DS are not present", file= "Log_File_test.log",append=TRUE)
  }
}

#18.Validate the data sources present in output data
check_Source_output_Count=function(df_output)
{
  df_output=df_output[df_output$E_S=="X",]
  Test_SRC= unique(df_output$SOURCE)
  if (("REL" %in% Test_SRC) & ("atics" %in% Test_SRC) & ("DS" %in% Test_SRC)&(length(Test_SRC)==3))
  {
    cat("\n Test Case 18: Passed-only REL,TEL and DS are present", file= "Log_File_test.log",append=TRUE)
  }
  else
    cat("\n Test Case 18: Failed -only REL,TEL and DS are present",file="Log_File_test.log",append = TRUE )
}

#19.Validate the data sources present in output data
check_Source_output_Cost=function(df_output)
{
  df_output=df_output[df_output$OM_METRIC=="COST_NBR" & df_output$E_S=="X",]
  Test_SRC= unique(df_output$SOURCE)
  if (("REL" %in% Test_SRC) & (length(Test_SRC)==1))
  {
    cat("\n Test Case 19: Passed-only REL is present", file= "Log_File_test.log",append=TRUE)
  }
  else
    cat("\n Test Case 19: Failed - There are other sources apart from REL",file="Log_File_test.log",append = TRUE )
}

#20.Validate the data sources present in output data for B and L series engine
check_Source_output_BL=function(df_output)
{
  df_output=df_output[df_output$E_S=="B" |df_output$E_S=="L" ,]
  Test_SRC= unique(df_output$SOURCE)
  if (("REL" %in% Test_SRC) & ("DS" %in% Test_SRC)&(length(Test_SRC)==2))
  {
    cat("\n Test Case 20: Passed- only REL and DS are present", file= "Log_File_test.log",append=TRUE)
  }
  else
    cat("\n Test Case 20: Failed - There are other sources apart from REL and DS",file="Log_File_test.log",append = TRUE )
}
#21.Check for CALC_ID format for DS datasource.
test_CALC_ID= function(df_output){
  #print(nrow(df_output))
  flag=0
  df_output=df_output[df_output$E_S=="X",]
  for (i in 1:nrow(df_output))  {
    newCol=paste(df_output$CODE[i],"All-All",df_output$Name_Des[i],df_output$SOURCE[i],sep="-")  
    if(newCol==df_output$CALC_ID[i])
    {flag=1}
    else
    {flag=0}
  }
  if(flag==1){
    cat(" \n Test case 21 : Passed-The Format for CAlC_ID is correct",file="Log_File_test.log",append = TRUE)
  }
  else{
    cat("\n Test case 21: The Format for CAlC_ID is Incorrect",file="Log_File_test.log", append=TRUE)
  }
}

#22.Check for CALC_ID format for all datasource 
subpop_id_new=function(df_output){
  df_output=df_output[df_output$E_S=="B" | df_output$E_S=="L",]
    flag=1
  for(i in 1:nrow(df_output)){
    newCol=paste(df_output$CODE[i],df_output$REL_USER_APPL_DESC[i],       df_output$Name[i],df_output$Name_Des[i],df_output$REL_OEM_NORMALIZED_GROUP[i],df_output$REL_MONTH_BUILD_DATE[i],df_output$REL_QUARTER_BUILD_DATE[i],df_output$BUILD_YEAR[i],df_output$SOURCE[i],sep ="-")
    if(newCol==as.character(df_output$CALC_ID[i]))
    {
      flag=0
       }
    else{
      
      cat("\n Test Case 22: Failed", as.character(df_output$CALC_ID[i]),file= "Log_File_test.log",append=TRUE)
    }
  }
  if(flag==0){cat("\n Test case 22 Passed",file="Log_File_test.log",append = TRUE)}
}

#23.Validate the metrices on which OM model runs
    test_metric=function(df_output){
     unique_metric=unique(df_output$OM_METRIC)
     if(("COUNT_NBR" %in% unique_metric) & ("COST_NBR" %in% unique_metric) & ("RPH" %in% unique_metric) 
        & ("CPE" %in% unique_metric) & ("WCPE" %in% unique_metric) & (length(unique_metric))==5){
         cat("\n Test case 23 Passed- count_nbr,cost_nbr,RPH,CPE and WCPE metrics are present",file="Log_File_test.log",append = TRUE)
     }
     else{
         cat("\n Test Case 23: Failed-count_nbr,cost_nbr,RPH,CPE and WCPE metrics are not present",file= "Log_File_test.log",append=TRUE)
     }
 }
#24.Validate the Program Group names in output data for BL series engine
test_program_group_name=function(df_output){
  df_output=df_output[df_output$E_S=="B" | df_output$E_S=="L",]
  program_group_name=unique(df_output$PROGRAM_GROUP_NAME)
  if(("EMISSIONS" %in% program_group_name) & ( "typo_w" %in% program_group_name) & 
     ("WARRANTY_EMISSIONS" %in% program_group_name) &  (length(program_group_name)==3)){
    cat("\n Test Case 24: Passed-EMISSIONS,typo_w and WARRANTY_EMISSIONS are present", file= "Log_File_test.log",append=TRUE) 
  }
  else{
    cat("\n Test Case 24: Failed-EMISSIONS,typo_w and WARRANTY_EMISSIONS are not present", file= "Log_File_test.log",append=TRUE)
  }
}

#25.Validate the Program Group names in output data for X series engine
test_program_group_name_X=function(df_output){
  df_output=df_output[df_output$E_S=="X",]
  program_group_name=unique(df_output$PROGRAM_GROUP_NAME)
  if("typo_w" %in% program_group_name ){
    cat("\n Test Case 25: Passed-only typo_w is present", file= "Log_File_test.log",append=TRUE) 
  }
  else{
    cat("\n Test Case 25: Failed-other than typo_w is present", file= "Log_File_test.log",append=TRUE)
  }
}
#26.if the count of occurrence of fault code is less than 5 for current week 
#then it should not be flagged for COUNT as metric
test_Occur_Count= function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
  #df_output=df_output[df_output$SOURCE =="atics" & df_output$OM_ALGO == "Trend_with_BB",]
  data_rw_output_Tele= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_Tele)!=0){
    for (i in 1:nrow(data_rw_output_Tele)){
      if (data_rw_output_Tele$OM_NBR[i] >=5){
        Flag=0
          }
      else{
        cat("\n Test case 26 Failed-occurrence is less than 5",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 26 passed-occurrence is greater than or equal to 5",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 26 No data present for atics this week", file = "Log_File_test.log", append = TRUE)}
}


#27. the count of occurrence of fault code is less than 5 for current week 
#then it should not be flagged for COUNT as metric
test_Occur_Count_BL= function(df_output){
 df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & (df_output$E_S=="B" | df_output$E_S=="L"),]
  #df_output=df_output[df_output$SOURCE =="atics" & df_output$OM_ALGO == "Trend_with_BB",]
  data_rw_output_Tele= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_Tele)!=0){
    for (i in 1:nrow(data_rw_output_Tele)){
      if (data_rw_output_Tele$OM_NBR[i] >=5){
        Flag=0
          }
      else{
        cat("\n Test case 27 Failed-occurrence is less than 5",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 27 passed-occurrence is greater than or equal to 5",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 27 No data present for atics this week", file = "Log_File_test.log", append = TRUE)}
}

#28.if OM_NBR of fault code is less than or equal to 0 for current week then it should not be flagged for RPH as metric
test_Occur_RPH= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="RPH",]
#df_output=df_output[ df_output$SOURCE =="DS" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_eds= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_eds)!=0){
    for (i in 1:nrow(data_rw_output_eds)){
      if (data_rw_output_eds$OM_NBR[i] >0)
        {Flag=0}
      else{
        cat("\n Test case 28: Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 28 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test case 28 -No data present for DS this week", file = "Log_File_test.log", append = TRUE)}
  
}
#29.if OM_NBR of fault code is less than or equal to 0 for current week then it should not be flagged for CPE as metric
test_Occur_CPE= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="CPE",]
#df_output=df_output[ df_output$SOURCE =="DS" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_eds= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_eds)!=0){
    for (i in 1:nrow(data_rw_output_eds)){
      if (data_rw_output_eds$OM_NBR[i] >0)
        {Flag=0}
      else{
        cat("\n Test case 29: Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 29 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test case 29 -No data present for DS this week", file = "Log_File_test.log", append = TRUE)}
  
}
#30.if OM_NBR of fault code is less than or equal to 0 for current week then it should not be flagged for WCPE as metric
test_Occur_WCPE= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="WCPE",]
#df_output=df_output[ df_output$SOURCE =="DS" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_eds= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_eds)!=0){
    for (i in 1:nrow(data_rw_output_eds)){
      if (data_rw_output_eds$OM_NBR[i] >0)
        {Flag=0}
      else{
        cat("\n Test case 30: Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 30 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test case 30 -No data present for DS this week", file = "Log_File_test.log", append = TRUE)}
  
}

#31.if OM_NBR of fault code is less than or equal to 0 for current week then it should not be flagged for COST as metric
test_Occur_COST= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="COST_NBR",]
#df_output=df_output[ df_output$SOURCE =="DS" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_eds= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_eds)!=0){
    for (i in 1:nrow(data_rw_output_eds)){
      if (data_rw_output_eds$OM_NBR[i] >0)
        {Flag=0}
      else{
        cat("\n Test case 31: Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 31 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test case 31 -No data present for DS this week", file = "Log_File_test.log", append = TRUE)}
  
}
#32.Count_NBR for previous week should not equal to current week for Trend algo for COUNT as metric
count_data_tele_NBR=function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
  df_output=df_output[df_output$OM_ALGO=="Trend_with_BB" | df_output$OM_ALGO=="TREND_without_BB",]
  current_tele_NBR=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)) )
  if (nrow(current_tele_NBR)!=0){
    unique_ID_tele_NBR=unique(current_tele_NBR$CODE)
    for(i in 1:length(unique_ID_tele_NBR)){
      if(current_tele_NBR$OM_NBR == current_tele_NBR$OM_NBR_PREV){
        cat("\n Test case 32 failed",unique_ID_tele_NBR[i],file="Log_File_test.log",append = TRUE)
        Flag=i
        
      }
      else{  Flag=0 }
    }
    if (Flag==0){cat("\n Test case 32 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  {
    cat ("\n Test Case 32 No CODE is Flagged for atics this week", file = "Log_File_test.log", append = TRUE)
  }
}
#33.Validate the user application descriptions present in input data.

input_appl_output=function(df_output){
    df_output=df_output[df_output$E_S=="B" | df_output$E_S=="L",]
    user_appl=unique(df_output$rel_user_appl_desc)
  if(("BUS,SCHOOL" %in% user_appl) | ("BUS,NOT SCHOOL" %in% user_appl) | ("FIRE TRUCK" %in% user_appl) | ("RV" %in% user_appl) | ("AUTO" %in% user_appl)){
   cat("\n Test Case 33: Passed", file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 33: Failed", file= "Log_File_test.log",append=TRUE)
  }
      
    }

#34.Validate the user application descriptions present in output data.

input_appl=function(df_output){
    df_output=df_output[df_output$E_S=="B" | df_output$E_S=="L",]
    user_appl=unique(df_output$rel_user_appl_desc)
  if(("BUS,SCHOOL" %in% user_appl) | ("BUS,NOT SCHOOL" %in% user_appl) | ("FIRE TRUCK" %in% user_appl) | ("RV" %in% user_appl) | ("AUTO" %in% user_appl)){
   cat("\n Test Case 34: Passed", file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 34: Failed", file= "Log_File_test.log",append=TRUE)
  }
      
    }

#35.validate if input data is satisfying below filter conditions- for BL

filter_BL=function(df_input){
    df1=df_output[df_output$E_S=="B" | df_output$E_S=="L", ]
df1 <- mutate(df1, Sub_col = paste(df1$CODE,df1$SOURCE,df1$BUILD_YEAR,df1$REL_USER_APPL_DESC,df1$E_S,df1$Name_Des,df1$REL_MONTH_BUILD_DATE,df1$REL_OEM_NORMALIZED_GROUP,df1$PROGRAM_GROUP_NAME))
#nrow(df1)
df2=aggregate(df1$COUNT_NBR, by=list(sub_id=df1$Sub_col), FUN=sum)
#nrow(df2)
for(i in 1:nrow(df2)){
  if(df2$x[i]<15){
    df3=df1[df1$Sub_col==df2$sub_id[i],]
    df4=df3[as.Date(df3$CALC_DATE)>=as.Date(max(df3$CALC_DATE))-(12*7),]
    df5=aggregate(df4$COUNT_NBR, by=list(sub_id=df4$Sub_col), FUN=sum)
    if(df5$x<5){
      df_rph=df1[df1$Sub_col==df5$sub_id,]
      df_rph1=df_rph[as.Date(df_rph$CALC_DATE)==as.Date(max(df_rph$CALC_DATE)),]
      if(df_rph1$RPH>=0.05){
        cat("\n scenarion Pass-3",df2$sub_id[i],file="Log_File_test.log",append=TRUE)
      }else{cat("\n scenarion fail-3",df2$sub_id[i],file="Log_File_test.log",append=TRUE)}
    }else{cat("\n scenarion Pass-2",df2$sub_id[i],file="Log_File_test.log",append=TRUE)}
  }else{cat("\n scenarion Pass-1",df2$sub_id[i],file="Log_File_test.log",append=TRUE)}
}
    }

#36.validate if input data is satisfying below filter conditions- for X

filter_x=function(df_input){
    df1=df_output[df_output$E_S=="X",]
df2=aggregate(df1$COUNT_NBR,by=list(Calc_id=df1$CALC_ID), FUN=sum)
#print(nrow(df2))
for(i in 1:nrow(df2)){
    if(df2$x[i]<15){
        df3=df1[df1$CALC_ID==df2$Calc_id[i],]
        df4=df3[as.Date(df3$CALC_DATE)>=as.Date(max(df3$CALC_DATE))-(12*7),]
        df5=aggregate(df4$COUNT_NBR, by=list(Calc_id=df4$CALC_ID), FUN=sum)
               if(df5$x<5){
                 df_rph=df3[df3$CALC_ID==df5$Calc_id,]
                 df_rph1=df_rph[as.Date(df_rph$CALC_DATE)==as.Date(max(df_rph$CALC_DATE)),]
                 if(df_rph1$RPH>=0.05){
                     cat("\n Scenario Pass-3",df2$Calc_id[i],file="Log_File_test.log",append=TRUE)
                     }else{cat("\n Scenario fail-3",df2$Calc_id[i],file="Log_File_test.log",append=TRUE)}
                 }else{cat("\n Scenario Pass-2",df2$Calc_id[i],file="Log_File_test.log",append=TRUE)}
            }else{cat("\n Scenario Pass-1",df2$Calc_id[i],file="Log_File_test.log",append=TRUE)}
    }
    }

#37.validate the cost data in x input table
cost_check=function(df_input){
    flag=0
    df_input=df_input[df_input$SOURCE=="REL",]
    for(i in 1:nrow(df_input)){
        if(df_input$COST_NBR[i]<0){
            flag=i
        }
    }
    if(flag!=0){
        cat("\n Test Case 37: Failed",file= "Log_File_test.log",append=TRUE)
    }
            else{
           cat("\n Test case 37 Passed",file="Log_File_test.log",append = TRUE)
        }
}


#38.current priority score should be greater than previous priority score
Test_2_Delta_MA=function(df_output){
  #df_output=df_output[df_output$Name=="X",]
  df_output=df_output[df_output$OM_ALGO =="MA_Ribbon",]
  flag=0
  for(i in 1:nrow(df_output)){
    if ((df_output$OM_CRRT_PRIORITY_SCORE[i]) > (df_output$OM_PREV_PRIORITY_SCORE[i])){
      flag=0}
    else
    { flag=i
    }
    }
  if (flag==0)
  {cat(" \n Test case 38 : Passed",file ="Log_File_test.log",append = TRUE)}
  else
  {cat("\n Test case 38: Failed CRRT_PRIORITY_SCORE should be Greater than PREV_PRIORITY_SCORE",file ="Log_File_test.log", append=TRUE)}
}

#39.validate the RPH values in om-stats table
rph_test=function(df_input){
    if(min(df_input$weibull_rph_mileage_lower_bound)>0 & max(df_input$weibull_rph_mileage_lower_bound)<100){
        cat(" \n Test case 39 : Scenario-1 Passed",file ="Log_File_test.log",append = TRUE)
       }
    else{cat(" \n Test case 39 : Scenario-1 Failed",file ="Log_File_test.log",append = TRUE)}
    
    if(min(df_input$weibull_rph_mileage_median)>0 & max(df_input$weibull_rph_mileage_median)<100){
        cat(" \n Test case 39 : Scenario-2 Passed",file ="Log_File_test.log",append = TRUE)
       }
    else{cat(" \n Test case 39 : Scenario-2 Failed",file ="Log_File_test.log",append = TRUE)}
    
    if(min(df_input$weibull_rph_mileage_upper_bound)>0 & max(df_input$weibull_rph_mileage_upper_bound)<100){
        cat(" \n Test case 39 : Scenario-3 Passed",file ="Log_File_test.log",append = TRUE)
       }
    else{cat(" \n Test case 39 : Scenario-3 Failed",file ="Log_File_test.log",append = TRUE)}
    
    if(min(df_input$weibull_rph_month_in_service_lower_bound)>0 & max(df_input$weibull_rph_month_in_service_lower_bound)<100){
        cat(" \n Test case 39 : Scenario-4 Passed",file ="Log_File_test.log",append = TRUE)
       }
    else{cat(" \n Test case 39 : Scenario-4 Failed",file ="Log_File_test.log",append = TRUE)}
    
    if(min(df_input$weibull_rph_month_in_service_median)>0 & max(df_input$weibull_rph_month_in_service_median)<100){
        cat(" \n Test case 39 : Scenario-5 Passed",file ="Log_File_test.log",append = TRUE)
       }
    else{cat(" \n Test case 39 : Scenario-5 Failed",file ="Log_File_test.log",append = TRUE)}
    
    if(min(df_input$weibull_rph_month_in_service_upper_bound)>0 & max(df_input$weibull_rph_month_in_service_upper_bound)<100){
        cat(" \n Test case 39 : Scenario-6 Passed",file ="Log_File_test.log",append = TRUE)
       }
    else{cat(" \n Test case 39 : Scenario-6 Failed",file ="Log_File_test.log",append = TRUE)}
    
    if(min(df_input$weibull_rph_mileage_median_prev)>0 & max(df_input$weibull_rph_mileage_median_prev)<100){
        cat(" \n Test case 39 : Scenario-7 Passed",file ="Log_File_test.log",append = TRUE)
       }
    else{cat(" \n Test case 39 : Scenario-7 Failed",file ="Log_File_test.log",append = TRUE)}
    
    if(min(df_input$weibull_rph_month_in_service_median_prev)>0 & max(df_input$weibull_rph_month_in_service_median_prev)<100){
        cat(" \n Test case 39 : Scenario-8 Passed",file ="Log_File_test.log",append = TRUE)
       }
    else{cat(" \n Test case 39 : Scenario-8 Failed",file ="Log_File_test.log",append = TRUE)}
    
    }
























##########################################################################################################
#3.Validate NA values in Output data
test_output_data=function(df_output){
  null_output_data=colSums(is.na(df_output))
    flag=1
  for(i in 1:length(null_output_data)){
    if(null_output_data[i]==0){
        flag=0 
    }
    else{
        flag=1
     }
      }
    if(flag==0)
     {cat("\n Test Case 3 Passed",file="Log_File_test.log",append=TRUE)}
    else
     {cat("\n Test case 3 Failed:Output data has NA values",file="Log_File_test.log",append=TRUE)}   
}

#4.Validate NA values in X Input data
test_input_data_X=function(df_input){
  null_input_data=colSums(is.na(df_input))
  for(i in 1:length(null_input_data)){
    if(null_input_data[i]==0){
      flag=0
      }
    else{
      flag=1
    }
  } 
  if(flag==0){
    cat("\n Test Case 4 Passed",file="Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test case 4 Failed:Input data has NA values",file="Log_File_test.log",append=TRUE)
    }
  }

#5.Validate NA values in Emmission Input data
test_input_data_E=function(df_input){
  null_input_data=colSums(is.na(df_input))
  for(i in 1:length(null_input_data)){
    if(null_input_data[i]==0){
      flag=0
    }
    else{
      flag=1
    }
  }
  if(flag==0){
    cat("\n Test Case 5 Passed",file="Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test case 5 Failed:Input data has NA values",file="Log_File_test.log",append=TRUE)
    } 
}

#6.Validate NA values in Warranty_Emmission Input data
test_input_data_WE=function(df_input){
  null_input_data=colSums(is.na(df_input))
  for(i in 1:length(null_input_data)){
    if(null_input_data[i]==0){
      flag=0
    }
    else
    {flag=1
    }
    }
    if(flag==0){
    cat("\n Test Case 6 Passed",file="Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test case 6 Failed:Input data has NA values",file="Log_File_test.log",append=TRUE)
    }
}

#7.Validate NA values in typo_w Input data
test_input_data_W=function(df_input){
  null_input_data=colSums(is.na(df_input))
  for(i in 1:length(null_input_data)){
    if(null_input_data[i]==0){
      flag=0
    }
    else
    {flag=1
    }
     }
    if(flag==0){
    cat("\n Test Case 7 Passed",file="Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test case 7 Failed:Input data has NA values",file="Log_File_test.log",append=TRUE)
    }
}

#8.Validate NA values in Weibull Input data
test_input_data_weibull=function(df_input){
  null_input_data=colSums(is.na(df_input))
  for(i in 1:length(null_input_data)){
    if(null_input_data[i]==0){
      flag=0
    }
    else
    {flag=1
    }
    }
    if(flag==0){
    cat("\n Test Case 8 Passed",file="Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test case 8 Failed:Input data has NA values",file="Log_File_test.log",append=TRUE)
    }
}




#18.Validate the count_NBR values for BL series engine
test_count_NBR=function(df_output){
  df_output=df_output[df_output$E_S=="B" | df_output$E_S=="L",]
  flag=0
  for(i in 1:nrow(df_output)){
    if(df_output$OM_NBR[i]>=0 & df_output$OM_NBR[i]<1000){
      flag=0
    }
    else{
      flag=i
    }
  }
  if(flag==0){
    cat("\n Test Case 18: Passed", file= "Log_File_test.log",append=TRUE)
  }
  else{
    cat("\n Test Case 18: Failed", file= "Log_File_test.log",append=TRUE)
  }
}

#19.Validate the RPH score in output data for BL series engine
test_RPH_Score=function(df_output){
  if((any(is.na(df_output$OM_WEIBULL_SCORE_RPH_MONTH_IN_SERVICE_MEDIAN))) | (any(is.na(df_output$OM_WEIBULL_SCORE_RPH_MILEAGE_MEDIAN))))
  {
    cat("\n Test Case 19 Failed as Predicted RPH columns have NA values",file= "Log_File_test.log",append=TRUE)
    }
  else
      {cat("\n Test case 19 Passed-for emmissions",file="Log_File_test.log",append = TRUE)}
}




#28.Check for CALC_ID format for atics datasource.
test_CALC_ID_TELE= function(df_output){
  #print(nrow(df_output))
  df_output=df_output[df_output$E_S=="X",]
  df_output=df_output[df_output$SOURCE=="atics",]
  for (i in 1:nrow(df_output))  {
    newCol=paste(df_output$CODE[i],"All-All",df_output$Name_Des[i],"atics",sep="-")  
    if(newCol==df_output$CALC_ID[i])
    {flag=0}
    else
    {flag=1}
  }
  if(flag==0){
    cat(" \n Test case 28 : Passed",file="Log_File_test.log",append = TRUE)
  }
  else{
    cat("\n Test case 28: The Format for CAlC_ID for atics Source is Incorrect",file="Log_File_test.log", append=TRUE)
  }
}

#29.Check for CALC_ID format for REL datasource.
test_CALC_ID_REL= function(df_output){
  #print(nrow(df_output))
  df_output=df_output[df_output$E_S=="X",]
  df_output=df_output[df_output$SOURCE=="REL",]
  for (i in 1:nrow(df_output))  {
    newCol=paste(df_output$CODE[i],"All-All",df_output$Name_Des[i],"REL",sep="-")  
    if(newCol==df_output$CALC_ID[i])
    {flag=0}
    else
    {flag=1}
  }
  if(flag==0){
    cat(" \n Test case 29 : Passed",file="Log_File_test.log",append = TRUE)
  }
  else{
    cat("\n Test case 29: The Format for CAlC_ID for REL Source is Incorrect",file="Log_File_test.log", append=TRUE)
  }
}
#30.Validate the values of columns - Output1, Output2 and Output3
test_Output_MA_X= function(df_output){
  df_output=df_output[df_output$E_S=="X",]
  df_output=df_output[df_output$OM_ALGO=="MA_Ribbon",]
  if(all(df_output$OM_OUTPUT_01 == 0) & all(df_output$OM_OUTPUT_02 == 0) & all(df_output$OM_OUTPUT_03 == 0))
    
  {cat("\n Test case 30 : passed for X",file = "Log_File_test.log",append = TRUE)}
  else
  {cat("\n Test case 30 :failed for X - Output_1,Output_2,Output_3 should have all records as 0",file ="Log_File_test.log",append = TRUE)}
}

#31.Validate the values of columns - Output1, Output2 and Output3
test_Output_MA_BL= function(df_output){
  df_output=df_output[df_output$E_S=="B" | df_output$E_S=="L",]
  df_output=df_output[df_output$OM_ALGO=="MA_Ribbon",]
  if(all(df_output$OM_OUTPUT_01 == 0) & all(df_output$OM_OUTPUT_02 == 0) & all(df_output$OM_OUTPUT_03 == 0))
    
  {cat("\n Test case 31 : passed for BL",file = "Log_File_test.log",append = TRUE)}
  else
  {cat("\n Test case 31 :failed for BL- Output_1,Output_2,Output_3 should have all records as 0",file ="Log_File_test.log",append = TRUE)}
}
#32.compare the values  of Output 1 and CALC_DATE columns
comparison_dates_Trend_data=function(df_output){
 # df_output=df_output[df_output$Name=="X",]
  df_output=df_output[df_output$OM_ALGO=="Trend_with_BB" | df_output$OM_ALGO=="TREND_without_BB",]
  for(i in 1:length(df_output)){
    if(as.numeric(df_output$CALC_DATE[i]) > as.numeric(df_output$OM_OUTPUT_01[i]))
    {
      flag=0
    }
    else{
      flag=1
    }
  }
  if(flag==0){
    cat("\n Test case 32: Passed",file="Log_File_test.log",append = TRUE)
  }
  else{
    cat("\n Test case 32: Failed- CALC_Date column has smaller values wrt Output 1 column", file= "Log_File_test.log",append = TRUE)
  }
}

#34.Valdiate current score for CALC_ID 
Test_1_CURR_MA= function(df_output){
  #df_output=df_output[df_output$Name=="X",]
  df_output=df_output[df_output$OM_ALGO =="MA_Ribbon",]
  
  if (all(df_output$OM_CRRT_PRIORITY_SCORE>0))
  {cat(" \n Test case 34 : passed",file ="Log_File_test.log",append = TRUE)}
  else
  {cat("\n Test case 34 : Failed- CRRT_PRIORITY_SCORE should be positive",file ="Log_File_test.log", append=TRUE)}
}



#36.Validate the CALC_date for COUNT as metric
test_Totalweeks_count_EDS = function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_METRIC=="COUNT_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="DS",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 36: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 36: Failed - Total weeks DS data needed to generate algorithm results is for atleast 6 weeks", file="Log_File_test.log",append=TRUE)
    
  }
}
#37.Validate the CALC_date for COUNT as metric  
  test_Totalweeks_count_REL = function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_METRIC=="COUNT_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>6)
  {cat("\n Test case 37: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 37: Failed - Total weeks REL data needed to generate algorithm results is for atleast 6 weeks", file="Log_File_test.log",append=TRUE)
    
  }
}
#38.Validate the CALC_date for COUNT as metric  
test_Totalweeks_count_TELE = function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_METRIC=="COUNT_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="atics",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 38: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 38: Failed - Total weeks atics data needed to generate algorithm results is of last 6 weeks", file="Log_File_test.log",append=TRUE)
    
  }
}
#39.Validate the CALC_date for cost metric
test_Totalweeks_cost_data = function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_METRIC=="COST_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 39: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 39: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#40.Validate the CALC_date for RPH metric
test_Totalweeks_RPH_REL = function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_METRIC=="RPH",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 40: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 40: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#41.Validate the CALC_date for RPH metric
test_Totalweeks_RPH_EDS = function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_METRIC=="RPH",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="DS",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 41: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 41: Failed - Total weeks DS data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#42.Validate the CALC_date for CPE metric
test_Totalweeks_CPE_data = function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_METRIC=="CPE",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 42: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 42: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#43.Validate the CALC_date for WCPE metric
test_Totalweeks_WCPE_data = function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_METRIC=="WCPE",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 43: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 43: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}

#44.Validate the CALC_date for COUNT as metric FOR b
test_Totalweeks_count_EDS_B = function(df_output){
  df_output=df_output[df_output$E_S=="B" & df_output$OM_METRIC=="COUNT_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="DS",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 44: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 44: Failed - Total weeks DS data needed to generate algorithm results is for atleast 6 weeks", file="Log_File_test.log",append=TRUE)
    
  }
}
#45.Validate the CALC_date for COUNT as metric  
  test_Totalweeks_count_REL_B = function(df_output){
  df_output=df_output[df_output$E_S=="B" & df_output$OM_METRIC=="COUNT_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 45: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 45: Failed - Total weeks REL data needed to generate algorithm results is for atleast 6 weeks", file="Log_File_test.log",append=TRUE)
    
  }
}

#46.Validate the CALC_date for cost metric
test_Totalweeks_cost_data_B = function(df_output){
  df_output=df_output[df_output$E_S=="B" & df_output$OM_METRIC=="COST_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 46: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 46: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#47.Validate the CALC_date for RPH metric
test_Totalweeks_RPH_REL_B = function(df_output){
  df_output=df_output[df_output$E_S=="B" & df_output$OM_METRIC=="RPH",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 47: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 47: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#48.Validate the CALC_date for RPH metric
test_Totalweeks_RPH_EDS_B = function(df_output){
  df_output=df_output[df_output$E_S=="B" & df_output$OM_METRIC=="RPH",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="DS",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 48: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 48: Failed - Total weeks DS data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#49.Validate the CALC_date for CPE metric
test_Totalweeks_CPE_data_B = function(df_output){
  df_output=df_output[df_output$E_S=="B" & df_output$OM_METRIC=="CPE",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 49: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 49: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#50.Validate the CALC_date for WCPE metric
test_Totalweeks_WCPE_data_B = function(df_output){
  df_output=df_output[df_output$E_S=="B" & df_output$OM_METRIC=="WCPE",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 50: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 50: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#51.Validate the CALC_date for COUNT as metric FOR b
test_Totalweeks_count_EDS_L = function(df_output){
  df_output=df_output[df_output$E_S=="L" & df_output$OM_METRIC=="COUNT_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="DS",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 51: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 51: Failed - Total weeks DS data needed to generate algorithm results is for atleast 6 weeks", file="Log_File_test.log",append=TRUE)
    
  }
}
#52.Validate the CALC_date for COUNT as metric  
  test_Totalweeks_count_REL_L = function(df_output){
  df_output=df_output[df_output$E_S=="L" & df_output$OM_METRIC=="COUNT_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 52: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 52: Failed - Total weeks REL data needed to generate algorithm results is for atleast 6 weeks", file="Log_File_test.log",append=TRUE)
    
  }
}

#53.Validate the CALC_date for cost metric
test_Totalweeks_cost_data_L = function(df_output){
  df_output=df_output[df_output$E_S=="L" & df_output$OM_METRIC=="COST_NBR",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 53: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 53: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#54.Validate the CALC_date for RPH metric
test_Totalweeks_RPH_REL_L = function(df_output){
  df_output=df_output[df_output$E_S=="L" & df_output$OM_METRIC=="RPH",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 54: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 54: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#55.Validate the CALC_date for RPH metric
test_Totalweeks_RPH_EDS_L = function(df_output){
  df_output=df_output[df_output$E_S=="L" & df_output$OM_METRIC=="RPH",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="DS",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 55: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 55: Failed - Total weeks DS data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#56.Validate the CALC_date for CPE metric
test_Totalweeks_CPE_data_L = function(df_output){
  df_output=df_output[df_output$E_S=="L" & df_output$OM_METRIC=="CPE",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 56: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 56: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}
#57.Validate the CALC_date for WCPE metric
test_Totalweeks_WCPE_data_L = function(df_output){
  df_output=df_output[df_output$E_S=="L" & df_output$OM_METRIC=="WCPE",]
  Test_CALC_Data_EDS=df_output[df_output$SOURCE=="REL",]
  if(length(unique(Test_CALC_Data_EDS$CALC_DATE))>24)
  {cat("\n Test case 57: Passed",file="Log_File_test.log",append=TRUE)}
  
  else
  {
    cat("\n Test Case 57: Failed - Total weeks REL data needed to generate algorithm results is of  last 6 weeks",file="Log_File_test.log",append=TRUE)
  }
}

#58.REl:Fail code and fault code whose count is decreasing than previous week should not get flagged for MA ribbon
count_REL_data_output=function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_ALGO=="MA_Ribbon",]
  current_REL_data=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)) & df_output$SOURCE=="REL")
  if (nrow(current_REL_data)!=0){
    #nique_ID_REL=unique(current_REL_data$CODE)
      for(i in 1:length(current_REL_data)){
     if(current_REL_data$OM_NBR[i] > current_REL_data$OM_NBR_PREV[i]){
        Flag=0
      }
      else{
        cat("\n Test case 58 failed",unique_ID_REL[i],file="Log_File_test.log",append = TRUE)
        print(unique_ID_REL[i])
      }
    }
      }
    else{
    cat("\n Test Case 58 - No data present for type_1 this week", file = "Log_File_test.log", append = TRUE)
  }
      
    if (Flag==0){cat("\n Test case 58 Passed",file="Log_File_test.log",append = TRUE)}
}

#59.TELE Fail code and fault code whose count is decreasing than previous week should not get flagged for MA ribbon  for COUNT as metric
count_TELE_data_output=function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_ALGO=="MA_Ribbon" & df_output$SOURCE=="atics",]
  current_TELE_data=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)))
    Flag=1
  if (nrow(current_TELE_data)!=0){
    #nique_ID_TELE=unique(current_TELE_data$CODE)
      for(i in 1:length(current_TELE_data)){
     if(current_TELE_data$OM_NBR[i] > current_TELE_data$OM_NBR_PREV[i]){
        Flag=0
      }
      else{
        cat("\n Test case 59 failed",unique_ID_TELE[i],file="Log_File_test.log",append = TRUE)
        #rint(unique_ID_TELE[i])
      }
    }
    }
    else{
    cat("\n Test Case 59 - No data present for atics this week", file = "Log_File_test.log", append = TRUE)
  }
    if (Flag==0){cat("\n Test case 59 Passed",file="Log_File_test.log",append = TRUE)}
}
#60.DS CODEd fault code whose count is decreasing than previous week should not get flagged for MA ribbon  for COUNT as metriC
count_EDS_data_output=function(df_output){
  df_output=df_output[df_output$E_S=="X" & df_output$OM_ALGO=="MA_Ribbon" & df_output$SOURCE=="DS",]
  current_EDS_data=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)))
    flag=1
  if (nrow(current_EDS_data)!=0){
    #nique_ID_EDS=unique(current_EDS_data$CODE)
      for(i in 1:length(current_EDS_data)){
     if(current_EDS_data$OM_NBR[i] > current_EDS_data$OM_NBR_PREV[i]){
        flag=0
      }
      else{
        cat("\n Test case 60 failed",unique_ID_EDS[i],file="Log_File_test.log",append = TRUE)
        #print(unique_ID_EDS[i])
      }
    }
      }
    else{
    cat("\n Test Case 60 -No data present for DS this week", file = "Log_File_test.log", append = TRUE)
  }
    if (flag==0){cat("\n Test case 60 Passed",file="Log_File_test.log",append = TRUE)}
}




#62 FOR trend algorithm if the count of occurrence of fault code is less than 5 for current week 
#then it should not be flagged for COUNT as metric
test_Occur_Count_EDS_TBB= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
  df_output=df_output[df_output$SOURCE =="DS" & df_output$OM_ALGO == "Trend_with_BB",]
  data_rw_output_eds= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_eds)!=0){
    for (i in 1:nrow(data_rw_output_eds)){
      if (data_rw_output_eds$OM_NBR[i] >=5){
        Flag=0
          }
      else{
        cat("\n Test case 62 Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 62 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 62 No data present for DS this week", file = "Log_File_test.log", append = TRUE)}
  
}
#63.trend algorithm if the count of occurrence of fault code is less than 5 for current week 
#then it should not be flagged for COUNT as metric
test_Occur_Count_REL_TBB= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
  df_output=df_output[df_output$SOURCE =="REL" & df_output$OM_ALGO == "Trend_with_BB",]
  data_rw_output_rel= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
  Flag=1
  if (nrow(data_rw_output_rel)!=0){
        for (i in 1:nrow(data_rw_output_rel)){
            if (data_rw_output_rel$OM_NBR[i] >=5){
        Flag=0}
      else{
        cat("\n Test case 63 Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 63 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 63 -No data present for type_1 this week", file = "Log_File_test.log", append = TRUE)}
}

#64 FOR  TREND_without_BB algorithm if the count of occurrence of fault code is less than 5 for current week then it should not be flagged for COUNT as metric
test_Occur_Count_TELE_TWBB= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
    df_output=df_output[df_output$SOURCE =="atics" & df_output$OM_ALGO == "TREND_without_BB",]
  data_rw_output_rel= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
  Flag=1
  if (nrow(data_rw_output_rel)!=0){
        for (i in 1:nrow(data_rw_output_rel)){
            if (data_rw_output_rel$OM_NBR[i] >=5){
        Flag=0}
      else{
        cat("\n Test case 64 : Failed",file="Log_File_test.log",append =TRUE)
        Flag=i}
    }
    if (Flag==0){cat("\n Test case 64 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 64 - No data present for atics this week", file = "Log_File_test.log", append = TRUE)}
}

#65.TREND_without_BB algorithm if the count of occurrence of fault code is less than 5 for current week then it should not be flagged for COUNT as metric
test_Occur_Count_EDS_TWBB= function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
    df_output=df_output[ df_output$SOURCE =="DS"& df_output$OM_ALGO == "TREND_without_BB",]
  data_rw_output_eds= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_eds)!=0){
    for (i in 1:nrow(data_rw_output_eds)){
      if (data_rw_output_eds$OM_NBR[i] >=5)
        {Flag=0}
      else{
        cat("\n Test case 65: Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 65 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test case 65- No data present for DS this week", file = "Log_File_test.log", append = TRUE)}
  
}
#66.REND_without_BB algorithm if the count of occurrence of fault code is less than 5 for current week then it should not be flagged for COUNT as metric
test_Occur_Count_REL_TWBB= function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
    df_output=df_output[df_output$SOURCE =="REL"& df_output$OM_ALGO == "TREND_without_BB",]
  data_rw_output_rel= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_rel)!=0){
    for (i in 1:nrow(data_rw_output_rel)){
      if (data_rw_output_rel$OM_NBR[i] >=5){
        Flag=0}
      else
      {
        cat("\n Test case 66 Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 66 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test case 66- No data present for type_1 this week", file = "Log_File_test.log", append = TRUE)}
}

#67 for MA Ribbon algorithm if the count of occurrence of fault code is less than 5 
#for current week then it should not be flagged for COUNT as metric
test_Occur_Count_Tele_MA= function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
df_output=df_output[df_output$SOURCE=="atics" & df_output$OM_ALGO == "MA_Ribbon",]
data_rw_output_Tele= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_Tele)!=0){
    for (i in 1:nrow(data_rw_output_Tele)){
      if (data_rw_output_Tele$OM_NBR[i] >=5)
        {Flag=0}
      else{
        cat("\n Test case 67: Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 67 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 67 -No data present for atics this week", file = "Log_File_test.log", append = TRUE)}
}
#68 A Ribbon algorithm if the count of occurrence of fault code is less than 5 
#for current week then it should not be flagged for COUNT as metric
test_Occur_Count_EDS_MA= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
df_output=df_output[ df_output$SOURCE =="DS" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_eds= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_eds)!=0){
    for (i in 1:nrow(data_rw_output_eds)){
      if (data_rw_output_eds$OM_NBR[i] >=5)
        {Flag=0}
      else{
        cat("\n Test case 68: Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 68 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test case 68 -No data present for DS this week", file = "Log_File_test.log", append = TRUE)}
  
}
#69.A Ribbon algorithm if the count of occurrence of fault code is less than 5 
#for current week then it should not be flagged for COUNT as metric
test_Occur_Count_REL_MA= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
    df_output=df_output[df_output$SOURCE =="REL" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_rel= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_rel)!=0){
    for (i in 1:nrow(data_rw_output_rel)){
      if (data_rw_output_rel$OM_NBR[i] >=5)
        {Flag=0}
      else
      {
        cat("\n Test case 69 : Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 69 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 69 - No data present for type_1 this week", file = "Log_File_test.log", append = TRUE)}
}


#71.A Ribbon algorithm if the count of occurrence of fault code is less than or equal to 0 
#for current week then it should not be flagged for RPH as metric
test_Occur_REL_REL_MA= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="RPH" & df_output$E_S=="X",]
    df_output=df_output[df_output$SOURCE =="REL" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_rel= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_rel)!=0){
    for (i in 1:nrow(data_rw_output_rel)){
      if (data_rw_output_rel$OM_NBR[i] >0)
        {Flag=0}
      else
      {
        cat("\n Test case 71 : Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 71 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 71 - No data present for type_1 this week", file = "Log_File_test.log", append = TRUE)}
}

#72.A Ribbon algorithm if the count of occurrence of fault code is less than or equal to 0 
#for current week then it should not be flagged for COST as metric
test_Occur_COST_REL_MA= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="COST_NBR" & df_output$E_S=="X",]
    df_output=df_output[df_output$SOURCE =="REL" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_rel= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_rel)!=0){
    for (i in 1:nrow(data_rw_output_rel)){
      if (data_rw_output_rel$OM_NBR[i] >0)
        {Flag=0}
      else
      {
        cat("\n Test case 72: Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 72 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 72 - No data present for type_1 this week", file = "Log_File_test.log", append = TRUE)}
}

#73.A Ribbon algorithm if the count of occurrence of fault code is less than or equal to 0 
#for current week then it should not be flagged for CPE as metric
test_Occur_CPE_REL_MA= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="CPE" & df_output$E_S=="X",]
    df_output=df_output[df_output$SOURCE =="REL" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_rel= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_rel)!=0){
    for (i in 1:nrow(data_rw_output_rel)){
      if (data_rw_output_rel$OM_NBR[i] >0)
        {Flag=0}
      else
      {
        cat("\n Test case 73 : Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 73 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 73 - No data present for type_1 this week", file = "Log_File_test.log", append = TRUE)}
}

#74.A Ribbon algorithm if the count of occurrence of fault code is less than or equal to 0 
#for current week then it should not be flagged for WCPE as metric
test_Occur_WCPE_REL_MA= function(df_output,df_input){
  df_output=df_output[df_output$OM_METRIC=="WCPE" & df_output$E_S=="X",]
    df_output=df_output[df_output$SOURCE =="REL" & df_output$OM_ALGO == "MA_Ribbon",]
  data_rw_output_rel= df_output[as.Date(df_output$CALC_DATE)==max(as.Date(df_output$CALC_DATE)),]
    Flag=1
  if (nrow(data_rw_output_rel)!=0){
    for (i in 1:nrow(data_rw_output_rel)){
      if (data_rw_output_rel$OM_NBR[i] >0)
        {Flag=0}
      else
      {
        cat("\n Test case 74: Failed",file="Log_File_test.log",append =TRUE)
        Flag=i
      }
    }
    if (Flag==0){cat("\n Test case 74 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  { cat ("\n Test Case 74 - No data present for type_1 this week", file = "Log_File_test.log", append = TRUE)}
}


#76 Count_NBR for previous week should not equal to current week for Trend algo for COUNT as metric
count_data_REL_NBR=function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X" & df_output$SOURCE=="REL",]
  df_output=df_output[df_output$OM_ALGO=="Trend_with_BB" | df_output$OM_ALGO=="TREND_without_BB",]
  current_REL_NBR=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)))
  if(nrow(current_REL_NBR)!=0){
    unique_ID_REL_NBR=unique(current_REL_NBR$CODE)
    for(i in 1:length(unique_ID_REL_NBR)){
       if(current_REL_NBR$OM_NBR == current_REL_NBR$OM_NBR_PREV){
        cat("\n Test case 76 failed",unique_ID_REL_NBR[i],file="Log_File_test.log",append = TRUE)
        Flag=i
      }
      else{  Flag=0 }
    }
    if (Flag==0){cat("\n Test case 76 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  {
    cat ("\n Test Case 76- No CODE is Flagged for type_1 this week", file = "Log_File_test.log", append = TRUE)
  }
}
#77.Count_NBR for previous week should not equal to current week for Trend algo for COUNT as metric
count_data_EDS_NBR=function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X" & df_output$SOURCE=="DS",]
  df_output=df_output[df_output$OM_ALGO=="Trend_with_BB" | df_output$OM_ALGO=="TREND_without_BB",]
  current_EDS_NBR=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)))
  if(nrow(current_EDS_NBR)!=0){
    unique_ID_EDS_NBR=unique(current_EDS_NBR$CODE)
    for(i in 1:length(unique_ID_EDS_NBR)){
      if(current_EDS_NBR$OM_NBR == current_EDS_NBR$OM_NBR_PREV){
        cat("\n Test case 77 failed",unique_ID_EDS_NBR[i],file="Log_File_test.log",append = TRUE)
        Flag=i
        
      }
      else{  Flag=0 }
    }
    if (Flag==0){cat("\n Test case 77  Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  {
    cat ("\n Test Case 77- No CODE is Flagged for DS this week", file = "Log_File_test.log", append = TRUE)
  }
}

#78.cost_NBR for previous week should not equal to current week for Trend algo
test_data_REL_NBR_Cost=function(df_output){
  df_output=df_output[df_output$E_S=="X",]
  df_output=df_output[df_output$OM_ALGO=="Trend_with_BB" | df_output$OM_ALGO=="TREND_without_BB",]
  current_REL_NBR=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)))
  if(nrow(current_REL_NBR)!=0){
    for(i in 1:length(current_REL_NBR)){    
      if(current_REL_NBR$OM_NBR == current_REL_NBR$OM_NBR_PREV){
        cat("\n Test case 78 failed",file="Log_File_test.log",append = TRUE)
        Flag=i
      }
      else{  Flag=0 }
    }
    if (Flag==0){cat("\n Test case 78 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  {
    cat ("\n Test Case 78 - No CODE is Flagged for type_1 this week", file = "Log_File_test.log", append = TRUE)
  }
}










#54.Validate if data has zero values for more than 20 weeks in last 24 weeks then that fail code /fault code should not be flagged for COUNT
Test_last20week_Tele=function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
  current_TEL=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)) & SOURCE=="atics")
  if(nrow(current_TEL)!=0){
    unique_ID_TELE=unique(current_TEL$CODE)
    for(i in 1:length(unique_ID_TELE)){
input_TELE=df_output %>% filter(CODE==unique_ID_TELE[i] & 
        (as.Date(CALC_DATE) >= max(as.Date(CALC_DATE)) -(168)) & SOURCE=="atics")
      if(length(which(input_TELE$OM_NBR == 0))>20){
        cat("\n Test case 54 failed",unique_ID_TELE[i],file="Log_File_test.log",append = TRUE)
        Flag=i
        
      }
      else{  Flag=0 }
    }
    if (Flag==0){cat("\n Test case 54 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  {
    cat ("\n Test Case 54 - No CODE is Flagged for atics this week", file = "Log_File_test.log", append = TRUE)
  }
}
#55.Validate if data has zero values for more than 20 weeks in last 24 weeks then that fail code /fault code should not be flagged for COUNT
Test_last20week_Rel=function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
  current_REL=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)) & SOURCE=="REL")
  if(nrow(current_REL)!=0){
    unique_ID_REL=unique(current_REL$CODE)
    #sample_all_TELE=sample(unique_ID_TELE,10,replace = FALSE)
    for(i in 1:length(unique_ID_REL)){
input_REL=df_output %>% filter(CODE==unique_ID_REL[i] & ((as.Date(CALC_DATE)) >= max(as.Date(CALC_DATE))-(168)) & SOURCE=="REL")
      if(length(which(input_REL$OM_NBR == 0))>20){
        cat("\n Test case 55 failed",unique_ID_REL[i],file="Log_File_test.log",append = TRUE)
        Flag=i
         }
      else{  Flag=0 }
    }
    if (Flag==0){cat("\n Test case 55 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  {
 cat("\n Test Case 55 - No CODE is Flagged for type_1 this week", file = "Log_File_test.log", append = TRUE)
  }
}
#56.Validate if data has zero values for more than 20 weeks in last 24 weeks then that fail code /fault code should not be flagged for COUNT
Test_last20week_Eds=function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COUNT_NBR" & df_output$E_S=="X",]
  current_EDS=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)) & SOURCE=="DS")
  if(nrow(current_EDS)!=0){
    unique_ID_EDS=unique(current_EDS$CODE)
    for(i in 1:length(unique_ID_EDS)){
input_EDS=df_output %>% filter(CODE==unique_ID_EDS[i] & (as.Date(CALC_DATE)>= max(as.Date(CALC_DATE))-(168)) & SOURCE=="DS")
       if(length(which(input_EDS$OM_NBR == 0))>20){
        cat("\n Test case 56 failed",unique_ID_EDS[i],file="Log_File_test.log",append = TRUE)
        Flag=i
        }
      else{  Flag=0 }
    }
    if (Flag==0){cat("\n Test case 56 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  {
    cat ("\n Test Case 56 - No CODE is Flagged for DS this week", file = "Log_File_test.log", append = TRUE)
  }
}


#60.Validate if data has zero values for more than 20 weeks in last 24 weeks then that fail code /fault code should not be flagged
Test_last20week_Rel_Cost=function(df_output){
  df_output=df_output[df_output$OM_METRIC=="COST_NBR" & df_output$E_S=="X",]
  current_REL=df_output %>% filter(as.Date(CALC_DATE)==max(as.Date(CALC_DATE)) & SOURCE=="REL")
  if(nrow(current_REL)!=0){
    unique_ID_REL=unique(current_REL$CODE)
    for(i in 1:length(unique_ID_REL)){
      input_REL=df_output %>% filter(CODE==unique_ID_REL[i] & (as.Date(CALC_DATE) >= max(as.Date(CALC_DATE)) -(168)) & SOURCE=="REL")
      if(length(which(input_REL$OM_NBR == 0))>20){
        cat("\n Test case 60 failed",unique_ID_REL[i],file="Log_File_test.log",append = TRUE)
        Flag=i
        
      }
      else{  Flag=0 }
    }
    if (Flag==0){cat("\n Test case 60 Passed",file="Log_File_test.log",append = TRUE)}
  }
  else
  {
    cat ("\n Test Case 60 - No CODE is Flagged for type_1 this week", file = "Log_File_test.log", append = TRUE)
  }
}

#61.Check for CALC_ID format for all datasource 
subpop_id_a=function(df_output){
  df_output=df_output[df_output$E_S=="B" | df_output$E_S=="L",]
    flag=1
  for(i in 1:nrow(df_output)){
    newCol=paste(df_output$CODE[i],df_output$REL_USER_APPL_DESC[i],
                 df_output$Name[i],df_output$Name_Des[i],df_output$REL_OEM_NORMALIZED_GROUP[i],df_output$REL_MONTH_BUILD_DATE[i],df_output$REL_QUARTER_BUILD_DATE[i],df_output$BUILD_YEAR[i],df_output$SOURCE[i],sep ="-")
    if(newCol==as.character(df_output$CALC_ID[i]))
    {
      flag=0
       }
    else{
      
      cat("\n Test Case 61: Failed", as.character(df_output$CALC_ID[i]),file= "Log_File_test.log",append=TRUE)
    }
  }
  if(flag==0){cat("\n Test case 61 Passed",file="Log_File_test.log",append = TRUE)}
}
