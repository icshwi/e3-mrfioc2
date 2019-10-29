# .cmd
# ====
epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

epicsEnvSet("IOC", "MTCA5U")
epicsEnvSet("DEV", "EVM")

require mrfioc2, 2.2.0-devel

iocshLoad("$(TOP)/iocsh/evg-mtca-init.iocsh", "IOC=$(IOC), DEV=$(DEV), PCIID=$(MTCA_5U_PCIID6)")

iocInit()

#EOF
