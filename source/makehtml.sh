#!/bin/bash

cd ..
make clean && make html 2> log.txt && echo -e "\nGefundene Fehler:\n" && cat log.txt && rm log.txt
cd -
