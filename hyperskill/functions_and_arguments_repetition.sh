#!/usr/bin/bash

hello() {
    read -r name
    echo "Hello, user $name!"
}

hello