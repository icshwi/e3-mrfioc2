# .cmd
# ====
epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

epicsEnvSet("LOCATION","MBL-070ROW:CNPW-U-017")

epicsEnvSet("IOC", "MTCA")

require mrfioc2, 2.2.0-rc5

iocshLoad("$(TOP)/iocsh/evm-mtca-init.iocsh", "IOC=$(IOC), AMC4=EVM4, AMC4_EN='', AMC5=EVM5, AMC5_EN='', AMC6=EVM6, AMC6_EN='', AMC7=EVM7, AMC7_EN='', AMC12=EVM12, AMC12_EN=''")

iocInit()

#EOF
