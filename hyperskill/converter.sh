#!/usr/bin/bash

# write your code here

file="definitions.txt"
re_name='^[a-zA-Z]+\_to\_[a-zA-Z]+$'
re_int='(^0{1}$)|^\-?[1-9][0-9]*$'
re_float='(^\-?0{1}\.[0-9]*$)|^\-?[1-9][0-9]*\.[0-9]*$'

if [[ ! -f "$file" ]]; then
    touch "$file"
fi

echo "Welcome to the Simple converter!"

show_menue() {
    echo
    echo "Select an option"
    echo "0. Type '0' or 'quit' to end program"
    echo "1. Convert units"
    echo "2. Add a definition"
    echo "3. Delete a definition"
    read -a input_from_menue 
    menue="${input_from_menue[0]}"
}

show_definitions() {
    num=$(wc -l < "$file")
    for (( i=1; i<=num; i++ )); do
        echo "$i. $(sed -n "${i}p" "$file")"
    done
}

convert_units() {
    N=$(wc -l < "$file")

    if [[ $N == 0 ]]; then
        echo "Please add a definition first!"
        return
    fi

    echo "Type the line number to convert units or '0' to return"
    show_definitions

    while true; do
        
        read -a input_convert
        n="${input_convert[0]}"

 
        if [[ $n == "0" ]]; then
            return
        elif [[ $n -ge "1" &&  $n -le $N ]]; then
            definition=$(sed "${n}!d" "$file")
            break
        else
            echo "Enter a valid line number!"
            continue
        fi
        
    done
     
    constant="$(echo "$definition" | cut -d ' ' -f 2)"

    echo "Enter a value to convert:"

    while true; do
        read -a input_value
        value="${input_value[0]}"

        if ! [[ $value =~ $re_int || $value =~ $re_float ]]; then
            echo "Enter a float or integer value!"
            continue
        fi

        break
    done

    result=$(echo "scale=2; $constant * $value" | bc -l)
    printf "Result: %s\n" "$result"
}





add_definition() {


    while true; do
        echo 'Enter a definition:'
        read -a input_definition

        arr_length="${#input_definition[@]}"
        name="${input_definition[0]}"
        constant="${input_definition[1]}" 

        if ! [[ $arr_length == 2 && $name =~ $re_name && ($constant =~ $re_int || $constant =~ $re_float) ]]; then
            echo "The definition is incorrect!"
            continue
        fi

        echo -e "$name $constant" >> "$file"
        break
    done
}




delete_definition() {

    N=$(wc -l < "$file")

    if [[ $N == 0 ]]; then
        echo "Please add a definition first!"
        return
    fi

    echo "Type the line number to delete or '0' to return"
    show_definitions

    while true; do
        
        read -a input_delete
        n="${input_delete[0]}"

 
        if [[ $n == "0" ]]; then
            return
        elif [[ $n -ge "1" &&  $n -le $N ]]; then
            sed -i "${n}d" "$file"
            return
        else
            echo "Enter a valid line number!"
            continue
        fi
        
    done
}



while true; do

    show_menue

    case "$menue" in
        "0" | "quit" )
            echo "Goodbye!"
            exit
            ;;
        "1" )
            convert_units
            continue
            ;;
        "2" )
            add_definition
            continue
            ;;
        "3" )
            delete_definition
            continue
            ;;
        * )
            echo "Invalid option!"
            continue
            ;;
    esac

done
