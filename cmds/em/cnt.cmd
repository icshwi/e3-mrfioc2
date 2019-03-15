# require mrfioc2,2.2.0-rc5
# require iocStats,ae5d083
# Sec-Sub:Dis-Dev-Idx

epicsEnvSet("SEC", "ICS")
epicsEnvSet("SUB", "LAB")
epicsEnvSet("DIS", "DIA")
epicsEnvSet("DEV", "CNT0")
# epicsEnvSet("DEV1", "CNT0")
epicsEnvSet("IOCNAME", "$(SEC)-$(SUB):$(DIS)-$(DEV)")

# dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")
# dbLoadRecords("./cnt.db", "SYS=$(IOC), D=$(DEV1), IOC=$(IOCNAME)")

dbLoadRecords("./cnt.db", "IOC=$(IOCNAME)")

iocInit()

dbl > "$(IOCNAME)_PVs.list"
