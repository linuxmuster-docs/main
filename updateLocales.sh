#!/bin/bash

#cleanup
make clean
rm -rf .tx

#update translations
make gettext
tx init --host=https://www.transifex.com
sphinx-intl update -p build/locale -l en
sphinx-intl update-txconfig-resources --pot-dir build/locale --transifex-project-name official-documentation

#push changes
tx push -s

#pull latest translations
tx pull -l en

git add source/locale

