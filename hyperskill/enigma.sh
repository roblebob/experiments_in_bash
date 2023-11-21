#!/usr/bin/bash

re_filename="^[a-zA-Z\.]+$"
re_message="^[A-Z ]+$"

ord() {
  echo $(printf "%d\n" "'$1") 
}

chr() {
  echo $(printf "%b\n" "$(printf "\\%03o" "$1")")
}

echo "Welcome to the Enigma!"

show_menue() { 
    echo "0. Exit"
    echo "1. Create a file"
    echo "2. Read a file"
    echo "3. Encrypt a file"
    echo "4. Decrypt a file"
    echo "Enter an option:"
    read -r menue 
}


create_file() {
    echo "Enter the filename:"
    read -r filename
    if ! [[ ${filename} =~ ${re_filename} ]]; then
        echo "File name can contain letters and dots only!"
        return
    fi

    echo "Enter a message:"
    read -r message
    if ! [[ ${message} =~ ${re_message} ]]; then
        echo "This is not a valid message!"
        return
    fi

    echo "${message}" > "${filename}"
    echo "The file was created successfully!"
}


read_file() {
    echo "Enter the filename:"
    read -r filename
 
    if [[ ! -f "${filename}" ]]; then
        echo "File not found!"
        return
    fi

    echo "File content:"
    cat "${filename}"
}



while true; do

    show_menue

    case "$menue" in
        "0" )
            echo "See you later!"
            exit
            ;;
        "1" )
            create_file
            continue
            ;;
        "2" )
            read_file
            continue
            ;;
        "3" | "4" )
            echo "Not implemented!"
            continue
            ;;
        * )
            echo "Invalid option!"
            continue
            ;;
    esac

done


 





# SHIFT=3
#
# echo "Type 'e' to encrypt, 'd' to decrypt a message:"
# echo "Enter a command:"
# read -r command
# if ! [[ ${command} == "e" || ${command} == "d" ]]; then
#     echo "Invalid command!"
#     exit
# fi

# re_message="^[A-Z ]+$"

# echo "Enter a message:"
# read -r message
# if ! [[ ${message} =~ ${re_message} ]]; then
#     echo "This is not a valid message!"
#     exit
# fi



# if [[ ${command} == "e" ]]; then
#     shift=$SHIFT
#     response="Encrypted message:"
# else
#     shift=$((0 - SHIFT))
#     response="Decrypted message:"
# fi


# START=$(ord "A")
# END=$(ord "Z")
# length=${#message}
# new_message=""

# for (( i=0; i<${length}; i++ )); do
#     char=${message:$i:1}

#     if [[ ${char} == " " ]]; then
#         new_message="${new_message} "
#         continue
#     fi

#     val=$(ord "$char")
#     val=$((val + shift))


#     if [ $val -gt $END ]; then
#         val=$((val - END + START - 1))
#     elif [ $val -lt $START ]; then
#         val=$((val + END - START + 1))
#     fi

#     new_char=$(chr "$val")    
#     new_message="${new_message}${new_char}"
# done


# printf "${response}\n${new_message}\n"
