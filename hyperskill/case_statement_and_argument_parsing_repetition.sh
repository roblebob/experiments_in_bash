#!/usr/bin/env bash

function skipper() {
    # put your code here
    while true; do
        case "${1}" in

            "0" ) 
                exit
                ;;
            "1" | "2" | "3" )
                echo "${1}"
                shift "${1}"
                ;;
            * )
                echo "Invalid option!"
                exit
                ;;
        esac
    done
}



