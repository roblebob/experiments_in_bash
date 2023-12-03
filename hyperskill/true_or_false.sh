#!/usr/bin/bash

#  write your code here

echo "Welcome to the True or False Game!"

while true; do
    echo
    echo "0. Exit"
    echo "1. Play a game"
    echo "2. Display scores"
    echo "3. Reset scores"
    echo "Enter an option:"
    read -r option

    case "$option" in
        0 )
            echo "See you later!"
            exit
            ;;
        1 )
            echo "Playing game"
            ;;
        2 )
            echo "Displaying scores"
            ;;
        3 )
            echo "Resetting scores"
            ;;
        * )
            echo "Invalid option!"
            ;;
    esac





curl --silent --output ID_card.txt --cookie-jar cookie.txt --user "the_username:the_password" http://127.0.0.1:8000/download/file.txt
message_from_endpoint=$(cat ID_card.txt)
echo "Login message: $message_from_endpoint"


curl --silent --output question_answer.txt --cookie cookie.txt --user "the_username:the_password" http://127.0.0.1:8000/game
question_and_answer_from_endpoint=$(cat question_answer.txt)
echo "Response: $question_and_answer_from_endpoint"
