#!/usr/bin/bash


ord() {
  echo $(printf "%d\n" "'$1") 
}

chr() {
  echo $(printf "%b\n" "$(printf "\\%03o" "$1")")
}


re_alpha="^[A-Z]$"
re_int="^[0-9]$"


echo "Enter an uppercase letter:"
read -a input
uppercase_letter="${input[0]}"
echo "Enter a key:"
read -a input
key="${input[0]}"

if ! [[ ${uppercase_letter} =~ ${re_alpha}  &&  ${key} =~ ${re_int} ]]; then
    echo "Invalid key or letter!"
    exit
fi


ascii_val_start=$(ord "A")
ascii_val_end=$(ord "Z")
ascii_val=$(ord "$uppercase_letter")

ascii_val_new=$((ascii_val + key))
 
if [ $ascii_val_new -gt $ascii_val_end ]; then
    ascii_val_new=$((ascii_val_new - ascii_val_end + ascii_val_start - 1))
fi


new_char=$(chr "$ascii_val_new")

echo "Encrypted letter: ${new_char}"




















# write your code here
# echo "Enter a message:"
# read -r input
# re="^[A-Z ]+$"
# if [[ $input =~ $re ]]; then
#     echo "This is a valid message!"
# else
#     echo "This is not a valid message!"
# fi
