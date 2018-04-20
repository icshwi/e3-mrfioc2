# This the full setup for the Timing System with E3.
#
#require require,2.5.4
require devlib2,2.9.0
require mrfioc2,2.2.0
#require iocStats,1856ef5
# require autosave, 5.8.0


epicsEnvSet("ENGINEER","")
epicsEnvSet("LOCATION","")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "WAVEGENTRIG")
epicsEnvSet("DEV1", "EVR1")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvrSetupPCI("$(DEV1)",  "01:00.0")
dbLoadRecords("evr-pcie-300dc-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")


# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000


# iocStats
#dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC):IocStats")



iocInit()


#dbl > "${IOC}_PVs.list"

dbpf $(IOC)-$(DEV1):DlyGen0-Evt-Trig0-SP 122
dbpf $(IOC)-$(DEV1):DlyGen0-Width-SP 1000
dbpf $(IOC)-$(DEV1):OutFPUV02-Src-SP 0

