# .cmd
require "mrfioc2" "2.2.1rc1"

epicsEnvSet "TOP" "$(E3_CMD_TOP)/../.."
epicsEnvSet "PEVG" "MTCA5U-EVG"

#epicsEnvSet "EVT_PMORTEM" "66"

# Load environment
iocshLoad "$(TOP)/iocsh/mtca.iocsh"
#iocshLoad "$(TOP)/iocsh/ts.iocsh"

## Load record instances
iocshLoad "$(TOP)/iocsh/evm.iocsh" "P=$(PEVG), OBJ=EVG, PCIID=$(MTCA_5U_PCIID7)"

iocInit

iocshLoad "$(TOP)/iocsh/evgr.iocsh"               "P=$(PEVG), INTRF=, INTPPS="
iocshLoad "$(TOP)/iocsh/evgasynr.iocsh"           "P=$(PEVG), EVT_PMORTEM=$(EVT_PMORTEM=40), EVT_PMORTEMI=$(EVT_PMORTEMI=41), EVT_DOD=$(EVT_DOD=42), EVT_DODI=$(EVT_DODI=43)"

# EOF



