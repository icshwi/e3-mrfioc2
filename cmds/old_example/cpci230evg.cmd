#require devlib2, 2.9.0
require mrfioc2, 2.2.0
require iocStats, 1856ef5
require autosave, 5.8.0

epicsEnvSet("ENGINEER","hanlee x3409")
epicsEnvSet("LOCATION","ICS Tuna Lab")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("AUTOSAVE", "/home/timinguser/autosave")

epicsEnvSet("IOC", "FREIA-CPCI")
epicsEnvSet("DEV1", "EVG0")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvgSetupPCI("$(DEV1)", "16:0e.0")

dbLoadRecords("evg-cpci-230-ess.db", "SYS=$(IOC), D=$(DEV1), EVG=$(DEV1), FEVT=$(ESSEvtClockRate), FRF=352.21, FDIV=4")

# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000


iocInit()


dbl > "${IOC}_PVs.list"

dbpf "$(IOC)-$(DEV1):1ppsInp-Sel" "Sys Clk"

# # Master Event Rate 14 Hz
dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 6289464
dbpf $(IOC)-$(DEV1):TrigEvt0-EvtCode-SP $(MainEvtCODE)
dbpf $(IOC)-$(DEV1):TrigEvt0-TrigSrc-Sel "Mxc0"

# # Heart Beat 1 Hz
dbpf $(IOC)-$(DEV1):Mxc7-Prescaler-SP 88052496
dbpf $(IOC)-$(DEV1):TrigEvt7-EvtCode-SP $(HeartBeatEvtCODE)
dbpf $(IOC)-$(DEV1):TrigEvt7-TrigSrc-Sel "Mxc7"

# Is there something similar to sleep(5)????
dbpf $(IOC)-$(DEV1):SyncTimestamp-Cmd 1

