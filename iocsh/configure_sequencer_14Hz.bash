#!/bin/bash
# Bash script to configure the EVG/EVR sequencer
# All values in us
# Record names have the general forms:
# $(SYS)-$(D):Signal-SD
# $(SYS)-$(D):SubDev-Signal-SD

SYS="$1"
DEV="$2"

PREFIX="${SYS}-${DEV}"
CAPUT="caput"
EventCode=14
EndOfSeqEvent=127

if hash ${CAPUT} 2>/dev/null ; then
    # Event code 14 (14 Hz), 127 is the end of sequence
    ${CAPUT} -a ${PREFIX}:SoftSeq0-EvtCode-SP 2 ${EventCode} ${EndOfSeqEvent}
    # Defining time at which the event codes are sent in us
    ${CAPUT} -a ${PREFIX}:SoftSeq0-Timestamp-SP 2 0 1
    
    # Commit the sequence to HW
    ${CAPUT} ${PREFIX}:SoftSeq0-Commit-Cmd 1
else
    printf "\n>>>> We cannot run $0\n";
    printf "     because we cannot find $CAPUT in the system\n"
    printf "     Something is not right. Please contact ICS\n"
    printf "\n"
fi
