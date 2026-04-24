#!/bin/bash

BASEDIR=/opt/tunigit/gh/stec26
export ROSTER=$BASEDIR/roster.csv

export PRE=1-server-cmdb
export POST=1

$BASEDIR/class-rename.sh
