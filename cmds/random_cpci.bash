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


C="$(lspci -nm |grep 20e6 | cut -d' ' -f1)"

#echo ${C}


if [[ $(checkIfVar "${C}") -eq "$EXIST" ]]; then
    sed -e "s\_deviceid_\\${C}\g" < ${SC_TOP}/random_cpci.in > ${SC_TOP}/random_cpci.cmd
else
    printf "We cannot find the CPCI EVG 230 in the system\n";
    exit;
fi



