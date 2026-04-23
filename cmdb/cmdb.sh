#!/bin/bash

# Collect information ...
#
CMDBROOT=$1
BASEDIR=$CMDBROOT/servers/server01
DOCBASE=$CMDBROOT/docs

TARGET=10

# 1) No test, initialize saldo
SALDO=1
RESULT="RESULT: $SALDO"

# 2) Check for automatic reboot for security updates ----------
grep '^Unattended-Upgrade::Automatic-Reboot' $BASEDIR/etc/apt/apt.conf.d/50unattended-upgrades | grep -q true
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# 3) Check for login with password
grep -i '^PasswordAuthentication' $BASEDIR/etc/ssh/sshd_config.d/* | grep -q no
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# 4) Check for root ssh
grep -i '^PermitRootLogin' $BASEDIR/etc/ssh/sshd_config.d/* | grep -q no
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# 5) Check for default user "ubuntu"
if [ -e $BASEDIR/etc/passwd ]; 
then 
grep -q ubuntu $BASEDIR/etc/passwd
if [ $? -ne 0 ]; then SALDO=$(($SALDO+1)); fi
fi
RESULT="$RESULT - $SALDO"

# 6) Check for sam22 user
grep -q sam22 $BASEDIR/etc/passwd
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# 7) Check for pm2 service file
find $BASEDIR/etc/systemd/system -type f -name "*.service" | xargs egrep pm2 | grep -q ExecStart
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# 8) Apache - hide git
find $BASEDIR/etc/apache2 -type f -name "*.conf" | xargs egrep "^Redirect" | grep 40 | grep -q git
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# 9) Apache - hide server info
find $BASEDIR/etc/apache2 -type f -name "*.conf" | xargs egrep "^ServerTokens" | grep -q Prod
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# 10) Package listing updated
find $DOCBASE -type f | xargs grep -iq docker
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

if [ $SALDO -eq $TARGET ]; then
  echo "$SALDO/$TARGET # ($RESULT) # ---PERFECT--- #"
  exit 0
else
  echo "$SALDO/$TARGET # ($RESULT) # #"
  exit 1
fi
