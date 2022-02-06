# This is example command template.
# -> To run: ./main.py -c ls-sort -f examples/params/ls-sort-data.csv 
# -> Data/params example in examples/data/ls-sort.csv
#
echo '--------------------------------------------------'
echo 'List PRM-NUM most recent files in <<PRM-FILEPATH>>'
echo '--------------------------------------------------'
ls -latr PRM-FILEPATH | tail -PRM-NUM
