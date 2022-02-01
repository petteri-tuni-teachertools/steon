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
class CliCommand:
    def __init__(self, cmd, params) -> None: # Find out what is this notation    
         self.cmd = cmd
         self.params = params
         
    def parseParams(self, cmd):
        jsondata = json.loads(self.params)
        #print (jsondata)
        
        for key in jsondata:               
            prm1 = key
            val1 = jsondata[key]
            my_regex = r"PRM-" + re.escape(prm1)    
            cmd = re.sub(my_regex, val1, cmd)
            #print ("Command TMP: " + cmd)

        return cmd


    def buildCmd(self):
        cmd_file = config_dir + '/' + self.cmd + '.cmd'
        file = open(cmd_file, "r")
        self.cmdTemplate = file.read()                
        cmd = self.cmdTemplate

        if (self.params):
            cmd = self.parseParams(cmd)

        self.theCmd = cmd
    
    def getCmd(self):
        return self.theCmd

    def runCmd(self):
        os.system(self.theCmd)


# ------------------------------------------------

print ("Hello server tech")

cmdObj = CliCommand(cmd, params)
cmdObj.buildCmd()
print ("Resulting command: " + cmdObj.getCmd())
if (not test):
    print ("Run command ...")
    cmdObj.runCmd()
else:
    print("TEST mode")    





