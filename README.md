# Steon - configuration automation tool

Steon tool facilitates automation of monitoring tools configurations.

# Features

* Capability to run command templates where parameters expressed as placeholders with "PRM-" prefix.
* Command templates can be oneliners or full multiline scripts
* Parameters that will replace the placeholders can be given 
  * From the cli as JSON string. In this case only one parameter set supported at the moment.
  * Using parameter file. In this case format is CSV and multiple lines corresponding multiple parameter sets is supported
* The program will run the template command where parameter placeholders are replaced with real parameter values. If CSV file used, command will be run as many times as there are lines in the CSV file.
* The resulting command can be printed out - either as it is or a version where admin password is obfuscated.
* In test mode only resulting command printed out; no execution.

# Primary configuration file: config.yml

The primary configuration file config.yml is loaded from the working directory of the command.

Content example:

```
configdir: templates-local
ADMINUSER: admin
ADMINPW: somepassword
GENERIC-HOST: generic-active-host
POLLER: central
HOSTGROUP: Eduhou
```

Special keys are:
* configdir - this is where command templates reside
* ADMINPW - the value of this can be obfuscated when printing out command

Other keys are just regular parameter values. Storing them here simplifies provision of values to widely used "static" parameters. If same parameter is found in the actual parameter data, this overrides the configuration file value.

# Command templates

Given with -c cli parameter (without .cmd suffix).

These are searched from <configdir> (can be set in config.yml). Default directory if not set in config.yml is **/etc/steon**

Example:

```
# This is example command template.
# -> To run: ./main.py -c ls-sort -f examples/params/ls-sort-data.csv 
# -> Data/params example in examples/data/ls-sort.csv
#
echo '--------------------------------------------------'
echo 'List PRM-NUM most recent files in <<PRM-FILEPATH>>'
echo '--------------------------------------------------'
ls -latr PRM-FILEPATH | tail -PRM-NUM
```

PRM-NUM and PRM-FILEPATH are placeholders that will be replaced.

# Parameters to replace placeholders in the command template

## From cli

Use -p cli parameter with paramers set JSON string. Example:

```./main.py -c ls-sort -p {"FILEPATH": "/etc", "NUM":"7"}```

Note: the PRM- prefix is omitted in the cli JSON parameter set string.

## From file

Use -f cli parameter with the file path. Example:

```./main.py -c ls-sort -f examples/params/ls-sort-data.csv```

Content of parameters file /examples/params/ls-sort-data.csv:
```
FILEPATH,NUM
/etc,5
/var/log,7
```

# Command line parameters

* -c command (without ".cmd" filename suffix)
* -p parameter keys and values as a JSON string
* -f parameter values CSV file path; header row contains parameter keys
* -T val - test mode, val = 1 or 99
* -v val - verbose, val = 1 or 99

Explanation for values 1 and 99:
* 1 - print out resulting command with adminpw obfuscated (*****)
* 99 - print out final resulting command without obfuscation

# Environment installation

## Python and libraries

```
yum install python3
yum install python3-simplejson
yum install python3-pyyaml
```

