SCRIPT=/opt/tunigit/steon/cmdb/cmdb.sh
DATA_DIR=/opt/tunigit/gh/stec26/latest-round/1-server-cmdb-submissions

for user in `ls $DATA_DIR`; do echo $user $($SCRIPT $DATA_DIR/$user 2>/dev/null ); done

