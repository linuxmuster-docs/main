#!/bin/bash

cd ..
make clean && make html 2> log.txt
if [ -s log.txt ]
then
	echo -e "\nGefundene Fehler:\n"
        cat log.txt
else
	echo -e "\nGefundene Fehler: 0\n"
fi
rm log.txt
cd -
