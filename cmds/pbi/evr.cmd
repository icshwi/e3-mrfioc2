#.cmd
#====

# Config section
# ==============
epicsEnvSet("TOP", "$(E3_CMD_TOP)/../..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

epicsEnvSet("LOCATION","MTCA:AMC2")

# run with: iocsh.bash -c 'epicsEnvSet("IOC", "PBIxx")' evr.cmd
epicsEnvSet("IOC", "MTCA5U")
epicsEnvSet("DEV", "EVR")

# Require section
# ===============
require mrfioc2, 2.2.0-rc7

# Init section
# ============
# mTCA-XU
iocshLoad("$(TOP)/iocsh/evr-mtca-init.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=$(MTCA_5U_PCIID2)")

iocInit()

# Run section
# ===========
iocshLoad("$(TOP)/iocsh/evr-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")
iocshLoad("$(TOP)/iocsh/evr-output-run.iocsh", "IOC=$(IOC), DEV=$(DEV), BPOUT0='', EVT0=$(EVT_14HZ), BPOUT1='', EVT1=$(EVT_BPULSE_CM), BPOUT2='', EVT2=$(EVT_BPULSE_ST), BPOUT3='', EVT3=$(EVT_PPS), BPOUT4='', EVT4=$(EVT_PMORTEM), BPOUT5=#, EVT5=#, BPOUT6='', EVT6=$(EVT_DOD), BPOUT7=#, EVT7=#")
iocshLoad("$(TOP)/iocsh/evr-input-run.iocsh", "IOC=$(IOC), DEV=$(DEV), BPIN0=#, BPIN1=#, BPIN2=#, BPIN3=#, BPIN4=#, BPIN5='', EVT5=$(EVT_PMORTEMI), BPIN6=#, BPIN7='', EVT7=$(EVT_DODI)")

# dbl > "${IOC}_PVs.list"

#EOF
