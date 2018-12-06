# This the full setup for the Timing System with E3.
#
require mrfioc2,2.2.0-rc5

### Define several needed macros ###
epicsEnvSet("ENGINEER","")
epicsEnvSet("LOCATION","")

epicsEnvSet("IOC", "DLYMOD")
epicsEnvSet("DEV1", "EVR0")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

### Register the EVR with the IOC and load the database ###
mrmEvrSetupPCI("$(DEV1)",  "0b:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")

### Needed with software timestamp source w/o RT thread scheduling ###
var evrMrmTimeNSOverflowThreshold 100000

### Load the delay module database, options SLOT=0 or SLOT=1 ###
dbLoadRecords("evr-delayModule-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), SLOT=1")


iocInit()

# dbl > "${IOC}_PVs.list"

### Set delay compensation to 70 ns, needed to avoid timesptamp issue ###
dbpf $(IOC)-$(DEV1):DC-Tgt-SP 70

### Trigger OutFPUV0, OutFPUV2 and OutFPUV3 at 14 Hz, OutFPUV2 has a delay of 5 ns and OutFPUV3 of 8 ns ###
dbpf $(IOC)-$(DEV1):DlyGen0-Evt-Trig0-SP $(MainEvtCODE)
dbpf $(IOC)-$(DEV1):DlyGen0-Width-SP 1000 # time in us
dbpf $(IOC)-$(DEV1):OutFPUV0-Src-SP 0 # trigger from delay generator 0
dbpf $(IOC)-$(DEV1):OutFPUV2-Src-SP 0 # trigger from delay generator 0
### This should be run manually after starting the IOC ###
# dbpf $(IOC)-$(DEV1):UnivDlyModule1-Delay0-SP 5
# dbpf $(IOC)-$(DEV1):UnivDlyModule1-Delay1-SP 8
