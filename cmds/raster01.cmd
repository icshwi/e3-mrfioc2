# This the full setup for the Timing System with E3.
# 
#require require,2.5.4
require devlib2,2.9.0
require mrfioc2,2.2.0
require iocStats,1856ef5


epicsEnvSet("ENGINEER","Han")
epicsEnvSet("LOCATION","Table at ICS Tuna Lab")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "RM01-PCIE")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvrSetupPCI("EVR1",  "01:00.0")
#dbLoadRecords("evr-pcie-300dc-ess.db","SYS=$(IOC), D=EVR1")

# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000


# iocStats
dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC):IocStats")



iocInit()


dbl > "${IOC}_PVs.list"

