#.cmd
#====

# Config section
# ==============
epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

epicsEnvSet("LOCATION","PCIE")

epicsEnvSet("IOC", "TEST")
epicsEnvSet("DEV", "EVR")

# Require section
# ===============
require mrfioc2, 2.2.0-rc7

# Init section
# ============
iocshLoad("$(mrfioc2_DIR)/evr-pcie-300dc.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=03:00.0")

iocInit()

# Run section
# ===========
iocshLoad("$(TOP)/iocsh/evr-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")

# dbl > "${IOC}_PVs.list"

#EOF
