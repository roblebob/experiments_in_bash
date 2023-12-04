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
    login
    echo "What is your name?"
    read -r name
    correct_answers=0
    while true; do

        question_and_answer=$(curl --silent --cookie cookie.txt --user "${username}:${password}" http://127.0.0.1:8000/game)
        question=$(echo "$question_and_answer" | sed 's/.*"question": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
        answer=$(echo "$question_and_answer" | sed 's/.*"answer": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')

        echo "$question"
        echo "True or False?"
        read -r user_answer

        if [[ "${user_answer,,}" != "${answer,,}" ]]; then
            echo "Wrong answer, sorry!"
            echo "${name} you have ${correct_answers} correct answer(s)."
            score=$((correct_answers * 10))
            echo "Your score is ${score} points."
            echo -e "User: ${name}, Score: ${score}, Date: $(date +'%Y-%m-%d')" >> scores.txt
            break
        fi

        idx=$((RANDOM % ${#WIN_RESPONSES[@]}))
        echo "${responses[$idx]}"
        correct_answers=$((correct_answers + 1))
    done
}



display_scores() {
    if ! [[ -f scores.txt ]]; then
        echo "File not found or no scores in it!"
        return
    fi
    echo "Player scores"
    cat scores.txt
}

reset_scores() {
    if ! [[ -f scores.txt ]]; then
        echo "File not found or no scores in it!"
        return
    fi
    rm scores.txt
    echo "File deleted successfully!"
}


echo "Welcome to the True or False Game!" 

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
            display_scores
            ;;
        3 )
            echo "Resetting scores"
            ;;
        * )
            echo "Invalid option!"
            ;;
    esac
done
