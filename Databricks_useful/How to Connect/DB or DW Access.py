Cell 1:
properties = {
  "databricks_sp_secret_key": "<secret name>", 
  "databricks_sp_secret_scope": "<scope name>",
  "databricks_sp_object_id": "App / Cliend ID of Secret/Service principle",
  "databricks_sp_tennant_id": "tenent id of Secret/Service principle",
  "adls_storage": "abfss://<container>@<adls>.dfs.core.windows.net//",
  "is_initial_load": True,
}
databricks_sp_secret = dbutils.secrets.get(scope=properties["databricks_sp_secret_scope"],key=properties["databricks_sp_secret_key"])
# #Get azure token Note- make sure you have msal library in cluster

from msal import ConfidentialClientApplication

service_principal_id = properties["databricks_sp_object_id"]
    
service_principal_secret = databricks_sp_secret

authority = "https://login.microsoftonline.com/" + properties["databricks_sp_tennant_id"]

resource = 'https://database.windows.net//.default'

app = ConfidentialClientApplication(
    client_id=service_principal_id,
    client_credential=service_principal_secret,
    authority=authority
)
result = app.acquire_token_for_client(scopes=[resource])
prod_token = result['access_token']



Cell 2:

from pyspark.sql.types import IntegerType
from pyspark.sql.functions import col
from pyspark.sql import functions as F
db_url="jdbc:sqlserver://<server/Host name>:1433;database=<database name>;trustServerCertificate=true;"
df = spark.read \
             .format("jdbc") \
             .option("url", db_url) \
             .option("query", "SELECT TABLE_SCHEMA,  TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE <> 'BASE TABLE'") \
             .option("accessToken", prod_token) \
             .option("encrypt", "true") \
             .option("hostNameInCertificate", "*.database.windows.net") \
             .load()
display(df)


CELL 3: Connect to mySQL

# stored the mysql server details DBX scope as secrets

servername=dbutils.secrets.get("<scope>","servername")
database=dbutils.secrets.get("<scope>","database")
username=dbutils.secrets.get("<scope>","username")
password=dbutils.secrets.get("<scope>","password")

CELL 4: Connecting to mysql below code will create a Url connection

Url=f"jdbc:mysql://{servername}.mysql.database.azure.com:3306/{database}?useSSL=true&requireSSL=true"
customer_ct_mapping=[]
jdbc_options={'url':Url,
              'user':username,
              'password':password,
               "batchsize": 1000  
}

CELL 5: Below code will read data from mysql table into df
name = 'mysql_table'
df=spark.read.format('jdbc').options(**jdbc_options).option('dbtable',name).load()

CELL 5: below code will write the df into above mysql table
df.write.format('jdbc').options(**jdbc_options).option('dbtable','customer').mode('overwrite').save()



