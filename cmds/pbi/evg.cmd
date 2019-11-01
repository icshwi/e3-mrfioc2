# .cmd
# ====
epicsEnvSet("TOP", "$(E3_CMD_TOP)/../..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

epicsEnvSet("LOCATION","PBI LAB")

epicsEnvSet("IOC", "MTCA5U")
epicsEnvSet("DEV", "EVG")

# Select the software release
require mrfioc2, 2.2.0-rc7

iocshLoad("$(TOP)/iocsh/evm-mtca-init.iocsh", "IOC=$(IOC), DEV=$(DEV), PCIID=$(MTCA_5U_PCIID7)")

iocInit()

# RUNTIME
# =======
iocshLoad("$(TOP)/iocsh/evg-mtca-run.iocsh", "IOC=$(IOC), DEV=$(DEV), INTREF=''")
iocshLoad("$(TOP)/iocsh/evg-seq0-NBP-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")

# dbl > "${IOC}_PVs.list"

#EOF
