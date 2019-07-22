require mrfioc2,2.2.0-rc5

epicsEnvSet("ENGINEER","Han")
epicsEnvSet("LOCATION","Table at ICS Tuna Lab")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "MTCA5U")
epicsEnvSet("DEV", "EVR")

# Not use in this script, but it is needed for the expansion.
epicsEnvSet("MainEvtCODE" "14")

iocshLoad("$(mrfioc2_DIR)/evr-mtca-300.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=09:00.0")
#-iocshLoad("$(mrfioc2_DIR)/evr-mtca-300.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=0b:00.0, RT=wtRT")

iocInit()

dbl > "${IOC}_PVs.list"

# The following script should be called after iocInit()
iocshLoad("$(mrfioc2_DIR)/evr-standalone-mode.iocsh", "S=$(IOC), DEV=$(DEV)")


