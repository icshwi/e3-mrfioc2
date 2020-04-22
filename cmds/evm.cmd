# .cmd
require "mrfioc2" "2.2.1rc1"

# Load environment
iocshLoad "$(mrfioc2_DIR)/mtca.iocsh"
iocshLoad "$(mrfioc2_DIR)/ts.iocsh"

## Load record instances
iocshLoad "$(mrfioc2_DIR)/evm.iocsh" "P=MTCA-EVM, OBJ=EVM, PCIID=$(MTCA_3U_PCIID3), U=:EVRU-, D=:EVRD-"

iocInit

# EOF
