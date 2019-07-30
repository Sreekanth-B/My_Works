# File consists of different operations done using Pyspark

# Pyspark is a Python API for Spark

# Python comes with several libraries related to machine learning and natural language processing. 
#  This aids in data analysis and also has statistics that are much mature and time-tested. For instance, numpy, pandas, scikit-learn, seaborn and matplotlib.

#importing required packages and libraries

from pyspark.sql import SparkSession, HiveContext
spark = SparkSession.builder.appName('Ops').getOrCreate()

from pyspark.sql.types import StructType, StructField
from pyspark.sql.types import DoubleType, IntegerType, StringType

import pyspark
import pandas as pd

# Reading the data
wb_out= spark.read.option("header","true").option("delimiter",",").option("inferSchema", "true").format("csv").load("/home/notebooks/Sreekanth/input_1.csv")

#Schema and count of pyspark dataframe
#gives the columns values 

wb_out.columns 
wb_out.printSchema()
wb_out.count()

# Converting Dataframe into table 

#useful when we want to write direct sql quiries on the data and saving the result into new df

sqlContext.registerDataFrameAsTable(wb_out1, "wb_out1")
sqlContext.registerDataFrameAsTable(wb_out2, "wb_out2")

# Writting the sql commands on top of registered tables

ck = sqlContext.sql("select max(DATE) as Max, min(DATE) as Min from wb_out1")

ck.show()

co=sqlContext.sql("select col_name from wb_out1 where algo == 'MA_Ribbon' and cast(PRIORITY_SCORE as int)<0 ")

co.count()

co=sqlContext.sql("select SCORE_REL_BUCKET,count(CALC_ID) from wb_out1 where calc_date == '2019-06-07' GROUP BY SCORE_REL_BUCKET ")

cd=sqlContext.sql("select distinct(DATE) from wb_out1")

# Saving the results into csv 
# first we need to convert into pandas df and then we can save using python function

cdf = cd.toPandas()

cdf.to_csv('Wb_L_file_May_2_Gold.csv')



# to get the summary statistics (mean, standard deviance, min ,max , count) of numerical columns in a DataFrame
df.describe().show()

# ============= column wise
df.describe('col_name').show()

# To select column(s) from the DataFrame
df.select('col_1','Age').show(5)

#  to find the number of distinct product in train and test files
train.select('Product_ID').distinct().count(),test.select('Product_ID').distinct().count()

# Let us check what are the categories for Product_ID, which are in test file but not in train file by applying subtract operation.We can do the same for all categorical features.

diff_cat_in_train_test=test.select('Product_ID').subtract(train.select('Product_ID'))
diff_cat_in_train_test.distinct().count()

#  What if I want to calculate pair wise frequency of categorical columns ....?
# We can use crosstab operation on DataFrame to calculate the pair wise frequency of columns. Let’s apply crosstab operation on ‘Age’ and ‘Gender’ columns of train DataFrame

train.crosstab('Age', 'Gender').show()

# What If I want to get the DataFrame which won’t have duplicate rows of given DataFrame ..?

train.select('Age','Gender').dropDuplicates().show()

# =========================================================================================================

# What if I want to drop the all rows with null value ..?
The dropna operation can be use here. To drop row from the DataFrame it consider three options.

how– ‘any’ or ‘all’. If ‘any’, drop a row if it contains any nulls. If ‘all’, drop a row only if all its values are null.
thresh – int, default None If specified, drop rows that have less than thresh non-null values. This overwrites the how parameter.
subset – optional list of column names to consider.

train.dropna().count()

# What if I want to fill the null values in DataFrame with constant number ..?
Use fillna operation here. The fillna will take two parameters to fill the null values.

#  value:
#  It will take a dictionary to specify which column will replace with which value.
#  A value (int , float, string) for all columns.
# subset: Specify some selected columns.
# Let’s fill ‘-1’ inplace of null values in train DataFrame.

train.fillna(-1).show(2)
# To write SQL Queries on DataFrame
#first register the df as table

train.registerAsTable('train_table')
# use below syntax to write commands

new_df  = sqlContext.sql('select unique(Product_ID) from train_table')
sqlContext.sql('select Age, max(Purchase) from train_table group by Age').show()

# TO use Pyspark in Unix

1 . enter pyspark
2 . opens pyspark environment where we can write pyspark commands.
