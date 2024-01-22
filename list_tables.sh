#!/bin/bash

clear

read -p "Enter the name of the connected database: " connect_db

db_folder="db"

if [ -d "$db_folder/$connect_db" ]; then
    echo -e "\e[34m<<<<<<<<<<<< Tables in the database '$connect_db' >>>>>>>>>>>>>>>>>\e[0m"

    for i in "$db_folder/$connect_db"/*; do
        filename=$(basename "$i")
        echo "$filename"
    done
else
    echo -e "\e[31mError: Database '$connect_db' not found.\e[0m"
fi

source ./menu.sh

