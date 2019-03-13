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

# The following script should be called after iocInit()
iocshLoad("$(mrfioc2_DIR)/evr-standalone-mode.iocsh", "S=$(IOC), DEV=$(DEV)")

iocshLoad("$(mrfioc2_DIR)/univ0-ttl-output.iocsh", "S=$(IOC), DEV=$(DEV), EVENTCODE=$(MainEvtCODE)")

#dbpf $(IOC)-$(DEV):DlyGen0-Evt-Trig0-SP 14
#dbpf $(IOC)-$(DEV):DlyGen0-Width-SP 1000
#dbpf $(IOC)-$(DEV):OutFPUV00-Src-SP 0 

