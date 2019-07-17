
# Created By Sreekanth_B
# Python Functions for Preprocessing and Post processing of data


# 1 Creating required folder structure in the DSVM for model setup

import os
import sys

def create_dir(path_to_create):
    try:
        os.mkdir(path_to_create)
    except Exception as err:
        print(err)

#base path where model io , log , intermediate files will be stored

base_path='/home/qx816/notebooks/Folder_creation/Try/'
platform_list=['First_b','First_x','First_l']
quality_list=['quality_b','quality_x','quality_l']
output_names=['out_b','out_x','out_l']



#create base path,ip,op,logs

#total_folders =create_dir(base_path)

ip=base_path+'model_input/'
create_dir(ip)

op=base_path+'model_output/'
create_dir(op)

log=base_path+'logs/'
create_dir(log)

raw=ip+'raw/'
create_dir(raw)

#create platform specific folders in ip
platform_ip=[ip+platform+'/' for platform in platform_list]

[create_dir(platform) for platform in platform_ip]

#create folders for quality
ip_quality=[ip+quality+'/' for quality in quality_list]
[create_dir(quality) for quality in ip_quality]

#create platform specific log folders
log_platform=[log+platform+'/' for platform in platform_list]
[create_dir(log_plat) for log_plat in log_platform]

#create platform specific output
platform_op=[op+platform+'/' for platform in platform_list]
[create_dir(plat_op) for plat_op in platform_op]

#create folders in raw
raw_platform=[raw+platform+'/' for platform in platform_list]
[create_dir(raw_plat) for raw_plat in raw_platform]

#input parquet and incident file folders
engine_build_=[plat_ip+'eng_details/' for plat_ip in platform_ip]
[create_dir(eng_build) for eng_build in eng_build_]
engine_claim_=[plat_ip+'eng_claim_details/' for plat_ip in platform_ip]
[create_dir(eng_claim) for eng_claim in eng_claim_]
incidents=[plat_ip+'incidents_csv/' for plat_ip in platform_ip]
[create_dir(incid) for incid in incidents]

#output folders  
parallel_reports=[plat_op+'parallel_reports/' for plat_op in platform_op]
[create_dir(par_rep) for par_rep in parallel_reports]

#options_df folder
parallel_reports_options=[plat_op+'parallel_reports/options_df/' for plat_op in platform_op]
[create_dir(par_rep) for par_rep in parallel_reports_options]

#fail code folder
parallel_reports_fail=[plat_op+'parallel_reports/fail_code/' for plat_op in platform_op]
[create_dir(par_rep) for par_rep in parallel_reports_fail]

#fault code folder
parallel_reports_fault=[plat_op+'parallel_reports/fault_code/' for plat_op in platform_op]
[create_dir(par_rep) for par_rep in parallel_reports_fault]

#upload folder
upload_folder=[plat_op+'upload_folder/' for plat_op in platform_op]
[create_dir(upfolder) for upfolder in upload_folder]
censor_files=[plat_op+'censor_files/' for plat_op in platform_op]
[create_dir(censfile) for censfile in censor_files]
output_pq=[plat_op+output_name+'/' for (plat_op,output_name) in zip(platform_op,output_names)]
[create_dir(outpq) for outpq in output_pq]
