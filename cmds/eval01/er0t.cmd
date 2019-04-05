require mrfioc2,2.2.0-rc5
# require iocStats,ae5d083
# ESSNAME="Sec-Sub:Dis-Dev-Idx"

epicsEnvSet("SYS", "ICS-LAB:TIM")
epicsEnvSet("DEV1", "EVR-0")
epicsEnvSet("ESSEvtClockRate", "88.0525")
mrmEvrSetupPCI("$(DEV1)", "07:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV1), SYS=$(SYS), D=$(DEV1), FEVT=$(ESSEvtClockRate)")

# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000
dbLoadRecords("./counter.db")

iocInit()

# Set delay compensation to 70 ns, needed to avoid timestamp issue 
dbpf $(SYS)-$(DEV1):DC-Tgt-SP 70

# Set the LED event 0 to event 14
dbpf $(SYS)-$(DEV1):Evt-Blink0-SP 14
dbl > "$(SYS)-$(DEV1)_PVs.list"
