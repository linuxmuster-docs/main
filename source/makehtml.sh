#!/bin/bash

cd ..
make clean && make html 2> log.txt
if [ -s log.txt ]
then
        cat log.txt
	echo -e "\n$(tput setaf 1)Gefundene Fehler:$(tput setaf 7)\n"
else
	git status
	echo -e "\n$(tput setaf 2)Gefundene Fehler: 0\n$(tput setaf 7)"
fi
rm log.txt
cd -
