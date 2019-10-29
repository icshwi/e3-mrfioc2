# .cmd
# ====
epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")


# Select the software release
require mrfioc2, 2.2.0-rc6

# pcidiagset 8 0 0
# pciread 32 0x4000 0x1000
# pciwrite 32 0x40e0 0x90000000


#EOF
