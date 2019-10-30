# .cmd
# ====
epicsEnvSet("TOP", "$(E3_CMD_TOP)/../..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

epicsEnvSet("LOCATION","MTCA:AMC2")

epicsEnvSet("IOC", "MTCA5U")
epicsEnvSet("DEV", "EVR1")

require mrfioc2, devel

# mTCA-XU
iocshLoad("$(TOP)/iocsh/evr-mtca-init.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=$(MTCA_5U_PCIID3)")
# iocshLoad("$(TOP)/iocsh/evr-mtca-300.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=0e:00.0, RT=wtRT")

iocInit()

iocshLoad("$(TOP)/iocsh/evr-mtca-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")
iocshLoad("$(TOP)/iocsh/evr-mtca-in-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")

# dbl > "${IOC}_PVs.list"

#EOF
