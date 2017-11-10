require devlib2, 2.9.0
require mrfioc2, 0.0.0
require iocStats, 1856ef5
require autosave, 5.8.0

epicsEnvSet("ENGINEER","hanlee x3409")
epicsEnvSet("LOCATION","ICS Tuna Lab")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("AUTOSAVE", "/home/timinguser/autosave")

epicsEnvSet("IOC", "FREIA-CPCI:EVG0")

epicsEnvSet("DEVICE" "EVG0")

mrmEvgSetupPCI("DEVICE", "10:e.0")

dbLoadRecords("cpci-evg230-ess.db", "SYS=TST, D=evg0, DEVICE=DEVICE")

iocInit()

dbl > "${IOC}_PVs.list"


dbpf("TST-evg0:Mxc0-Prescaler-SP" "12491350")
## Frequency should be 1Hz
dbpr("TST-evg0:Mxc0-Frequency-RB",1)
dbpf("TST-evg0:TrigEvt1-EvtCode-SP","122")
dbpf("TST-evg0:TrigEvt1-TrigSrc-Sel","Mxc0")
