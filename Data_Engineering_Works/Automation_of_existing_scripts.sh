
# File created to automate the execution of Data Engineering script

# After execution code gives the column names and their counts at the end which after can be evalivated with the previous records

# using to check the data connsistancy

cd ..
cd QA_Test/

sh input_count.sh >> temp.txt
# below we are removing 
rm new_results.txt
grep "^LOG" temp.txt >>final_temp.txt
cut -d ':' -f 2,3 final_temp.txt  >>output.txt

sed -e 's/[\t ]//g;/^$/d' output.txt >>new_results.txt

rm temp.txt
rm final_temp.txt
rm output.txt

cut -d ':' -f 1 new_results.txt
cut -d ':' -f 2 new_results.txt
