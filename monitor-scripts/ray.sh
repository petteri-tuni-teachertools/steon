#!/bin/bash

# Collect information ... 

TARGET=4

# 1) No test, initialize saldo
SALDO=1
RESULT="# RESULT: $SALDO"

# 2) Check for automatic reboot for security updates ----------
grep -q 'Unattended-Upgrade::Automatic-Reboot' /etc/apt/apt.conf.d/50unattended-upgrades
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# 3) Check for automatic reboot for security updates ----------
grep '^Unattended-Upgrade::Automatic-Reboot' /etc/apt/apt.conf.d/50unattended-upgrades | grep -q true
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# 4) Check for login with password
grep -i '^PasswordAuthentication' /etc/ssh/sshd_config | grep -q no
if [ $? -eq 0 ]; then SALDO=$(($SALDO+1)); fi
RESULT="$RESULT - $SALDO"

# Final conclusion
RESULT="$RESULT #"

if [ $SALDO -eq $TARGET ]; then
  echo "SUCCESS($RESULT)"
  exit 0
else
  echo "FAILED($RESULT)"
  exit $SALDO
fi

