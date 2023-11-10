#!/usr/bin/bash

# write your code here

if [[ ! -f definitions.txt ]]; then
    touch "definitions.txt"
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
}

add_definition() {
    re0='^[a-zA-Z]+\_to\_[a-zA-Z]+$'
    re_int='(^0{1}$)|^\-?[1-9][0-9]*$'
    re_float='(^\-?0{1}\.[0-9]*$)|^\-?[1-9][0-9]*\.[0-9]*$'

    while true; do
        echo 'Enter a definition:'
        read -a input_definition

        arr_length="${#input_definition[@]}"
        definition="${input_definition[0]}"
        constant="${input_definition[1]}" 

        if ! [[ $arr_length == 2 && $definition =~ $re0 && ($constant =~ $re_int || $constant =~ $re_float) ]]; then
            echo "The definition is incorrect!"
            continue
        fi

        echo -e "$definition $constant" >> definitions.txt
        break
    done
}

show_definitions() {
    num=$(wc -l < definitions.txt)
    for (( i=1; i<=num; i++ )); do
        echo "$i. $(sed -n "${i}p" definitions.txt)"
    done
}


delete_definition() {

    N=$(wc -l < definitions.txt)

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
            sed -i "${n}d" definitions.txt
            return
        else
            echo "Enter a valid line number!"
            continue
        fi
        
    done
}



while true; do

    show_menue

    case "$input_from_menue" in
        "0" | "quit" )
            echo "Goodbye!"
            exit
            ;;
        "1" )
            echo "Not implemented!"
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









# echo "Enter a value to convert:"
# read -a value

# while ! [[ $value =~ $re_int || $value =~ $re_float ]]
# do
#     echo "Enter a float or integer value!"
#     read -a value
# done

# result=$(echo "scale=2; $constant * $value" | bc -l)
# printf "Result: %s\n" "$result"