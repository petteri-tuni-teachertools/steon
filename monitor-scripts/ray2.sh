#!/bin/bash

# Collect information ...

TARGET=6

# No test, initialize saldo
SALDO=1
RESULT="RESULT: $SALDO"

# PM2 service configured and running----------

ps -ef | grep pm2 | grep -q -v grep
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# totd Node.js service responds ---------------

curl -f -s localhost:3000/totd/$RANDOM >> /dev/null
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# Reverse Proxy configured for the Node.js app in port 3000

grep -i reverse /etc/apache2/sites-enabled/* | grep -q 3000

if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# ufw is enabled

timeout 1 sudo ufw status > /dev/null
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# sam22 has sudo permissions for ufw but no other root commands

export SUDO_ASKPASS=/usr/bin/echo
sudo -A true 2>&1 > /dev/null
if [ $? -ne 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

if [ $SALDO -eq $TARGET ]; then
     echo "SUCCESS($RESULT)"
     exit 0
  else
     echo "FAILED($RESULT)"
     exit 1
fi

