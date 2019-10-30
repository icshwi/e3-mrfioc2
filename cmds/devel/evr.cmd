#.cmd
#====

# Config section
# ================
epicsEnvSet("TOP", "$(E3_CMD_TOP)/../..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

# epicsEnvSet("LOCATION","MTCA:AMC2")

# run with: iocsh.bash -c 'epicsEnvSet("IOC", "TD11")' evr.cmd
epicsEnvSet("IOC", "CRATE07")
epicsEnvSet("DEV", "EVR")

# Require section
# =================
require mrfioc2, devel

# Init section
# ==============
# mTCA-XU
iocshLoad("$(TOP)/iocsh/evr-mtca-init.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=$(MTCA_9U_PCIID12)")
# iocshLoad("$(TOP)/iocsh/evr-mtca-300.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=0e:00.0, RT=wtRT")

iocInit()

# Run section
# =============
iocshLoad("$(TOP)/iocsh/evr-mtca-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")
# iocshLoad("$(TOP)/iocsh/evr-mtca-out-run.iocsh", "IOC=$(IOC), DEV=$(DEV), BPOUT='', FPOUT=''")

# dbl > "${IOC}_PVs.list"

#EOF
