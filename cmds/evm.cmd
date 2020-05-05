# .cmd
require "mrfioc2" "2.2.1rc1"

# Load environment
iocshLoad "$(mrfioc2_DIR)/mtca.iocsh"
iocshLoad "$(mrfioc2_DIR)/ts.iocsh"

## Load record instances
iocshLoad "$(mrfioc2_DIR)/evm.iocsh" "P=TD-TEST, OBJ=EVM, PCIID=$(MTCA_5U_PCIID6), U=:EVRU-, D=:EVRD-"

iocInit

# EOF
