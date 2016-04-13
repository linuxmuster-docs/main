#!/bin/bash

#for i in $(grep source source/guidelines/index.rst) ; do
#    echo $i 
#    target=source/guidelines/$(echo $i |  sed "s@source/.*@@")
#done

list_of_remotes="
howto_installationsleitfaden
howto_linuxclients
howto_windows10clients
howto_printer
howto_leoclient2
howto_backupmondo
addon_monipi
"

# create the remotes if nescessary
for i in $list_of_remotes; do
    echo "Checking and adding $i."
    git remote show $i > /dev/null 2>&1
    if [ $? -ne 0 ]; then
       git remote add -f $i git@github.com:linuxmuster-docs/${i}.git
    fi
done

## update the remote repositories
#for i in $list_of_remotes; do
#    echo "Updateing $i."
#    git pull -s subtree $i master
#done

