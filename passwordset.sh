#!/bin/bash

read -p "Enter your password: " password_1
read -p "Confirm your password: " password_2

if [ $password_1 != $password_2 ]
then
echo "Passwords do no match"
exit 1
fi


hash=$(echo -n $password_1 | md5sum | cut -d " " -f 1)
echo "$USER $hash" > passwords
