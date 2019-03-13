require mrfioc2,2.2.0-rc5

epicsEnvSet("ENGINEER","Han")
epicsEnvSet("LOCATION","Table at ICS Tuna Lab")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "PCIE")
epicsEnvSet("DEV", "EVR")

# Not use in this script, but it is needed for the expansion. 
epicsEnvSet("MainEvtCODE" "14")

iocshLoad("$(mrfioc2_DIR)/evr-pcie-300dc.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=03:00.0")
#iocshLoad("$(mrfioc2_DIR)/evr-pcie-300dc.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=03:00.0, RT=wtRT")

iocInit()

dbl > "${IOC}_PVs.list"
