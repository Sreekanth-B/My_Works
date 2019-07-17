
# Created By Sreekanth_B

# Python codes for Data Analysis 

# Binding the all parquet files into one dataframe

import os
import pyarrow.parquet as pq
import pandas as pd
import numpy as np

from pathlib import Path
import pandas as pd

data_dir = Path('/home/qx816/notebooks/ap_25/data/model_input/quality_b_features/')
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


# Using Python in unix file system 

$ipython

To quit from python

$exit
