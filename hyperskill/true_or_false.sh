#!/usr/bin/bash

#  write your code here

echo "Welcome to the True or False Game!"

curl --silent --output ID_card.txt --cookie-jar cookie.txt --user "the_username:the_password" http://127.0.0.1:8000/download/file.txt
message_from_endpoint=$(cat ID_card.txt)
echo "Login message: $message_from_endpoint"
