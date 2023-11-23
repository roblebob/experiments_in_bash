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


encrypt_decrypt_file_caesar(){

    SHIFT=3

    echo "Enter the filename:"
    read -r filename_in
    if [[ ! -f "${filename_in}" ]]; then
        echo "File not found!"
        return
    fi

    message=$(cat "${filename_in}")

    if [[ $1 == "e" ]]; then
        shift=$SHIFT
        filename_out="${filename_in}.enc"
    else
        shift=$((0 - SHIFT)) 
        filename_out="${filename_in::-4}"
    fi

    START=$(ord "A")
    END=$(ord "Z")
    length=${#message}
    new_message=""

    for (( i=0; i<${length}; i++ )); do
        char=${message:$i:1}

        if [[ ${char} == " " ]]; then
            new_message="${new_message} "
            continue
        fi

        val=$(ord "$char")
        val=$((val + shift))


        if [ $val -gt $END ]; then
            val=$((val - END + START - 1))
        elif [ $val -lt $START ]; then
            val=$((val + END - START + 1))
        fi

        new_char=$(chr "$val")    
        new_message="${new_message}${new_char}"
    done

    echo "${new_message}" > "${filename_out}"
    rm "${filename_in}"
    echo "Success"
}





encrypt_decrypt_file_openssl(){


    echo "Enter the filename:"
    read -r filename_in
    if [[ ! -f "${filename_in}" ]]; then
        echo "File not found!"
        return
    fi

    echo "Enter password:"
    read -r password


    if [[ $1 == "e" ]]; then
        filename_out="${filename_in}.enc"
    else
        filename_out="${filename_in::-4}"
    fi

    if [[ $1 == "e" ]]; then
        openssl enc -aes-256-cbc -e -pbkdf2 -nosalt -in "${filename_in}" -out "${filename_out}" -pass pass:"${password}" &> /dev/null
    else
        openssl enc -aes-256-cbc -d -pbkdf2 -nosalt -in "${filename_in}" -out "${filename_out}" -pass pass:"${password}" &> /dev/null
    fi
    exit_code=$?

    if [[ $exit_code -ne 0 ]]; then
        echo "Fail"
    else
        echo "Success"
        rm "${filename_in}"
    fi
    
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
        "3" )
            encrypt_decrypt_file_openssl "e"
            continue
            ;;
        "4" )
            encrypt_decrypt_file_openssl "d"
            continue
            ;;    
        * )
            echo "Invalid option!"
            continue
            ;;
    esac

done
