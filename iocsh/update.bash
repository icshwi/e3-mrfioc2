#!/bin/bash

REPO=https://gitlab.esss.lu.se/icshwi/hwi-tim-prod/blob/master/iocsh

declare -a arr=(\
"_evg-seq0-run.iocsh" \
"_evg-seq0-smoke.iocsh" \
"_evg-seq01-run.iocsh" \
"_evr-seq-run.iocsh" \
"env-init.iocsh" \
"evg-mtca-init.iocsh" \
"evg-mtca-run.iocsh" \
"evm-mtca-init.iocsh" \
"evr-mtca-init.iocsh" \
"evr-mtca-run.iocsh" \
"img.iocsh" \
)

for el in "${arr[@]}"
do
   echo "$el"
   curl ${REPO}/${el} > ${el}
done
 

#file_tmp=env-init.iocsh
#curl ${REPO}/${file_tmp} > ${file_tmp}