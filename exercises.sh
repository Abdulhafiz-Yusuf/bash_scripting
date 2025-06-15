#!/bin/bash
#######################################################################
# 
echo -e "\n\n\n🧱 PHASE 1:BASH BASICS (Beginner)"
#🧱 PHASE 1:BASH BASICS (Beginner)
#
#######################################################################

#
echo -e "\nExercise 1"
# Exercise 1: Write a script that checks if a directory exists, if not, create it.
#
#
file=test.txt
if [ -f $file ]; then
    echo 'File exist'
else echo 'Creating File' 
    touch $file
    echo 'File Create'
    echo "File name is $file"
fi

echo -e "\nExercise 2"
# Exercise 2: Write a script that takes a filename and counts the number of lines in it.
#
#
if [ -f $file ]; then
    echo "File already created in exercise 1" 
    line=$(wc -l < $file)
    echo "File $file contain $line number of lines"
else echo "File does not exist"
fi


#Create a function say_job that prints your job role when passed as argument.

jobRole() {
    echo "My job role is $1 InShaAllah"
}

jobRole "DevOps Engineer"


fruits=('Hello' 'I am from' 'content')
echo "Your 1st argument is: $1"

for fruit in "${fruits[@]}"; do
    echo $fruit
done


#######################################################################
echo -e "\n\n\n🧱 PHASE 2: INTERMEDIATE SKILLS"
#🧱 PHASE 2: INTERMEDIATE SKILLS
#
#######################################################################

echo -e "\nExercise 1"
## Exercise 1: Rename .txt to .bak in a folder
#
#Solution
#
for file in *.bak; do
    mv "${file}" "${file%.bak}.txt"
done


 echo -e "\nExercise 2"
### Exercise 2: Ping a list of IPs
#
#Solution
# 1. ceate the list of IPs text file (ips.txt).
# 2. Use while loop to loop through all lines Ips text file by passing ips.txt to while loop
# 3. Check for non-empty line for pinging.
# 4. Check for empty line of skipping using continue command
# 5. Print out Successful response for successful pinging and unsuccessful for unsuccessful pingin.
# 6. Ensure the program for the pinging process to complete.
#
#
#
while read ip; do
    [ -z "$ip" ] && continue ||
    ( ping -c 1 -W 1 "$ip" &> /dev/null && echo "$ip is reachable" || echo "$ip is not reachable") &
done < ips.txt
wait




#######################################################################
echo -e "\n\n⚙  PHASE 3: ADVANCED USAGE"
# ⚙️  PHASE 3: ADVANCED USAGE
#
#######################################################################




#######################################################################
#
echo -e "\n\n⚙  PHASE 4: MASTER LEVEL – BASH FOR DEVOPS"
#⚙️ PHASE 4: MASTER LEVEL – BASH FOR DEVOPS
#
#######################################################################
