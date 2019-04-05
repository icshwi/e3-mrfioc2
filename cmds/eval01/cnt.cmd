# require mrfioc2,2.2.0-rc5
# require iocStats,ae5d083

epicsEnvSet("IOCNAME0", "ICS-LAB:DIA-CNT-0")
dbLoadRecords("./cnt.db", "IOC=$(IOCNAME0)")
iocInit()

dbl > "$(IOCNAME)_PVs.list"
