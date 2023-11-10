#!/usr/bin/env bash

personal_data() {
    echo "Your name is $1"
    echo "Your age is $2"
    echo $*
}

personal_data "Robert" 42