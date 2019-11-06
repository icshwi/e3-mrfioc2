# .cmd
# ====

require mrfioc2, 2.2.0-rc5

# Load timing global constants
epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

# PARAMS
# DEV - device name e.g. DEV=EVR4
# EVM, EVR - device type e.g. EVR='' or EVM=''
# BIN_RD, BIN_WR -activity, if img write then BIN_WR=''
# BIN_FILE - .bit file path
# PCIID - PCI address
# assumes that the image repo is ../../hwi-fw/mrf/

# iocshLoad("$(TOP)/iocsh/img.iocsh", "DEV=EVM6, EVM='', BIN_WR='', PCIID=$(MTCA_5U_PCIID6), BIN_FILE='../../hwi-fw/mrf/mTCA-EVM-300-280A0207.bit'")

iocshLoad("$(TOP)/iocsh/img.iocsh", "DEV=EVR2, EVR='', PCIID=$(MTCA_5U_PCIID2)")
iocshLoad("$(TOP)/iocsh/img.iocsh", "DEV=EVR3, EVR='', PCIID=$(MTCA_5U_PCIID3)")
iocshLoad("$(TOP)/iocsh/img.iocsh", "DEV=EVR4, EVR='', PCIID=$(MTCA_5U_PCIID4)")
iocshLoad("$(TOP)/iocsh/img.iocsh", "DEV=EVR5, EVR='', PCIID=$(MTCA_5U_PCIID5)")
iocshLoad("$(TOP)/iocsh/img.iocsh", "DEV=EVR6, EVR='', PCIID=$(MTCA_5U_PCIID6)")
iocshLoad("$(TOP)/iocsh/img.iocsh", "DEV=EVR7, EVR='', PCIID=$(MTCA_5U_PCIID7)")

# EOF
