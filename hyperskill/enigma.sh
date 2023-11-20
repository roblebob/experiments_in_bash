#!/usr/bin/bash

SHIFT=3

ord() {
  echo $(printf "%d\n" "'$1") 
}

chr() {
  echo $(printf "%b\n" "$(printf "\\%03o" "$1")")
}


echo "Type 'e' to encrypt, 'd' to decrypt a message:"
echo "Enter a command:"
read -r command
if ! [[ ${command} == "e" || ${command} == "d" ]]; then
    echo "Invalid command!"
    exit
fi

re_message="^[A-Z ]+$"

echo "Enter a message:"
read -r message
if ! [[ ${message} =~ ${re_message} ]]; then
    echo "This is not a valid message!"
    exit
fi



if [[ ${command} == "e" ]]; then
    shift=$SHIFT
    response="Encrypted message:"
else
    shift=$((0 - SHIFT))
    response="Decrypted message:"
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


printf "${response}\n${new_message}\n"
