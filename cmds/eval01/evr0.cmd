require mrfioc2,2.2.0-rc5
#require iocStats,ae5d083

epicsEnvSet("IOC", "MTCA")
epicsEnvSet("DEV1", "EVR0")
epicsEnvSet("ESSEvtClockRate", "88.0525")
mrmEvrSetupPCI("$(DEV1)", "09:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")

# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000
dbLoadRecords("./counter.db")

iocInit()

# Set delay compensation to 70 ns, needed to avoid timestamp issue 
dbpf $(IOC)-$(DEV1):DC-Tgt-SP 70

# Set the LED event 0 to event 14
dbpf $(IOC)-$(DEV1):Evt-Blink0-SP 14
dbl > "$(IOC)-$(DEV1)_PVs.list"
