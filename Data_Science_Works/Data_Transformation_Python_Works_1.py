

# Created By Sreekanth_B

# Data Analysis using Python

==================================================================================================================================================================
========== # Reading the data from different file formates

========= # For csv files
Pandas_csv_df = pd.read_csv("file path/filename")
pandas_df.to_csv('final_Parquet_file.csv')

========== # For Parquet files

pandas_parquet_df = pd.read_parquet('final_Parquet_file.parquet')
tempdf.to_parquet('final_Parquet_file.parquet')

==========# for Excel files 

path = '... Personal folders/Sreekanth_B/'
Excel_df = pd.read_excel(path+'I Report_X.xlsm', sheet_name = 0)

pd.DataFrame().to_excel(writer, sheet_name=sheet_name, index=False)

== reading excel data from specific sheet_name

dataset = pd.read_excel("/home/.../notebooks/Business/Workflow (XBL).xlsx",
                        sheet_name = "VAL_Sheet_2")

===============================  # For parquet files


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

======================  # or


data_dir = Path('/home/notebooks/ap_25/data/model_input/quality_b_features/')
full_df = pd.concat(1 b b                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     b
    pd.read_parquet(parquet_file)
    for parquet_file in data_dir.glob('*.parquet')
)
print(full_df.head(10))


===============================================================

# Saving into single parquest file 

tempdf=full_df
cols_new=[str.lower(colval) for colval in tempdf.columns]
tempdf.columns=cols_new
tempdf.to_parquet('final_Parquet_file.parquet')

====================== # Reading data from ADLS (In DSVM)
# from UAT Environment

import sys
sys.path.insert(0,'/data/code/adl')
from ADLSHandler import download, upload, downloadAsCsv
import yaml
env = 'UAT'

# Downloading all files matching pattern into DSVM as csv

downloadAsCsv("ADLS_path/pattern_*", '/home/notebooks/DSVM_Path/File_name', platform = env)

# Downloading each file 

download("ADLS_File_Path", 'DSVM_path', platform = env)

 
================================== TO use python in unix 

$ipython

To quit from python

$exit


============= 
# Creating new dataframe by selecting specific columns from main dataframe 

val_df = pd.DataFrame(dataset, columns = ['file','variable','original_name',
                                          'avg_failrate','low_failrate','high_failrate','Actuals','Description']) 
										  
										  
============= Saving the df into parquet (Python 3)

import pyarrow.parquet as pq
tempdf=full_df
cols_new=[str.lower(colval) for colval in tempdf.columns]
tempdf.columns=cols_new
tempdf.to_parquet('final_Parquet_file.parquet')


=====================================================================================================================================

==================================================================================
======================== TO split csv file into number of files (based on total length)and save the splited files in specific folder
# Here i am splitnig the file to create a file with len which is having 3rd part of total file length

import sys
fil=sys.argv[1]
fil = "options_df_fail_1_.csv"
csvfilename = open(fil, 'r').readlines()
file = 1
l=len(csvfilename)
k = round(len(csvfilename)/3.0)
for j in range(l):
    if j % k == 0:
        open("/home/.../notebooks/data/parallel_reports/options_df/" +"options_df_fail_1_"+ str(file) + '.csv', 'w+').writelines(csvfilename[j:j+k]) 
        file += 1


										  
==================================================================================================================================================================
===== Dataframe tranformations

# File format conversions

# Parquet to csv

pandas_df = pd.read_parquet('final_Parquet_file.parquet')
pandas_df.to_csv('final_Parquet_file.csv')

# Csv to parquet

Pandas_csv_df = pd.read_csv("file path/filename")
tempdf.to_parquet('final_Parquet_file.parquet')

==================================================================================================================================================================
# to check the length of df
len(full_df)

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

# Selecting two columns to check the sample data

full_df[['col_1','col_2']].head(22)


===========================================

# To get count of factors of Column (group by column and count of each factor)

Excel_df['col_name'].value_counts()

# To get Duplicates count in column

Pandas_df['col_name'].nunique()

====================  # Random selection of df

df.sample(n = 150) 


===============  Filtering and aggregation opperations on pandas dataframe
# Dealing with NA values 
###  Filling NA values  with 'Unknown'

pandas_df_filtered_final['Fail Code'].fillna('Unknown', inplace = True)

# To check the max and min of specified column

full_df['col_name'].max
full_df['col_name'].min

# or
full_df.col_name.max()
full_df.col_name.min()

=============  # filtering the data for specified date and saving into new df 

#date_df1 = full_df[full_df['col_name'] == "*2017*"]

date_df = full_df[(pd.to_datetime(full_df['col_name'], format="%m/%d/%Y")  <= pd.to_datetime("2017-12-31")) & (pd.to_datetime(full_df['col_name'], format="%m/%d/%Y")  >= pd.to_datetime("2017-01-01"))].apply(lambda x: x.strftime("%m/%d/%Y %H:%M:%S")) 
# changing the formate of date after filtering 

