

require mrfioc2, 2.2.0-rc4

epicsEnvSet("TOP", "$(E3_CMD_TOP)")
epicsEnvSet("DEV1", "EVR-01")
epicsEnvSet("DEV2", "EVR-02")
epicsEnvSet("DEV3", "EVR-03")

system "bash $(TOP)/random_cpci.bash evr"
iocshLoad "$(TOP)/random_cpci_evr.cmd" "DEVICE1=$(DEV1),DEVICE2=$(DEV2),DEVICE3=$(DEV3)"

iocInit
