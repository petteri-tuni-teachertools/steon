


# Introduction

This folder includes script to clone student repositories from GitHub Classroom
And to rename the repository folders to match the real student names in TAMK.
This mapping is based on the roster in GitHub classroom. Students must pick their own TAMK email alias for their tasks. The GitHub account can be anything.

The idea is that there is separately the directory for
* scripts -  now hardcoded many details from classroom assignment
* data - for example the roster.csv -file. And results will be produced here

## Example of crontab

````
30 6,11,14,18,21 * * * /usr/bin/bash /opt/tunigit/gh/run-gh-clone.sh >> /var/log/gh/stec26-gh.log 2>&1
````
