# Stecreon - Server Technologies assessment with centreon 


# Command line samples for home page checks

Pre-requisites:
* Host exists: "Homepages-tuni"

The service will be connected to a host.

## Add new service: web page responds (multiple steps)

1) Add service

```centreon -u admin -p somePass3342 -o SERVICE -a add -v 'Homepages-Tuni;niko-TUNI-home-basic;TUNI-home-basic'  ```

2) Set the check command to the service

```centreon -u admin -p somePass3342 -o SERVICE -a setparam -v 'Homepages-Tuni;niko-TUNI-home-basic;check_command;tunihome_basic'  ```

3) Add parameters to the service

```centreon -u admin -p somePass3342 -o SERVICE -a setparam -v 'Homepages-Tuni;niko-TUNI-home-basic;check_command_arguments;!/niko.user/' ```

## Load new configuration

```sudo centreon -u admin -p 'somePass3342' -a APPLYCFG -v 1   ```


# Python code for running configurations

## Simple

In the command line:

./stecreon.py -C <command> -P "<parameters as JSON - key value pairs>"

Here the <command> is command templated stored to a file in /etc/stecreon.

For example:

```
cat /etc/steon/web.cmd

centreon -u admin -p 'somePass3342' -o SERVICE -a add -v 'PRM-SVC;niko-TUNI-home-basic;TUNI-home-basic' 
```

The command in the command line will provide the parameters neeeded (only one here):

```./stecreon.py -c web.cmd -p {"PTR-SVC": "Homepages-Niko-basic"}```

## Advanced

Here a command can consist of sub commands.

### Data model

* Command set
  * Contains list of actual commands

Contents of the command file will include list of sub commands:

JSON: {subcmd: [<sub1>, <sub2>]}}

Name of the file could be "xxx.cmdset". And the actual command is in "xxx.cmd".

