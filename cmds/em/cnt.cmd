# require mrfioc2,2.2.0-rc5
# require iocStats,ae5d083

epicsEnvSet("IOC", "DIACNT")
epicsEnvSet("DEV1", "CNT0")

# dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")

dbLoadRecords("./cnt.db", "SYS=$(IOC), D=$(DEV1)")

iocInit()

dbl > "$(IOC)-$(DEV1)_PVs.list"
