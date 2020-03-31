# .cmd
require "iocstats"
require "mrfioc2"

# Load environment
iocshLoad "$(mrfioc2_DIR)/mtca.iocsh"

## Load record instances
iocshLoad "$(mrfioc2_DIR)/evm.iocsh" "P=$(PEVM), OBJ=EVM,   PCIID=$(PCI_SLOT), U=:EVRU-, D=:EVRD-"

iocInit

# EOF
