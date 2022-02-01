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


# Python code for running configurations - Req Specs

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




# Version history

## 27.1.2022

Supports
* simple single command template (no nested/list of commands)
* multiple parameters

### Example

Configuration

```
$ cat /etc/steon/ls-sort.cmd 
ls -latr PRM-FILEPATH | tail -PRM-NUM
```

Execution:

```
./main.py -c ls-sort -p '{"FILEPATH":"~", "NUM":"2"}'

Resulting command: ls -latr ~ | tail -2

-rw-------  1 pj   pj     32503 tammi  26 20:27 .viminfo
drwxr-xr-x 55 pj   pj      4096 tammi  26 20:27 .
```

## Further development

* Set of commands in the configuration. Command set can be given as parameter. Will be expanded to batch of several commands a per the configuration.
* List of params support. Now: "{"PRM1": "val1", "PRM2":"val2"}. Then:  "[{"PRM1": "val1", "PRM2":"val2"},{"PRM1": "val1b", "PRM2":"val2b"}]". This will run the command (or batch of commands) multiple times for each parameter set in the list.
* Addressing explicit files in the cmd line. Now the command template has to be in the config directory. And the params data has to be given in the cmd line. Both could be in arbitrary files.


