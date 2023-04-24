#!/usr/bin/env bash

set -e

if [ $# -eq 0 ]; then
 echo "usage: ./list_todos.sh <kernel-src>"
 exit 1
fi

cd "$1"
echo "" > /tmp/todolist-kernel.txt; count=0; for entry in `find . -name "*TODO*"`; do echo $count". "$entry`git log --pretty=format:" Last edited %ar" $entry | head -1` >> /tmp/todolist-kernel.txt; echo "" >> /tmp/todolist-kernel.txt; sed 's/^/        /' $entry >> /tmp/todolist-kernel.txt; echo "" >> /tmp/todolist-kernel.txt; ((count=$count+1)); done
while true; do
    read -p "File generated"
    read -p "Do you want to read it? " yn
    case $yn in
        [Yy]* ) cat /tmp/todolist-kernel.txt; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
