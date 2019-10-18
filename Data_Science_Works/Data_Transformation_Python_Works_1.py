# Created By Sreekanth_B

# Python codes for Data Analysis 

# Reading the data from different file formates

# For csv files
Pandas_csv_df = pd.read_csv("file path/filename")
pandas_df.to_csv('final_Parquet_file.csv')

# For Parquet files

pandas_parquet_df = pd.read_parquet('final_Parquet_file.parquet')
tempdf.to_parquet('final_Parquet_file.parquet')

# for Excel files 

path = '... Personal folders/Sreekanth_B/'
Excel_df = pd.read_excel(path+'I Report_X.xlsm', sheet_name = 0)

pd.DataFrame().to_excel(writer, sheet_name=sheet_name, index=False)

# Reading data from ADLS
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

# Dealing with NA values 
################  Filling NA values  with 'Unknown'

pandas_df_filtered_final['Fail Code'].fillna('Unknown', inplace = True)

# To check the max and min of specified column

full_df['col_name'].max
full_df['col_name'].min

# or
full_df.col_name.max()
full_df.col_name.min()

# filtering the data for specified date and saving into new df 

#date_df1 = full_df[full_df['col_name'] == "*2017*"]

date_df = full_df[(pd.to_datetime(full_df['col_name'], format="%m/%d/%Y")  <= pd.to_datetime("2017-12-31")) & (pd.to_datetime(full_df['col_name'], format="%m/%d/%Y")  >= pd.to_datetime("2017-01-01"))].apply(lambda x: x.strftime("%m/%d/%Y %H:%M:%S")) 
# changing the formate of date after filtering 

date_df['col_name'] =date_df['col_name'].apply(lambda x: x.strftime("%m/%d/%Y %H:%M:%S"))

# Selecting two columns to check the sample data

full_df[['col_1','col_2']].head(22)

# Filtering out the null values in the column and saving into new df

new_df = ff_df.col_name.apply(lambda x: True if x is not None else False)

# Soring the df based on two columns

sort_df = sort_df.sort_values(by=['col_1', 'col_2'])

# To get count of factors of Column

Excel_df['col_name'].value_counts()

# To get Duplicates count in column

Pandas_df['col_name'].nunique()

# Random selection of df

df.sample(n = 150) 

# Merging two data frams based on specified column 
tmp_df = tmp_df2.merge(tmp_df3, on = [col])

# merging two dfs where df1 is having X col and df2 having Z column 

df1.merge(df2, left_on=["X"], right_on=["Z"])

# creating new column from two col values

tmp_df['New_col'] = tmp_df.col_1 / tmp_df.col_2

# To write Query directly

pandas_df.query('Incident_Num > 1')

# Average of column
pandas_df.query('Incident_Num > 1')['Incident_Num'].sum() - pandas_df.query('Incident_Num > 1').shape[0]


# Reading Only filtered data into new df

pandas_df_filtered = \
    pandas_df_filtered.loc[~pandas_df_filtered['Incident Source'].isnull(),:]
	
# Ploting histogram for values < 500 

pandas_df_filtered.query('Dayes_Investigating < 500')['Dayes_Investigating'].hist(bins = 100)
plt.show()

# Add new column to data and drop rows which having missing values in new column

data = pd.concat([data, master_file[['New_col']]], axis = 1)
bool = list(data.New_col.isnull())
data = data.loc[np.logical_not(bool)]
data.reset_index(inplace = True, drop = True)

# Machine learning model calculations 

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



