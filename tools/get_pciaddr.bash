#!/bin/bash
#
#  Copyright (c) 2019  Jeong Han Lee
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
#   date    : Monday, October 21 13:49:21 CEST 2019
#   version : 0.0.3

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

EVR_CPCI_220="cpcievr220"
EVR_CPCI_230="cpcievr230"
EVR_CPCI_300="cpcievr300"
EVR_PCIE_300="pcieevr300"
EVR_MTCA_300="mtcaevr300"
EVG_CPCI_220="cpcievg220"
EVG_CPCI_230="cpcievg230"
EVG_CPCI_300="cpcievg300"
EVM_MTCA_300="mtcaevm300"

options+=${EVR_CPCI_220}
options+="|"
options+=${EVR_CPCI_230}
options+="|"
options+=${EVR_CPCI_300}
options+="|"
options+=${EVR_PCIE_300}
options+="|"
options+=${EVR_MTCA_300}
options+="|"
options+=${EVG_CPCI_220}
options+="|"
options+=${EVG_CPCI_230}
options+="|"
options+=${EVG_CPCI_300}
options+="|"
options+=${EVM_MTCA_300}



case "$1" in

    ${EVR_CPCI_220})
	DEVICEID=${CPICEVR220}
	;;
    ${EVR_CPCI_230})
	DEVICEID=${CPICEVR230}
	;;
    ${EVR_CPCI_300})
	DEVICEID=${CPICEVR300}
	;;
    ${EVR_PCIE_300})
	DEVICEID=${PCIEEVR300}
	;;
    ${EVR_MTCA_300})
	DEVICEID=${MTCAEVR300}
	;;
    ${EVG_CPCI_220})
	DEVICEID=${CPICEVG220}
	;;
    ${EVG_CPCI_230})
	DEVICEID=${CPCIEVG230}
	;;
    ${EVG_CPCI_300})
	DEVICEID=${CPICEVG300}
	;;
    ${EVM_MTCA_300})
	DEVICEID=${MTCAEVM300}
	;;
     *)
	echo "Usage: ${0##*/} possible_devices [${options}] "
	exit 1;
	;;

esac

echo ${DEVICEID}

list="$(lspci -nm |grep ${DEVICEID} | cut -d' ' -f1)"


for rep in ${list[@]}; do
    i+=1;
    printf "%d : Input %10s ---- PCI ID %10s\n" $i $1 $rep
done

exit

