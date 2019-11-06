# .cmd
# ====
epicsEnvSet("TOP", "$(E3_CMD_TOP)/../..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

epicsEnvSet("LOCATION","cslab")

epicsEnvSet("IOC", "CRATE07")
epicsEnvSet("DEV", "EVG")

# Select the software release
require mrfioc2, 2.2.0-rc6

# INIT (select your create)
## 5U
## iocshLoad("$(TOP)/iocsh/evm-mtca-init.iocsh", "IOC=$(IOC), DEV=$(DEV), PCIID=$(MTCA_5U_PCIID7)")
## 9U
iocshLoad("$(TOP)/iocsh/evm-mtca-init.iocsh", "IOC=$(IOC), DEV=$(DEV), PCIID=$(MTCA_9U_PCIID2)")
## 3U
##iocshLoad("$(TOP)/iocsh/evm-mtca-init.iocsh", "IOC=$(IOC), DEV=$(DEV), PCIID=$(MTCA_3U_PCIID6)")

iocInit()

# RUNTIME
# =======
iocshLoad("$(TOP)/iocsh/evg-run.iocsh", "IOC=$(IOC), DEV=$(DEV), INTREF=''")
# Add normal operation sequencer0 for tests
iocshLoad("$(TOP)/iocsh/_evg-seq0-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")

# dbl > "${IOC}_PVs.list"

#EOF
