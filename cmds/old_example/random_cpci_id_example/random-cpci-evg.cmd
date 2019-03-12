

require mrfioc2, 2.2.0-rc4

epicsEnvSet("TOP", "$(E3_CMD_TOP)")
epicsEnvSet("DEV1", "EVG-01")

system "bash $(TOP)/random_cpci.bash evg"
iocshLoad "$(TOP)/random_cpci_evg.cmd" "DEVICE=$(DEV1)"

iocInit
