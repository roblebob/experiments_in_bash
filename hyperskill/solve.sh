#!/usr/bin/env bash

solve() {
    # add your solution here
    if [ "$(( $1 + $2 + $3 ))" -eq "180" ]; then
        echo 'Yes'
    else
        echo 'No'
    fi
}
 
solve $1 $2 $3
