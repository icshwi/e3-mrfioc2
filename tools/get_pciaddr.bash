#!/bin/bash
#
#  Copyright (c) 2019  European Spallation Source ERIC
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
#   date    : Tuesday, March 12 09:47:01 CET 2019
#   version : 0.0.1

EXIST=1
NON_EXIST=0

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_TOP="${SC_SCRIPT%/*}"
declare -ga list=()
declare -i i=0; 

function checkIfVar()
{

    local var=$1;shift;
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

## if [[ $(checkIfFile "${release_file}") -eq "$NON_EXIST" ]]; then
#   NON_EXIT
## fi

function checkIfFile
{
    local file=$1; shift;
    local result=""
    if [ ! -e "$file" ]; then
	result=$NON_EXIST
	# doesn't exist
    else
	result=$EXIST
	# exist
    fi
    echo "${result}"
};


CPICEVR220="10dc"
CPCIEVR230="10e6"
CPCIEVR300="152c"
PCIEEVR300="172c"
MTCAEVR300="132c"

CPCIEVG220="20dc"
CPCIEVG230="20e6"
CPCIEVG300="252c"
MTCAEVM300="232c"


# logic test, dummy ids
#CPCIEVR230="2166"
#CPCIEVG230="3b64"



case "$1" in

    cpcievr220)
	DEVICEID=${CPICEVR220}
	;;
    cpcievr230)
	DEVICEID=${CPICEVR230}
	;;
    cpcievr300)
	DEVICEID=${CPICEVR300}
	;;
    pcieevr300)
	DEVICEID=${PCIEEVR300}
	;;
    mtcaevr300)
	DEVICEID=${MTCAEVR300}
	;;
    cpcievg220)
	DEVICEID=${CPICEVG220}
	;;
    cpcievg230)
	DEVICEID=${CPICEVG230}
	;;
    cpcievg300)
	DEVICEID=${CPICEVG300}
	;;
    mtcaevm300)
	DEVICEID=${MTCAEVM300}
	;;
     *)
	echo "Usage: $0 {pcieevr300|mtcaevr300|....}"
	exit 1;
	;;

esac

list="$(lspci -nm |grep ${DEVICEID} | cut -d' ' -f1)"


for rep in ${list[@]}; do
    i+=1;
    printf "%d : Input %10s ---- PCI ID %10s\n" $i $1 $rep
done

exit

