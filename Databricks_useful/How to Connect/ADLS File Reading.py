# #Access to ADLS

CELL -1 

service_credential = dbutils.secrets.get(scope="<scope name>",key="<secret name>")
spark.conf.set("fs.azure.account.auth.type.<adlsname>.dfs.core.windows.net", "OAuth")
spark.conf.set("fs.azure.account.oauth.provider.type.<adlsname>.dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider")
spark.conf.set("fs.azure.account.oauth2.client.id.<adlsname>.dfs.core.windows.net", "<Application / client ID of secret name>")
spark.conf.set("fs.azure.account.oauth2.client.secret.<adlsname>.dfs.core.windows.net", service_credential)
spark.conf.set("fs.azure.account.oauth2.client.endpoint.<adlsname>.dfs.core.windows.net", "https://login.microsoftonline.com/5d471751-9675-428d-917b-70f44f9630b0/oauth2/token")


# to list all the directories in the ADLS path
display(dbutils.fs.ls("abfss://<container name>@<storage name>.dfs.core.windows.net/"))

# To read the delta file
%sql
SELECT * FROM delta.`abfss://<container name>@<storage name>.dfs.core.windows.net/folder/etc ` where flag = 'false'

# To read Parquet File
SELECT * FROM parquet.`abfss://<container name>@<storage name>.dfs.core.windows.net/Stage/File1.parquet`

# Reading the file using Spark SQL
path="BronzeLayer/OCT/SupplyChain/OCT_RCV_NRP/"
display(spark.sql("SELECT * FROM delta.`abfss://<container name>@<storage name>.dfs.core.windows.net/WestEurope/"+path+"`"))
