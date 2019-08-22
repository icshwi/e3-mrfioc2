#!/bin/bash

# Author: Jerzy Jamroz
#
# Description:
#   It downloads the latest .iocsh files for this project. Tested withing gitlab.
# Run Information:
#   It has to be executed manually at the moment.

# define the .iocsh weblink
REPO=https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/tree/master/iocsh
echo "Update from the repository:"
echo ${REPO}
# https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/blob/master/iocsh
REPOFILE=`echo $REPO | sed -e 's/tree/raw/g'`
echo ${REPOFILE}

## curl -s https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/tree/master/iocsh | grep -i .iocsh | grep -i span | sed -e "s/<span>//g" | sed -e "s/<\/span>//g"
## arr_tmp=`curl -s https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/tree/master/iocsh | grep -i .iocsh | grep -i span | sed -e "s/<span>//g" | sed -e "s/<\/span>//g"`

# get the repo .iocsh files
arr_tmp=`curl -s $REPO | grep -i .iocsh | grep -i span | sed -e "s/<span>//g" | sed -e "s/<\/span>//g"`
arr=($arr_tmp)

for el in "${arr[@]}"
do
    if [[ $el != _* ]]; then
        echo "$el"
        curl ${REPOFILE}/${el} > ${el}
    fi
done

