
echo "With these commands clone tasks for the course:"

#export GH_TOKEN=ghp_u5i1qWRIQN4

echo "List all classrooms"
echo
gh classroom list
echo "List assignments for a classroom"
echo
gh classroom assignments -c 315810

echo "Clone projects for an assignment"
echo

exit

gh classroom clone student-repos -a 964749
