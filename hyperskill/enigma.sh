#!/usr/bin/bash

# write your code here
echo "Enter a message:"
read -r input
re="^[A-Z ]+$"
if [[ $input =~ $re ]]; then
    echo "This is a valid message!"
else
    echo "This is not a valid message!"
fi
