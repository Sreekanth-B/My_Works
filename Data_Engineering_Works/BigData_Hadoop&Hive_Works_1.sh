
# to open into hive environment

/usr/bin/hive

# Shell scripts creation in hive 

/usr/bin/hive <<EOF

println("LOG: OUTPUT TABLE ------spi_main_table-------")

println("LOG:failed_volume  :"+ select count(*)  from quality_engine_mo.spi_main_table where failed_volume  IS NULL)

EOF

# For Schema check

describe tablename; 

# For tables in Database

describe databasename



# TO DELETE ALL THE LINES IN SCRIPT :::	

In vi I use

:%d
where

: tells vi to go in command mode
% means all the line
d : delete
On the command line,

# Select funtion in hive 

select num,
    collectUDAF(id, values) as new_map 
from
    (
    SELECT num,id,collect_set(value) as values FROM tbl GROUP BY num,id
    ) as sub
GROUP BY num


$ /usr/bin/hive -H
usage: hive
 -d,--define <key=value>          Variable subsitution to apply to hive
                                  commands. e.g. -d A=B or --define A=B
    --database <databasename>     Specify the database to use
 -e <quoted-query-string>         SQL from command line
 -f <filename>                    SQL from files
 -H,--help                        Print help information
    --hiveconf <property=value>   Use value for given property
    --hivevar <key=value>         Variable subsitution to apply to hive
                                  commands. e.g. --hivevar A=B
 -i <filename>                    Initialization SQL file
 -S,--silent                      Silent mode in interactive shell
 -v,--verbose                     Verbose mode (echo executed SQL to the
                                  console)
                                  
                                  

# Hadoop command
# == To list out the directories and files present in this path

hadoop fs -ls adl://eaasedlstgadls.azuredatalakestore.net/data/mo/qa

# Moving the large datasets between two clueters in hadoop using distcp

#current DB -> Restore Folder
#move current dbs to restore folder (with renaming)
hadoop distcp $current_folder_path/quality_compute.db $restore_folder_path/quality_compute_old.db
hadoop distcp $current_folder_path/quality_primary.db $restore_folder_path/quality_primary_old.db

# Cleaning the current folder after moving

# clean up current folder
#delete files from existing location
#hadoop fs -rm -r $current_folder_path/quality_compute_old.db
#hadoop fs -rm -r $current_folder_path/quality_primary_old.db


# Hive shell script to check the error log 

if grep -l error *.log; then
        echo "THERE ARE ERRORS IN THE EXTRACT"
fi
