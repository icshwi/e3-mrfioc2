require devlib2, 2.9.0
require mrfioc2, 2.2.0
require iocStats, 1856ef5
require autosave, 5.8.0

epicsEnvSet("ENGINEER","hanlee x3409")
epicsEnvSet("LOCATION","ICS Tuna Lab")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("AUTOSAVE", "/home/timinguser/autosave")

epicsEnvSet("IOC", "FREIA-CPCI:EVG0")

mrmEvgSetupPCI("EVG0", "10:e.0")

#dbLoadRecords("cpci-evg-300.db", "SYS=TST, D=evg:1, EVG=EVG1")

iocInit()

dbl > "${IOC}_PVs.list"

