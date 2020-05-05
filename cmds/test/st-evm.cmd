# .cmd
require "mrfioc2" "2.2.1rc1"

epicsEnvSet "TOP" "$(E3_CMD_TOP)/../.."
epicsEnvSet "PEVM" "MTCA5U-EVM"

# Load environment
iocshLoad "$(TOP)/iocsh/mtca.iocsh"
#iocshLoad "$(TOP)/iocsh/ts.iocsh"

## Load record instances
iocshLoad "$(TOP)/iocsh/evm.iocsh" "P=$(PEVM), OBJ=EVM, PCIID=$(MTCA_5U_PCIID6)"

iocInit

# EOF
