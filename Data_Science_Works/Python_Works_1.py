# Created By Sreekanth_B

# Python codes for Data Analysis 

# Reading the data from different file formates

# For csv files
Pandas_csv_df = pd.read_csv("file path/filename")

# For Parquet files

pandas_parquet_df = pd.read_parquet('final_Parquet_file.parquet')

# Reading data from ADLS
# from UAT Environment

import sys
sys.path.insert(0,'/data/code/adl')
from ADLSHandler import download, upload, downloadAsCsv
import yaml
env = 'UAT'

# Downloading all files matching pattern into DSVM as csv

downloadAsCsv("ADLS_path/pattern_*", '/home/qx816/notebooks/DSVM_Path/File_name', platform = env)

# Downloading each file 

download("ADLS_File_Path", 'DSVM_path', platform = env)


# File format conversions

# Parquet to csv

pandas_df = pd.read_parquet('final_Parquet_file.parquet')
pandas_df.to_csv('final_Parquet_file.csv')

# Csv to parquet

Pandas_csv_df = pd.read_csv("file path/filename")
tempdf.to_parquet('final_Parquet_file.parquet')

# Filtering and aggregation opperations on pandas dataframe

# to check sample data 
Pandas_csv_df.head()

# To check the number of columns and rows of dataframe
df.shape()

# to check the columns names present in pandas df

col_names = online_tracker.columns.tolist()
col_names = [str.upper(cval) for cval in col_names]

for col in full_df.columns: 
    print(col)	
#df.dtypes

# to check the length of df
len(full_df)

# To check the max and min of specified column

full_df['col_name'].max
full_df['col_name'].min

# or
full_df.col_name.max()
full_df.col_name.min()

# filtering the data into new df

#date_df1 = full_df[full_df['col_name'] == "*2017*"]

date_df = full_df[(pd.to_datetime(full_df['col_name'], format="%m/%d/%Y")  <= pd.to_datetime("2017-12-31")) & (pd.to_datetime(full_df['col_name'], format="%m/%d/%Y")  >= pd.to_datetime("2017-01-01"))].apply(lambda x: x.strftime("%m/%d/%Y %H:%M:%S")) 

# Selecting two columns to check the sample data

full_df[['col_1','col_2']].head(22)

# Filtering out the null values in the column and saving into new df

new_df = ff_df.col_name.apply(lambda x: True if x is not None else False)

# Soring the df based on two columns

sort_df = sort_df.sort_values(by=['col_1', 'col_2'])




