#!/usr/bin/bash

#  write your code here

WIN_RESPONSES=("Perfect!" "Awesome!" "You are a genius!" "Wow!" "Wonderful!")

login() {
    curl --silent --output ID_card.txt http://127.0.0.1:8000/download/file.txt
    username=$(cat ID_card.txt | sed 's/.*"username": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
    password=$(cat ID_card.txt | sed 's/.*"password": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')

    login_message=$(curl --silent --cookie-jar cookie.txt --user "${username}:${password}" http://127.0.0.1:8000/login)
}

show_menue() {
    echo
    echo "0. Exit"
    echo "1. Play a game"
    echo "2. Display scores"
    echo "3. Reset scores"
    echo "Enter an option:"
    read -r option
}
 
RANDOM(){
    echo 4096
}

playing_game() {
    echo "What is your name?"
    read -r name
    score=0
    while true; do

        question_and_answer=$(curl --silent --cookie cookie.txt --user "${username}:${password}" http://127.0.0.1:8000/game)
        question=$(echo "$question_and_answer" | sed 's/.*"question": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
        answer=$(echo "$question_and_answer" | sed 's/.*"answer": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')

        echo "$question"
        echo "True or False?"
        read -r user_answer

        if [[ "$user_answer" != "$answer" ]]; then
            echo "Wrong answer, sorry!"
            echo "${name} you have ${score} correct answer(s)."
            echo "Your score is $(($score * 10)) points."
            break
        fi

        idx=$((RANDOM % ${#WIN_RESPONSES[@]}))
        echo "${responses[$idx]}"
        score=$((score + 1))
    done
}


echo "Welcome to the True or False Game!" 
login
while true; do

    show_menue

    case "$option" in
        0 )
            echo "See you later!"
            exit
            ;;
        1 )
            playing_game
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
done
