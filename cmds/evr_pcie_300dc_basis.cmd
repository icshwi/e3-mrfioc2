require mrfioc2,2.2.0-rc5

epicsEnvSet("ENGINEER","Han")
epicsEnvSet("LOCATION","Table at ICS Tuna Lab")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "PCIE")
epicsEnvSet("DEV", "EVR")

epicsEnvSet("MainEvtCODE" "14")

iocshLoad("$(mrfioc2_DIR)/evr-pcie-300dc.iocsh", "DEV=$(DEV), SYS=$(IOC), PCIID=03:00.0")

iocInit()

dbl > "${IOC}_PVs.list"
