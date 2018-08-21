

#- iocshLoad "mtca-evr-300u.cmd" "UNIT=1, DEVPATH=06:00.0, IOC=$(IOC)"
epicsEnvSet("_PORT_EVR", "EVR_$(UNIT)")
epicsEnvSet("DEV", "$(_PORT_EVR):")

epicsEnvSet("_MainEvtCODE" "14")
epicsEnvSet("_HeartBeatEvtCODE"   "122")
epicsEnvSet("_ESSEvtClockRate"  "88.0525")


### Register the EVR with the IOC and load the database ###
mrmEvrSetupPCI("$(_PORT_EVR)",  "$(DEVPATH)")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(_PORT_EVR), SYS=$(IOC), D=$(DEV), FEVT=$(_ESSEvtClockRate)")

### Needed with software timestamp source w/o RT thread scheduling ###
var evrMrmTimeNSOverflowThreshold 100000


