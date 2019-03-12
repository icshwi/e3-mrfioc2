Automatic CPCI EVG / EVR Configuration Tools
===

A weird cpci system changes the pci address dymaically. In order to workaround, the following script was designed. 



## CPCI EVG 230

We assume that there is only **ONE** EVG in the system

```
require mrfioc2, 2.2.0-rc4

epicsEnvSet("TOP", "$(E3_CMD_TOP)")
epicsEnvSet("DEV1", "EVG-01")

system "bash $(TOP)/random_cpci.bash evg"
iocshLoad "$(TOP)/random_cpci_evg.cmd" "DEVICE=$(DEV1)"

iocInit
```

## CPCI EVR 230

We assume that there are more than one EVR in the system. The ```random_cpci.bash evr`` generates the configuration for all EVRs, which are installed in the system. Thus, please expand DEV variables according to the total number of EVRs. The following example has the assumption that we have 3 EVRs.

```
require mrfioc2, 2.2.0-rc4

epicsEnvSet("TOP", "$(E3_CMD_TOP)")
epicsEnvSet("DEV1", "EVR-01")
epicsEnvSet("DEV2", "EVR-02")
epicsEnvSet("DEV3", "EVR-03")

system "bash $(TOP)/random_cpci.bash evr"
iocshLoad "$(TOP)/random_cpci_evr.cmd" "DEVICE1=$(DEV1),DEVICE2=$(DEV2),DEVICE3=$(DEV3)"

iocInit
```

## Check generated files

If one uses the second argument v, it will print more information such as

```
$ bash random_cpci.bash evg v
 
In        /home/jhlee/e3-3.15.5/e3-mrfioc2/cmds/random_cpci_id_example/random_cpci_evg.in
Out       /home/jhlee/e3-3.15.5/e3-mrfioc2/cmds/random_cpci_id_example/random_cpci_evg.cmd
mrmEvgSetupPCI("$(DEVICE)", "00:16.0")
```
