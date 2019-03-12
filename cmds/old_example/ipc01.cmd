# This the full setup for the Timing System with E3.
# 
#require require,2.5.4
#require devlib2,2.9.0
require mrfioc2,2.2.0
require iocStats,1856ef5
# require autosave, 5.8.0


epicsEnvSet("ENGINEER","Han")
epicsEnvSet("LOCATION","Table at ICS Tuna Lab")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "Doppler01-PCIE")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvrSetupPCI("EVR1",  "01:00.0")
mrmEvrSetupPCI("EVR2",  "02:00.0")
dbLoadRecords("evr-pcie-300dc-ess.db","EVR=EVR1, SYS=$(IOC), D=evr1, FEVT=$(ESSEvtClockRate)")
dbLoadRecords("evr-pcie-300dc-ess.db","EVR=EVR2, SYS=$(IOC), D=evr2, FEVT=$(ESSEvtClockRate)")


# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000


# iocStats
dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC):IocStats")



iocInit()


dbl > "${IOC}_PVs.list"

# Set delay compensation to 70 ns, needed to avoid timesptamp issue
dbpf $(IOC)-$(DEV1):DC-Tgt-SP 70

# Set the correct frequency to calculate the timestamp nanosecond part (assuming EVG uses external RF)
dbpf $(IOC)-$(DEV1):Time-Clock-SP $(ESSEvtClockRate)

