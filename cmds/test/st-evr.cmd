# .cmd
require "mrfioc2" "2.2.1rc1"

epicsEnvSet "TOP" "$(E3_CMD_TOP)/../.."

epicsEnvSet "FILE_DB" "evr-mtca-300u-ess.db"
epicsEnvSet "PEVR" "MTCA5U-EVR"

# Load ioc system environment
# During the deployment, taken from the inventory.
iocshLoad "$(TOP)/iocsh/mtca.iocsh"
# It went to the inventory
#iocshLoad "$(TOP)/iocsh/ts.iocsh"

## Load record instances
iocshLoad "$(TOP)/iocsh/evr.iocsh" "P=$(PEVR), PCIID=$(MTCA_5U_PCIID2), FILE_DB=$(FILE_DB)"

iocInit

iocshLoad "$(TOP)/iocsh/evrr.iocsh"         "P=$(PEVR)"
iocshLoad "$(TOP)/iocsh/evrtclkr.iocsh"     "P=$(PEVR)"
iocshLoad "$(TOP)/iocsh/evroutr.iocsh"      "P=$(PEVR), $(OUTARGS='')"
iocshLoad "$(TOP)/iocsh/evrinr.iocsh"       "P=$(PEVR), $(INARGS='')"
#iocshLoad "$(TOP)/iocsh/evrinr.iocsh"      "P=$(PEVR), BPIN5='', EVT5=$(EVT_PMORTEMI=1), BPIN7='', EVT7=$(EVT_DODI=2)"

# EOF
