# .cmd
# ====
epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")

epicsEnvSet("LOCATION","MBL-070ROW:CNPW-U-017")

epicsEnvSet("IOC", "MTCA")

require mrfioc2, 2.2.0-rc5

iocshLoad("$(TOP)/iocsh/evm-mtca-init.iocsh","IOC=$(IOC),AMC2=EVM2,AMC2_EN='',AMC3=EVM3,AMC3_EN='',AMC4=EVM4,AMC4_EN='',AMC5=EVM5,AMC5_EN='',AMC6=EVM6,AMC6_EN='',AMC8=EVM8,AMC8_EN='',AMC9=EVM9,AMC9_EN='',AMC10=EVM10,AMC10_EN='',AMC11=EVM11,AMC11_EN='',AMC12=EVM12,AMC12_EN=''")

iocInit()

#EOF
