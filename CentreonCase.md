# Centreon Case for Steon

How to automate monitoring Web pages in Tuni homepage server

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


# Python code for running configurations - Req Specs

## Simple

In the command line:

./main.py -C <command> -p "<parameters as JSON - key value pairs>"

Here the <command> is command templated stored to a file in /etc/steon

For example:

```
cat /etc/steon/web.cmd

centreon -u admin -p 'somePass3342' -o SERVICE -a add -v 'PRM-SVC;niko-TUNI-home-basic;TUNI-home-basic' 
```

The command in the command line will provide the parameters neeeded (only one here):

```./stecreon.py -c web.cmd -p {"PTR-SVC": "Homepages-Niko-basic"}```

