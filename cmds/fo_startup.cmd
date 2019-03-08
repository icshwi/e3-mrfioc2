require mrfioc2, 2.2.0-rc5

epicsEnvSet("IOC", "MTCAFANOUT")
epicsEnvSet("DEV1", "EVMFO")

epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvgSetupPCI($(DEV1), "08:00.0")
dbLoadRecords("evg-mtca-300-ess.db",  "SYS=$(IOC), D=$(DEV4), EVG=$(DEV4), FEVT=$(ESSEvtClockRate)")


iocInit()

### Configure fan-out
dbpf $(IOC)-$(DEV1):EvtClk-Source-Sel "Upstream (fanout)"

