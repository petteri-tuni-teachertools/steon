# Introduction

Commands to add monitoring targets to Centreon in STEC22 course.

## Commands

````
./main.py -C config-hosts.yml -f data-local/stec-30.3.csv -c host-add 
./main.py -C config-ssh-sam.yml -f data-local/stec-30.3.csv -c svc-add-stec-ssh
````


## Configuration files
Configuration files (in current directory):
- config-hosts.yml (sets the directory for commands)

Command templates:
case-stec/host-add.cmd ^C
case-stec/svc-add-stec-ssh.cmd^C

Data:
data-local/stec-30.3.csv


