# .cmd
# ====
epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

epicsEnvSet("LOCATION","MBL-070ROW:CNPW-U-017:AMC2")

epicsEnvSet("IOC", "MTCA5U")
epicsEnvSet("DEV", "EVG")

require mrfioc2, 2.2.0-rc7

# mTCA-XU
iocshLoad("$(TOP)/iocsh/evg-mtca-init.iocsh", "IOC=$(IOC), DEV=$(DEV), PCIID=$(MTCA_5U_PCIID7)")
# Realtime kernel
# iocshLoad("$(TOP)/iocsh/evg-mtca-init.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=0b:00.0, RT=wtRT")

iocInit()

# RUNTIME
# =======

iocshLoad("$(TOP)/iocsh/evg-mtca-run.iocsh", "IOC=$(IOC), DEV=$(DEV), INTREF=''")
# Add normal operation sequencer0 for tests

iocshLoad("$(TOP)/iocsh/_evg-seq0-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")
# iocshLoad("$(TOP)/iocsh/_evg-seq0-smoke.iocsh", "IOC=$(IOC), DEV=$(DEV)")
# iocshLoad("$(TOP)/iocsh/_evg-seq01-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")

dbl > "${IOC}-${DEV}_PVs.list"

#EOF
