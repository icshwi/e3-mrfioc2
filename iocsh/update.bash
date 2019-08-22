#!/bin/bash

# Author: Jerzy Jamroz
#
# Description:
#   It downloads the latest .iocsh files for this project.
# Run Information:
#   It has to be executed manually at the moment.

# define the .iocsh weblink
REPO=https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/tree/master/iocsh

## curl -s https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/tree/master/iocsh | grep -i .iocsh | grep -i span | sed -e "s/<span>//g" | sed -e "s/<\/span>//g"
## arr_tmp=`curl -s https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/tree/master/iocsh | grep -i .iocsh | grep -i span | sed -e "s/<span>//g" | sed -e "s/<\/span>//g"`

# get the repo .iocsh files
arr_tmp=`curl -s $REPO | grep -i .iocsh | grep -i span | sed -e "s/<span>//g" | sed -e "s/<\/span>//g"`
arr=($arr_tmp)

for el in "${arr[@]}"
do
    if [[ $el != _* ]]; then
        echo "$el"
        curl ${REPO}/${el} > ${el}
    fi
done
