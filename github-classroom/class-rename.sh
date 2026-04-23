echo "Renaming the github classroom directories"
echo ...
echo ROSTER: $ROSTER
echo PRE: $PRE
echo POST: $POST
echo
echo To try out ------------------------
for dir in `ls`; do export VAR1=`echo $dir | sed -e "s/$PRE-//g"`; VAR2=`grep $VAR1 $ROSTER | awk -F\; '{print $1}'`; echo mv $PRE-$VAR1 $POST-$VAR2;  done

echo
echo After 5 seconds, execute ...
sleep 5
echo

for dir in `ls`; do export VAR1=`echo $dir | sed -e "s/$PRE-//g"`; VAR2=`grep $VAR1 $ROSTER | awk -F\; '{print $1}'`; mv $PRE-$VAR1 $POST-$VAR2;  done

