#!/usr/bin/python3

import argparse
import sys
import re
import os
from distutils.util import grok_environment_error
import simplejson as json

# ------------------------------------------------

description = """
    A General tool to run command line commands.
    Commands are stored as templates to which parameters given in JSON format are filled in.    
    """
parser = argparse.ArgumentParser(description=description)
parser.add_argument("-c", "--command", default="default",  help="Define the file that contains the command template")
parser.add_argument("-f", "--file", default=None, help="file to read the command from. Configuration directory searched otherwise")
parser.add_argument("-C", "--config", default='/etc/steon/steon.conf', help="file to read the Centreon configuratin from")
parser.add_argument("-v", "--verbose", default=0, help="verbosity level - 0(default) or 1")
parser.add_argument("-T", "--test", default=0, help="Test only (default) or 1")
parser.add_argument("-p", "--params", default="", help="Parameters in JSON format: key value pairs {'key':'value','key2':'value2'}")

args = parser.parse_args()

cmd = args.command
test = args.test
params = args.params

# ------------------------------------------------

config_dir = '/etc/steon'

# ------------------------------------------------

print ("Hello server tech")

cmd_file = config_dir + '/' + args.command + '.cmd'

file = open(cmd_file, "r")
cmdTemplate = file.read()

print ("Command: ", cmdTemplate)

jsondata = json.loads(params)
#print (jsondata)
for key in jsondata:    
    prm1 = key
    val1 = jsondata[key]
    print (prm1)
    print (val1)
    

my_regex = r"PRM-" + re.escape(prm1)
theCmd = re.sub(my_regex, val1, cmdTemplate)
print ("The command:" + theCmd)

os.system(theCmd)


