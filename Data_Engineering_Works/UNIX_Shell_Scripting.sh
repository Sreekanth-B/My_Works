

======= to know number of records in file

>> ls
dir_1  dir_2  opt_df_a.csv  opt_df_1.csv 

>> wc -l opt_df*.csv
  23724 opt_df_a.csv
  28989 opt_df_1.csv
  52713 total

>> ls
C_b.csv  W_M.csv  W_Y.csv

>> wc -l W_M.csv
19141 W_M.csv

================================================================================================================
To check the files in respect path in UAT DSVM 

ll -h /data/data/model_out/pqout_x/*.parquet
ll -h /data/data/model_in/upload_folder/*.csv

================================================================================================================
===========================================================================================================================

HOW CAN I DELETE ALL THE LINES IN SCRIPT :::	

In vi I use

:%d
where

: tells vi to go in command mode
% means all the line
d : delete
On the command line,
=============================================================== 
=====================================================================================================================================

=========== TO navigate to respective directory

cd notebooks/ap_25/ds/Weibull/src/

ls -a ------------- TO see hidden files present in directory

rm -r <directory name>  =========== to remove directory even it is having files

cp <file_name> <path>  =========== to copy the file to specified path
# the destination directory has to exist
# if the filename already exists there, it will be overwritten

mv <old_name> <new_name>  ======= to rename the file

mv <old_path> <new_path>   ========= to move file from one place to other place

=====================================================================================================================================

To avoid being asked about removing files, add the -f ("force") option:

rm -f /path/to/file
rm -r -f Weibull_A16
=====================================================================================================================================# The below code is a sample File created to automate the execution of Data Engineering Validation Scripts to generate the differents values

=================# ERROR check in log files created in HDFS

grep -l error *.log &> error.log
grep -n error *.log >> error.log
#echo "There are errors in this file"  && grep -l ERROR *.log

if grep -l ERROR *.log; then
        echo "THERE ARE ERRORS IN THE EXTRACT"
fi

=====================================================================================================================================# The below code is a sample File created to automate the execution of Data Engineering Validation Scripts to generate the differents values

# After execution code gives the column names and their counts at the end which after can be evalivated with the previous records

# using to check the data connsistancy, Data Redundency and some basic as well as Business Scenarios


cd ..
cd QA_Scripts/

sh input_count.sh >> temp.txt
rm INPUT_COUNT_output.txt
grep "^LOG" temp.txt >>final_temp.txt  								// --------- filtering using pattern LOG
cut -d ':' -f 2,3 final_temp.txt  >>output.txt 						//  ----------- selecting only 2 and 3 columns delimeted by ':'

sed -e 's/[\t ]//g;/^$/d' output.txt >>INPUT_COUNT_output.txt 		//  --------------To remove blank spaces

rm temp.txt
rm final_temp.txt
rm output.txt

cut -d ':' -f 1 INPUT_COUNT_output.txt
cut -d ':' -f 2 INPUT_COUNT_output.txt




//

==========================================================================================================================
========= TO execute scripts without showing its running in DSVM
-- it starts with nohup and ends with '&'
--- here wb_run_call_R_wo_auth.py is a python file running in UAT using the config file conf_file_uat.yaml and results are saving in wbl.log

nohup python wb_run_call_R_wo_auth.py UAT /home/user_1/notebooks/ds/conf_file_uat.yaml>/tmp/wbl.log &

-------ANd to see the results of above script we use

nohup: ignoring input and redirecting stderr to stdout

tail -f /tmp/wbl.log

ps aux|grep 97994  ---------- the number indicates the task id it is running below

==================== Perl Code for Continuous execution of codes in DSVM
// place all the below code from print statement in .py file and execute the the shell script as bellow

// --------- nohup perl execution_wbl.pl >/tmp/pl.log &

print("Executing l ",`date`);
#data download
print `python /home/user_1/notebooks/ds/src/first_main.py UAT /home/user_1/notebooks/ds/conf_file_uat.yaml >/tmp/wbll.log`;
#create options
print `Rscript /home/user_1/notebooks/ds/R/bayes_opt_df.R /home/user_1/notebooks/ds/conf_file_uat.yaml fail_in.csv >>/tmp/wbll.log`;
#Run from options
print `Rscript /home/user_1/notebooks/ds/R/bayes_opt.R /home/user_1/notebooks/ds/conf_file_uat.yaml fail_in.csv >>/tmp/wbll.log`;
#Post process#
print `Rscript /home/user_1/notebooks/ds/R/bayes_post_pro.R /home/user_1/notebooks/ds/conf_file_uat.yaml fail_in.csv  >>/tmp/wbll.log`;

#create options
print `Rscript /home/user_1/notebooks/ds/R/bayes_opt_df.R /home/user_1/notebooks/ds/conf_file_uat.yaml fault_in.csv >>/tmp/wbll.log`;
#Run from options
print `Rscript /home/user_1/notebooks/ds/R/bayes_opt.R /home/user_1/notebooks/ds/conf_file_uat.yaml fault_in.csv >>/tmp/wbll.log`;
#Post process#
print `Rscript /home/user_1/notebooks/ds/R/bayes_post_pro.R /home/user_1/notebooks/ds/conf_file_uat.yaml fault_in.csv  >>/tmp/wbll.log`;
# Upload results #
print `python /home/user_1/notebooks/ds/src/results_upload.py DEV /home/user_1/notebooks/ds/conf_file_uat.yaml >>/tmp/wbll.log`;




=====================================================================================================================================
