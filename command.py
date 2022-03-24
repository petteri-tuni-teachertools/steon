import re
import os
import yaml
import csv
import simplejson as json

config_dir = '/etc/steon'

class CliCommand:
    def __init__(self, cmdFile, mainconfig="config.yml") -> None: # Find out what is this notation    
         self.cmdFile = cmdFile # Command template (can be multiple lines)
         self.theCmd = ''       # The final command with real data will be here
         self.printCmd = ''     # The final printable command with real data will be here (passwd hidden)     
         self.config_dir = config_dir   # Configuration directory default - might be overriden from config file
         self.paramsList = []           # This contains all parameter sets as list. Each set will be run "against" the template cmd/script.
        
         with open(mainconfig, 'r') as file:
            self.config = yaml.safe_load(file)
            for key in self.config:                
                if key == 'configdir':
                    self.config_dir = self.config[key]

         full_cmd_file = self.config_dir + '/' + self.cmdFile + '.cmd'
         file = open(full_cmd_file, "r")
         self.cmdTemplate = file.read()                    

    def setParamsString(self, params_string):  # Parameters from CLI as JSON         
        tmp = json.loads(params_string)
        self.paramsList.append(tmp)        # Append the string to the list of params set, usually first and last in the list.
         
    def readParamsFile(self, params_file):
        self.paramsFile = params_file        

        tmplist = []
        with open(params_file, newline='') as csvfile:
            self.data = csv.DictReader(csvfile)  
            cnt = 0
            for row in self.data:
                tmplist.append(row)
                cnt += 1                
        self.paramsList = tmplist        
    
    def parseConfig(self):        
        for key in self.config:
            prm1 = key
            val1 = self.config[key]
            my_regex = r"PRM-" + re.escape(prm1)            
            if (prm1 == 'ADMINPW'):
                self.theCmd = re.sub(my_regex, val1, self.theCmd)
                self.printCmd = re.sub(my_regex, '*******', self.printCmd)
            else:
                self.theCmd = re.sub(my_regex, val1, self.theCmd)
                self.printCmd = re.sub(my_regex, val1, self.printCmd)       
                #print ("Command TMP: " + cmd)

    def parseParams(self, params_data):               
        jsondata = params_data
        for key in jsondata:               
            prm1 = key
            val1 = jsondata[key]
            my_regex = r"PRM-" + re.escape(prm1)
            self.theCmd = re.sub(my_regex, val1, self.theCmd)
            self.printCmd = re.sub(my_regex, val1, self.printCmd)            
            #print ("Command TMP: " + cmd)        

    def buildCmd(self, params_set):
        self.theCmd = self.cmdTemplate
        self.printCmd = self.cmdTemplate

        if params_set:
            self.parseParams(params_set)
        if self.config:
            self.parseConfig()   
    
    def getCmd(self):
        return self.theCmd

    def getPrintCmd(self):
        return self.printCmd  

    def getParamsList(self):
        return self.paramsList

    def runCmd(self):
        os.system(self.theCmd)
