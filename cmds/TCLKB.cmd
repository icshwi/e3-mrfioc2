# This the full setup for the Timing System with E3.
#
#require require,2.5.4
#require devlib2,2.9.0
require mrfioc2,2.2.0-rc1
require iocStats,1856ef5
# require autosave, 5.8.0


epicsEnvSet("ENGINEER","")
epicsEnvSet("LOCATION","ICS Tuna Lab")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "TCLKB:")
epicsEnvSet("EVR", "EVR1")
epicsEnvSet("DEV1", "$(EVR):")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvrSetupPCI("$(EVR)",  "06:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(EVR), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")


# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000


# iocStats
dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC):IocStats")



iocInit()


dbl > "${IOC}_PVs.list"

dbpf $(IOC)$(DEV1)OutTCLKB-Src-SP 63
dbpf $(IOC)$(DEV1)OutTCLKB-Ena-Sel 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pwr-Sel 1

dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.BF 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.BE 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.BD 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.BC 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.BB 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.BA 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B9 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B8 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B7 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B6 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B5 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B4 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B3 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B2 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B1 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low00_15-SP.B0 1

dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low16_31-SP.BF 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low16_31-SP.BE 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low16_31-SP.BD 1
dbpf $(IOC)$(DEV1)OutTCLKB-Pat-Low16_31-SP.BC 1

