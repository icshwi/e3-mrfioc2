#!/bin/bash

REPO=https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/blob/master/iocsh

#declare -a arr=(\
#"_evg-seq0-run.iocsh" \
#"_evg-seq0-smoke.iocsh" \
#"_evg-seq01-run.iocsh" \
#"_evr-seq-run.iocsh" \
#"env-init.iocsh" \
#"evg-mtca-init.iocsh" \
#"evg-mtca-run.iocsh" \
#"evm-mtca-init.iocsh" \
#"evr-mtca-init.iocsh" \
#"evr-mtca-run.iocsh" \
#"img.iocsh" \
#)

# get the repo .iocsh files
# curl -s https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/tree/master/iocsh | grep -i .iocsh | grep -i span | sed -e "s/<span>//g" | sed -e "s/<\/span>//g"
arr_tmp=`curl -s https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/tree/master/iocsh | grep -i .iocsh | grep -i span | sed -e "s/<span>//g" | sed -e "s/<\/span>//g"`

for el in "${arr[@]}"
do
   echo "$el"
   echo "---"
   curl ${REPO}/${el} > ${el}
done


#file_tmp=env-init.iocsh
#curl ${REPO}/${file_tmp} > ${file_tmp}
