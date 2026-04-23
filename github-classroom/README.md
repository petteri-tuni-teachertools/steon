
echo "To rename the github repos with Tuni aliases, following can be used:"

export ROSTER=~/dev/stec26/student/roster.csv
export PRE=1-server-cmdb
export POST=1

echo To try out ------------------------
for dir in `ls`; do export VAR1=`echo $dir | sed -e "s/$PRE-//g"`; VAR2=`grep $VAR1 $ROSTER | awk -F\; '{print $1}'`; echo mv $PRE-$VAR1 $POST-$VAR2;  done
echo
echo After 5 seconds, execute ...
sleep 5
echo

for dir in `ls`; do export VAR1=`echo $dir | sed -e "s/$PRE-//g"`; VAR2=`grep $VAR1 $ROSTER | awk -F\; '{print $1}'`; mv $PRE-$VAR1 $POST-$VAR2;  done



# Installation of GitHub Classroom to the server -----------------------

This is the command and it seems there might be hickups with connection, just try again:

````
$ gh extension install github/gh-classroom

could not check for binary extension: Get "https://api.github.com/repos/github/gh-classroom/releases/latest": dial tcp 140.82.121.6:443: connect: connection refused

petteri@records26:/opt/tunigit/gh/stec26/round4$ gh extension install github/gh-classroom
✓ Installed extension github/gh-classroom

````

Then start using:

````
petteri@records26:/opt/tunigit/gh/stec26/round4$ gh classroom help
A GitHub Classroom CLI

Usage:
  classroom [command]

Available Commands:
  accepted-assignments List your student's accepted assignments
  assignment           Show the details of an assignment
  assignment-grades    Download a CSV of grades for an assignment in a classroom
  assignments          Display a list of assignments for a classroom
  clone                Clone starter code or a student's submissions
  completion           Generate the autocompletion script for the specified shell
  help                 Help about any command
  list                 List classrooms
  pull                 Pull starter code or a student's submissions
  view                 Show the details of a classroom

Flags:
  -h, --help   help for classroom

Use "classroom [command] --help" for more information about a command.
````

List classrooms:


````
$ gh classroom list

3 Classrooms

ID      Name                        URL
276538  TAMK Software Design 2025   https://classroom.github.com/classrooms/226319889-tamk-software-design-2025
283696  SW Architectures 2025       https://classroom.github.com/classrooms/231058918-sw-architectures-2025
315810  Server Tech 2026 classroom  https://classroom.github.com/classrooms/268727441-server-tech-2026-classroom
````

List assignments for a classroom

````
$ gh classroom assignments -c 315810
3 Assignments for Server Tech 2026 classroom

ID      Title                   Submission Public  Type        Deadline              Editor  Invitation Link                          Accepted  Submissions  Passing
964749  1. Server CMDB          false              individual  2026-04-01T16:56:00Z          https://classroom.github.com/a/nQkWWEBW  63        63           0
968997  2.Web content           false              individual  2026-05-10T07:11:00Z          https://classroom.github.com/a/ldaFZUeI  39        27           0
970505  3. System scripts (v2)  false              individual  2026-05-10T06:29:00Z          https://classroom.github.com/a/e_sdM0AB  38        25           0
````


