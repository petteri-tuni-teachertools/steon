#!/usr/bin/python3

import argparse

from command import CliCommand
# ------------------------------------------------

description = """
    A General tool to run command line commands.
    Commands are stored as templates to which parameters given in JSON format are filled in.    
    """
parser = argparse.ArgumentParser(description=description)
parser.add_argument("-c", "--command", default="default",  help="Define the file that contains the command template")
parser.add_argument("-f", "--file", default=None, help="file to read the parameters from. Command line parameter -p second alternative")
parser.add_argument("-C", "--config", default='config.yml', help="file to read the common configuratin from")
parser.add_argument("-S", "--sec", default='.secret.yml', help="file to read the secret configuratin from")
parser.add_argument("-v", "--verbose", default=0, help="verbosity level - 0(default) or 1 or 99 (show all)")
parser.add_argument("-T", "--test", default=0, help="Test only (default) or 1")
parser.add_argument("-p", "--params", default="", help="Parameters in JSON format: key value pairs {'key':'value','key2':'value2'}")

args = parser.parse_args()

cmd = args.command
test = args.test
params_json = args.params
params_file = args.file
verbose = args.verbose
mainconfig = args.config
sec_config = args.sec

if (int(test) >= 1):
    verbose = int(test)
        
# ------------------------------------------------

cmdObj = CliCommand(cmd, mainconfig, sec_config)

if (test):
    print("\n<<< TEST mode >>>\n")

if (params_file):
    cmdObj.readParamsFile(params_file)

elif (params_json):
    cmdObj.setParamsString(params_json)    

cnt = 0
for row in cmdObj.getParamsList():
    cnt += 1
    cmdObj.buildCmd(row)
    if (verbose == 99):
        # This will print out the parsed command as it is - also ADMINPW if used in the template
        print (str(cnt) + ") Resulting command ----------------\n" + cmdObj.getCmd())        
    elif (verbose):        
        print (str(cnt) + ") Resulting command ----------------\n" + cmdObj.getPrintCmd())        

    if (not test):        
        cmdObj.runCmd()
        print()
