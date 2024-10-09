#!/bin/bash

read -p "Enter your password: " entered_password

entered_password_hash=$(echo -n $entered_password | md5sum | cut -d " " -f 1)

cat passwords | cut -d " " -f 1 | grep -w $USER > /dev/null

if [ $? -eq 1 ]
then
echo "ERROR: User account not found"
exit 1 
fi


password_hash=$(cat passwords | grep $USER | cut -d ' ' -f 2)

if [ $entered_password_hash == $password_hash ]
then
echo "Login successful"
else
echo  "Incorrect password"
fi
