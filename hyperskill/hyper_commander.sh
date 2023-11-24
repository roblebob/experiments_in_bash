#!/usr/bin/bash

echo "Hello $USER!"

show_menue() {
    echo
    echo "------------------------------"
    echo "| Hyper Commander            |"
    echo "| 0: Exit                    |"
    echo "| 1: OS info                 |"
    echo "| 2: User info               |"
    echo "| 3: File and Dir operations |"
    echo "| 4: Find Executables        |"
    echo "------------------------------"
    read -r menue 
}



while true; do

    show_menue

    case "$menue" in
        "0" )
            echo "Farewell!"
            exit
            ;;
        "1" | "2" | "3" | "4" )
            echo "Not implemented!"
            continue
            ;;
        * )
            echo "Invalid option!"
            continue
            ;;
    esac

done
