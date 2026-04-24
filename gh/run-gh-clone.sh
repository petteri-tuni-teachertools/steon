#!/usr/bin/bash
#
BIN_DIR=/opt/tunigit/gh
DATA_DIR=/opt/tunigit/gh/stec26
GH_TASK=1-server-cmdb-submissions

LABEL=$(date "+%Y-%m-%d-%H-%M")
# For test without cloning, fix: LABEL=2026-04-24-18-48
ROUND_SUBDIR=round-$LABEL

echo "----------------------------------------"
echo "Running GH classroom clone for CMDB task"
echo
date
echo "Data dir: $DATA_DIR"
echo "----------------------------------------"

cd $DATA_DIR

mkdir $ROUND_SUBDIR
cd $ROUND_SUBDIR

# For test without cloning, comment out:
/usr/bin/bash $BIN_DIR/tamk-gh-1.sh

if [ $? -eq 0 ]; then
  cd $GH_TASK
  /usr/bin/bash $BIN_DIR/rename-roster.sh
  cd ../..
  mv latest-round archive/latest-$LABEL
  ln -s $ROUND_SUBDIR latest-round
else 
  echo "ERROR ... something went wrong"
fi

