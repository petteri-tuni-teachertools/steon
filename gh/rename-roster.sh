#!/bin/bash

function process() {
for line in `cat ../../roster.csv`
  do export ALIAS=$(echo $line | awk -F\; '{print $1}')
  export GITUSER=$(echo $line | awk -F\; '{print $2}')
  # echo "$line - ALIAS: $ALIAS - GIT: $GITUSER"
  export ORIG=$(ls | grep $GITUSER)
  if [ ! -z ${ORIG} ]; then 
    if [ ! -z "$1" ]; then
      echo "----> mv $ORIG $ALIAS"; 
    else
      mv $ORIG $ALIAS
    fi
  fi 
done

echo $1
}

process "DRY-RUN"

echo
echo "--- EXECUTE in 5 seconds ---"
sleep 5

process

