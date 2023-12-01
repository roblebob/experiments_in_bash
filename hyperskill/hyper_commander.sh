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


file_and_dir_operations() {
    while true; do
        echo
        echo "The list of files and directories:"

        arr=(*)
        for item in "${arr[@]}"; do
            if [[ -f "$item" ]]; then
                echo "F $item"
            elif [[ -d "$item" ]]; then
                echo "D $item"
            fi 
        done

        echo
        echo "---------------------------------------------------"
        echo "| 0 Main menu | 'up' To parent | 'name' To select |"
        echo "---------------------------------------------------"
        read -r file_and_dir_operations_menue

        case "$file_and_dir_operations_menue" in
            "0" )
                break
                ;;
            "up" )
                cd ..
                ;;
            * )
                if [[ -f "$file_and_dir_operations_menue" ]]; then
                    echo "Not implemented!"
                    continue

                elif [[ -d "$file_and_dir_operations_menue" ]]; then
                    cd "$file_and_dir_operations_menue"
                    continue
                
                else
                    echo "Invalid input!"

                fi
                ;;
        esac
    done
    
}



while true; do

    show_menue

    case "$menue" in
        "0" )
            echo "Farewell!"
            exit
            ;;
        "1" )
            echo
            uname -no
            ;;
        "2" )
            echo  
            whoami
            ;;
        "3" )
            file_and_dir_operations
            ;;
        "4" )
            echo "Not implemented!"
            continue
            ;;
        * )
            echo "Invalid option!"
            continue
            ;;
    esac

done
