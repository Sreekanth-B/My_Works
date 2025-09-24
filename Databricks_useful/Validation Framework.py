
# In Below code we are doing comparision between uploaded file into SPO which is loaded into bronze table with final output data that will be writted into target table, we will filter the target table with file name to get the out df data for comparion

# Read Input 
Input_df = spark.sql(f"select * from {Input_df_table}")
display(Input_df)

#Read output
Out_df = spark.sql(f"SELECT * FROM schema.table WHERE meta_input_file_name LIKE '{Out_df_table}'")


# this logic is to get the rejected data for the SPO file and add them as null rows to the out df so that we have same number of rows in input and out dfs 

Out_df = Final_Outdf

missing_rows = Input_df.join(Out_df, on="internal_sales_order_line", how="left_anti")
#display(missing_rows)
null_columns = [lit(None).alias(c) for c in Out_df.columns if c != "internal_sales_order_line"]
missing_rows_with_nulls = missing_rows.select(
    *null_columns,
    col("internal_sales_order_line")
)
Out_df = Out_df.union(missing_rows_with_nulls)
display(Out_df)

# selecting only the columns that are present in input df 
Input_df_Cols = Input_df.columns
Output_df = Out_df.select(*Input_df_Cols).na.drop(how="all")

display(Output_df)

# Below code we are creating field called prefix from common field bcz we cant use common field as they also will gets participated in comparision due to incremental id generation

from pyspark.sql.functions import split, col, coalesce

input_with_prefix = Input_df.join(Output_df, on="internal_sales_order_line", how="left_anti").withColumn("prefix", split(col("internal_sales_order_line"), ";").getItem(0))
output_with_prefix = Output_df.join(Input_df, on="internal_sales_order_line", how="left_anti").withColumn("prefix", split(col("internal_sales_order_line"), ";").getItem(0))

display(input_with_prefix)
display(output_with_prefix)


# Below code will replace the common field id values with out df values to have target id values in input for comparision

updated_input = input_with_prefix.alias("input").join(output_with_prefix.alias("output"), on="prefix", how="left").select(coalesce(col("output.internal_sales_order_line"), col("input.internal_sales_order_line")).alias("internal_sales_order_line"), *[col(f"input.{c}") for c in input_with_prefix.columns if c != "internal_sales_order_line"] )

updated_input = updated_input.select(*Input_df_Cols)
display(updated_input)


from pyspark.sql.functions import split, col, when

# Extract prefix from Input_df and filter out rows with prefix values
in_prefix = Input_df.withColumn("prefix", when(col("internal_sales_order_line").contains(";"), split(col("internal_sales_order_line"), ";").getItem(0)).otherwise(None))

# Filter not null values
in_prefix_2 = in_prefix.filter(col("prefix").isNull())

in_prefix_3 = in_prefix_2.select(Input_df_Cols)
display(in_prefix_3)

Union_Input_df = in_prefix_3.union(updated_input)
display(Union_Input_df)

############ Comparing both dfs

from pyspark.sql.functions import col, when, lit, concat, coalesce

# Step 1: Get common columns (excluding the join key and fields to skip)
join_key = "internal_sales_order_line"
fields_to_skip = ['meta_create_ts']  # Placeholder to pass the fields to skip
common_columns = [col for col in Union_Input_df.columns if col in Output_df.columns and col != join_key and col not in fields_to_skip]

# Step 2: Join Input_df and Out_df
joined_df = Union_Input_df.alias("df1").join(Output_df.alias("df2"), on=join_key, how="inner")

# Step 3: Identify which columns have any discrepancies
discrepancy_flags = [
    when(
        (col(f"df1.{col_name}") != col(f"df2.{col_name}")) | 
        (col(f"df1.{col_name}").isNull() != col(f"df2.{col_name}").isNull()),
        1
    ).alias(f"{col_name}_discrepancy")
    for col_name in common_columns
]
discrepancy_check_df = joined_df.select(*discrepancy_flags)

# Step 4: Get list of columns that actually have discrepancies
discrepancy_cols = [
    col_name.replace("_discrepancy", "")
    for col_name in discrepancy_check_df.columns
    if discrepancy_check_df.filter(col(col_name) == 1).limit(1).count() > 0
]

# Step 5: Create detailed discrepancy expressions
discrepancy_exprs = [
    when(
        (col(f"df1.{col_name}") != col(f"df2.{col_name}")) | 
        (col(f"df1.{col_name}").isNull() != col(f"df2.{col_name}").isNull()),
        concat(
            coalesce(col(f"df1.{col_name}").cast("string"), lit("NULL")),
            lit(" != "),
            coalesce(col(f"df2.{col_name}").cast("string"), lit("NULL"))
        )
    ).alias(f"{col_name}_discrepancy")
    for col_name in discrepancy_cols
]

# Step 6: Build final discrepancy DataFrame
discrepancy_df = joined_df.select(join_key, *discrepancy_exprs)

# Step 7: Drop rows where no discrepancies are found
filtered_discrepancy_df = discrepancy_df.na.drop(how="all", subset=[f"{col}_discrepancy" for col in discrepancy_cols])

# Step 8: Display the result
display(filtered_discrepancy_df)

