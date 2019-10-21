require mrfioc2,2.2.0-rc7
require iocStats,3.1.16
require autosave,5.10.0

epicsEnvSet("ENGINEER","Han")
epicsEnvSet("LOCATION","BI Lab")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")


epicsEnvSet("IOC", "BEAMMODES")
epicsEnvSet("DEV1", "EVG0")
epicsEnvSet("IOCNAME", "$(IOC):$(DEV1)")
epicsEnvSet("AS_TARGET", "/opt/iocs/autosave")


iocshLoad("$(autosave_DIR)/autosave.iocsh", "AS_TOP=$(AS_TARGET),IOCNAME=$(IOCNAME)")
iocshLoad("$(iocStats_DIR)/iocStats.iocsh", "IOCNAME=$(IOCNAME)")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate" "88.0525")

mrmEvgSetupPCI($(DEV1), "01:0d.0")

dbLoadRecords("evg-cpci-230-ess.db", "SYS=$(IOC), D=$(DEV1), EVG=$(DEV1), FRF=$(ESSEvtClockRate), FDIV=1, FEVT=$(ESSEvtClockRate)")


iocInit()


dbpf "$(IOC)-$(DEV1):1ppsInp-Sel" "Sys Clk"

############## Master Event Rate 14 Hz ##############
#dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 44026248 #

dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 6289464 
#dbpf $(IOC)-$(DEV1):TrigEvt0-EvtCode-SP $(MainEvtCODE)
#dbpf $(IOC)-$(DEV1):TrigEvt0-TrigSrc-Sel "Mxc0"
# Setup of sequencer
dbpf $(IOC)-$(DEV1):SoftSeq0-RunMode-Sel "Normal"
dbpf $(IOC)-$(DEV1):SoftSeq0-TrigSrc-Sel "Mxc0"
dbpf $(IOC)-$(DEV1):SoftSeq0-TsResolution-Sel "uSec"
dbpf $(IOC)-$(DEV1):SoftSeq0-Load-Cmd 1
dbpf $(IOC)-$(DEV1):SoftSeq0-Enable-Cmd 1


# Load the sequence
system("/bin/bash $(mrfioc2_DIR)configure_sequencer_14Hz.bash $(IOC) $(DEV1)")
############## Master Event Rate 14 Hz ##############

# Heart Beat 1 Hz
dbpf $(IOC)-$(DEV1):Mxc7-Prescaler-SP 88052500
dbpf $(IOC)-$(DEV1):TrigEvt7-EvtCode-SP $(HeartBeatEvtCODE)
dbpf $(IOC)-$(DEV1):TrigEvt7-TrigSrc-Sel "Mxc7"

epicsThreadSleep 5
dbpf $(IOC)-$(DEV1):SyncTimestamp-Cmd 1
#dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 44026248


#epicsThreadSleep 10
#dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 6289464

#epicsThreadSleep 10
#dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 12578928

#epicsThreadSleep 10
#dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 44026248


#dbl > "${IOC}_PVs.list"


