#!/bin/bash

if [ -a directory.html ]
    then
        rm directory.html
fi 

touch directory.html

ls . >> directory.html

firefox ./directory.html
