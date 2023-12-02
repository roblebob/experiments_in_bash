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


list_files_and_dirs() {
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
}


file_and_dir_operations() {
    while true; do

        list_files_and_dirs

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
                name="$file_and_dir_operations_menue"
                if [[ -f "$name" ]]; then
                    
                    while true; do
                        echo
                        echo "---------------------------------------------------------------------"
                        echo "| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |"
                        echo "---------------------------------------------------------------------"
                        read -r file_and_dir_operations_menue_file

                        case "$file_and_dir_operations_menue_file" in
                            "0" )
                                break
                                ;;
                            "1" )
                                rm "$name"
                                echo "${name} has been deleted."
                                break
                                ;;
                            "2" )
                                echo "Enter the new file name:"
                                read -r new_name
                                mv "$name" "$new_name"
                                echo "${name} has been renamed as ${new_name}."
                                break
                                ;;
                            "3" )
                                chmod a+rw "$name"
                                echo "Permissions have been updated."
                                ls -l "$name"
                                break
                                ;;
                            "4" )
                                chmod a+rw "$name"
                                chmod o-w "$name"
                                echo "Permissions have been updated."
                                ls -l "$name"
                                break
                                ;;
                            * )
                                continue
                                ;;
                        esac
                    done
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



find_executables() {
    echo
    echo "Enter an executable name:"
    read -r executable_name
    message=$(which "$executable_name")
    if [[ -z "$message" ]]; then
        echo "The executable with that name does not exist!"
        return
    fi
    echo "Located in: $message"
    
    echo "Enter arguments:"
    read -r arguments
    $executable_name $arguments
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
            find_executables
            ;;
        * )
            echo "Invalid option!"
            ;;
    esac

done
