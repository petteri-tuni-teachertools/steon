 #!/bin/bash

# Collect information ...

TARGET=4

# No test, initialize saldo
SALDO=1
RESULT="RESULT: $SALDO"

# Docker service configured and running----------

ps -ef | grep docker | grep -q -v grep
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# Postgres listening in port 5432 ----------

netstat -anp 2>&1  | grep 5432 | grep -q "LISTEN "
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# DB-based totd running ---------------

curl -f -s localhost:3432/plain/$RANDOM >> /dev/null
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

if [ $SALDO -eq $TARGET ]; then
     echo "SUCCESS($RESULT)"
     exit 0
  else
     echo "FAILED($RESULT)"
     exit 1
fi

