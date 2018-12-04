#!/bin/bash
#
#  Copyright (c) 2018 - Present  Jeong Han Lee
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Tuesday, December  4 19:09:43 CET 2018
#   version : 0.0.2

EXIST=1
NON_EXIST=0

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_TOP="${SC_SCRIPT%/*}"
declare -ga list=()
declare -i i=0; 

function checkIfVar()
{

    local var=$1
    local result=""
    if [ -z "$var" ]; then
	result=$NON_EXIST
	# doesn't exist
    else
	result=$EXIST
	# exist
    fi
    echo "${result}"
}

CPCIEVR230="10e6"
CPCIEVG230="20e6"
CPCIEVR230="17aa"
CPCIEVG230="3b64"
EVG_RANDOM_IN="${SC_TOP}/random_cpci_evg.in"
EVG_RANDOM_OUT="${SC_TOP}/random_cpci_evg.cmd"
EVR_RANDOM_IN="${SC_TOP}/random_cpci_evr.in"
EVR_RANDOM_OUT="${SC_TOP}/random_cpci_evr.cmd"
RANDOM_IN=""
RANDOM_OUT=""



case "$1" in

    evg) 
	DEVICEID=${CPCIEVG230}
	RANDOM_IN=${EVG_RANDOM_IN}
	RANDOM_OUT=${EVG_RANDOM_OUT}
	;;
    evr) 
	DEVICEID=${CPCIEVR230}
	RANDOM_IN=${EVR_RANDOM_IN}
	RANDOM_OUT=${EVR_RANDOM_OUT}
	;;
    *)
	echo "Usage: $0 {evg|evr}"
	exit 1;
	;;

esac


printf "Device ID %s\n" "${DEVICEID}"
printf "In        %s\n" "${RANDOM_IN}"
printf "Out       %s\n" "${RANDOM_OUT}"

list="$(lspci -nm |grep ${DEVICEID} | cut -d' ' -f1)"

if [ "$1" = "evg" ]; then
    sed -e "s\\_deviceid_\\${list}\\g" < ${RANDOM_IN} > ${RANDOM_OUT}
    
elif  [ "$1" = "evr" ]; then
    rm ${RANDOM_OUT}
    for rep in  ${list[@]}; do
	
	i+=1;
	echo $i $rep
	if [ "$i" -eq 1 ]; then
	    sed -e "s\\_NUM_\\${i}\\g;s\\_deviceid_\\${rep}\\g" < ${RANDOM_IN} > ${RANDOM_OUT}
	elif  [ "$i" -gt 1 ]; then
	    sed -e "s\\_NUM_\\${i}\\g;s\\_deviceid_\\${rep}\\g" < ${RANDOM_IN} >> ${RANDOM_OUT}
	fi
    done
fi

more ${RANDOM_OUT}


