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