date_df['col_name'] =date_df['col_name'].apply(lambda x: x.strftime("%m/%d/%Y %H:%M:%S"))


build_date_new = build_date[build_date['REL_CMP_PAYMENT_DATE_LIST'].apply(lambda x: all(True if j.year == 2017 else False for j in [pd.to_datetime(i) if len(x) > 0 else [] for i in x]))]
#sc = build_date_new[build_date_new['REL_CMP_PAYMENT_DATE_LIST'].apply(lambda x : any(True if len(i)>0 else False for i in x))]

#print(build_date_new['REL_CMP_PAYMENT_DATE_LIST'])

for col in build_date_new['REL_CMP_PAYMENT_DATE_LIST']:
    print (col)
	
	
================== # Filtering out the null values in the column and saving into new df

new_df = ff_df.col_name.apply(lambda x: True if x is not None else False)
 
=================================================================================== 

# Soring the df based on two columns

sort_df = sort_df.sort_values(by=['col_1', 'col_2'])


================= # Concating Multiple columns in Pandas df and storing in list:

New_CALC_ID=Pre_X_W_df['CODE'].astype(str)+'-'+Pre_X_W_df['REL_OEM_NORMALIZED_GROUP'].astype(str)+'-'+Pre_X_W_df['REL_QUARTER_BUILD_DATE'].astype(str)+'-'+Pre_X_W_df['REL_ENGINE_NAME_DESC'].astype(str)+'-'+Pre_X_W_df['SOURCE'].astype(str) 
 
=============================================================================================================================================================
=========== #Dataframe join operations

# Merging two data frams based on specified column 
tmp_df = tmp_df2.merge(tmp_df3, on = [col])

# merging two dfs where df1 is having X col and df2 having Z column 

df1.merge(df2, left_on=["X"], right_on=["Z"])

# creating new column from two col values

tmp_df['New_col'] = tmp_df.col_1 / tmp_df.col_2

================================== # To write Query directly on dataframe

pandas_df.query('Incident_Num > 1')

# Average of column
pandas_df.query('Incident_Num > 1')['Incident_Num'].sum() - pandas_df.query('Incident_Num > 1').shape[0]


# Reading Only filtered data into new df

pandas_df_filtered = \
    pandas_df_filtered.loc[~pandas_df_filtered['Incident Source'].isnull(),:]

=================================================================================================
	
# Ploting histogram for values < 500 

pandas_df_filtered.query('Dayes_Investigating < 500')['Dayes_Investigating'].hist(bins = 100)
plt.show()

# Add new column to data and drop rows which having missing values in new column

data = pd.concat([data, master_file[['New_col']]], axis = 1)
bool = list(data.New_col.isnull())
data = data.loc[np.logical_not(bool)]
data.reset_index(inplace = True, drop = True)


=================================================================================================
==================  # Machine learning model calculations 

# Split data into train (80%) and test (20%)
X_train, X_validation, y_train, y_validation = train_test_split(final_features, data.issue_dummy, train_size = 0.80, random_state = 42)

# Use grid search to get optimal value of parameters using 5 fold cross validation on the train data only, leave validation data unseen
# A larger set of parameters may be used for tuning by grid search based on computer RAM and runtime

param = {'learning_rate':[.03], 'n_estimators':[300, 500], 'max_depth':[3, 4], 'subsample':[.9], 'max_features':[.8, .9]}
grid_search_obj = GridSearchCV(GradientBoostingClassifier(), param, cv = 5)
grid_search_obj.fit(X_train, y_train)
print(grid_search_obj.best_estimator_)
print(grid_search_obj.best_score_)

# Apply model on best parameters
best_model = grid_search_obj.best_estimator_
best_model.fit(X_train, y_train)
pred_gb_tst = best_model.predict(X_validation)
print(confusion_matrix(y_validation, pred_gb_tst))

features_imp_data.sort_values(by = ['score'], ascending = True, inplace = True)

# Plot top 20 features
feature_imps_top_20 = features_imp_data.iloc[(features_imp_data.shape[0]-20):,:]
feature_imps_top_20.plot(kind = 'barh', x = 'feature', y = 'score', legend = False, figsize = (6, 10))
plt.title('Gradient Boosting: Top 20 Features\' Importance')
plt.xlabel('Importance')
plt.show()

=================================================================================================


===================================================================================================================================================================

===================================================================================================================================================================

===================================================================================================================================================================


===================================================================================================================================================================


===================================================================================================================================================================

===================================================================================================================================================================

===================================================================================================================================================================


===================================================================================================================================================================
===================================================================================================================================================================

===================================================================================================================================================================

===================================================================================================================================================================


===================================================================================================================================================================
===================================================================================================================================================================

===================================================================================================================================================================

===================================================================================================================================================================


===================================================================================================================================================================
