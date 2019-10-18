
# Created By Sreekanth_B

# Python codes for Data Analysis 

# Binding the all parquet files into one dataframe

import os
import pyarrow.parquet as pq
import pandas as pd
import numpy as np

from pathlib import Path
import pandas as pd

# function
def parquets_to_df(parquet_folders, col_names):
    parquet_files = []
    for path_to_parquet in parquet_folders:
        files = os.listdir(path_to_parquet)
        for file in files:
            if ".parquet" in file:
                table = pq.read_table(path_to_parquet + file, columns=col_names).to_pandas()
                parquet_files.append(table)
    df = pd.concat(parquet_files).reset_index(drop=True)

    return df

# or
data_dir = Path('/home/notebooks/ap_25/data/model_input/quality_b_features/')
full_df = pd.concat(1 b b                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     b
    pd.read_parquet(parquet_file)
    for parquet_file in data_dir.glob('*.parquet')
)
print(full_df.head(10))

# Saving into single parquest file 

tempdf=full_df
cols_new=[str.lower(colval) for colval in tempdf.columns]
tempdf.columns=cols_new
tempdf.to_parquet('final_Parquet_file.parquet')

# Converting the Parquest file into Csv file

import pandas as pd

pandas_df = pd.read_parquet('final_Parquet_file.parquet')
pandas_df.to_csv('final_Parquet_file.csv')

# Spliting the csv file and saving the splited files in specific folder
# here we are creating the small files which are 3rd part of big file
import sys
fil=sys.argv[1]
fil = "main_file_.csv"
csvfilename = open(fil, 'r').readlines()
file = 1
l=len(csvfilename)
k = round(len(csvfilename)/3.0)
for j in range(l):
    if j % k == 0:
        open("Path_to_save/" +"main_file_"+ str(file) + '.csv', 'w+').writelines(csvfilename[j:j+k]) 
        file += 1
		

# Using Python in unix file system 
'''
$ipython

To quit from python

$exit
'''
