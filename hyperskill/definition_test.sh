#!/usr/bin/bash

show_definitions() {
    num=$(wc -l < definitions.txt)
    for (( i=1; i<=num; i++ )); do
        echo "$i. $(sed -n "${i}p" definitions.txt)"
    done
}

show_definitions