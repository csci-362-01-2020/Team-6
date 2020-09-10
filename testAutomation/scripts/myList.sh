#!/bin/bash

if [ -a directory.html ]
    then
        rm directory.html
fi 

touch directory.html

lc . >> directory.html

firefox ./directory.html
