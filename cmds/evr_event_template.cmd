# This the full setup for the Timing System with E3.
#
require mrfioc2,2.2.0-rc5

### Define several needed macros ###
epicsEnvSet("ENGINEER","")
epicsEnvSet("LOCATION","")

epicsEnvSet("IOC", "EVREVENT")
epicsEnvSet("DEV1", "EVR0")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

### Register the EVR with the IOC and load the database ###
mrmEvrSetupPCI("$(DEV1)",  "0b:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")

### Needed with software timestamp source w/o RT thread scheduling ###
var evrMrmTimeNSOverflowThreshold 100000

### Load the evr-event database ###
dbLoadRecords("evr-event-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), CODE=23, EVNT=23")


iocInit()

# dbl > "${IOC}_PVs.list"

### Set delay compensation to 70 ns, needed to avoid timesptamp issue ###
dbpf $(IOC)-$(DEV1):DC-Tgt-SP 70

