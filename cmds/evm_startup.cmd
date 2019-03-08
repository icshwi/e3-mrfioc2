require mrfioc2, 2.2.0-rc5

epicsEnvSet("IOC", "MTCAMASTER")
epicsEnvSet("DEV1", "EVMM")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvgSetupPCI($(DEV1), "06:00.0")
dbLoadRecords("evm-mtca-300-ess.db",  "SYS=$(IOC), D=$(DEV1), EVG=$(DEV1), FEVT=$(ESSEvtClockRate), FRF=$(ESSEvtClockRate), FDIV=1")


iocInit()

############### Configure RF input ##########
dbpf $(IOC)-$(DEV1):EvtClk-Source-Sel "RF (Ext)"
dbpf $(IOC)-$(DEV1):EvtClk-RFFreq-SP 88.0525
dbpf $(IOC)-$(DEV1):EvtClk-RFDiv-SP 1
############### Configure RF input ##########

#dbpf "$(IOC)-$(DEV1):1ppsInp-Sel" "Sys Clk"

############## Configure front panel for evr 125 1 Hz ##############
dbpf $(IOC)-$(DEV1):TrigEvt1-EvtCode-SP 125
dbpf $(IOC)-$(DEV1):TrigEvt1-TrigSrc-Sel "Front0"
dbpf $(IOC)-$(DEV1):1ppsInp-Sel "Front0"
dbpf $(IOC)-$(DEV1):1ppsInp-MbbiDir_.TPRO 1
############## Configure front panel for evr 125 1 Hz ##############

# Set EVM as master
dbpf $(IOC)-$(DEV1):Enable-Sel "Ena Master"

### Set up the sequencer ###
dbpf $(IOC)-$(DEV1):SoftSeq0-RunMode-Sel "Normal"
dbpf $(IOC)-$(DEV1):SoftSeq0-TrigSrc-Sel "Mxc0"
dbpf $(IOC)-$(DEV1):SoftSeq0-TsResolution-Sel "uSec"
dbpf $(IOC)-$(DEV1):SoftSeq0-Load-Cmd 1
dbpf $(IOC)-$(DEV1):SoftSeq0-Enable-Cmd 1

# Master Event Rate 14 Hz
dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 6289464
#dbpf $(IOC)-$(DEV1):TrigEvt0-EvtCode-SP $(MainEvtCODE)
#dbpf $(IOC)-$(DEV1):TrigEvt0-TrigSrc-Sel "Mxc0"
system("/bin/sh ./configure_sequencer_14Hz.sh $(IOC) $(DEV1)")

# Heart Beat 1 Hz
dbpf $(IOC)-$(DEV1):Mxc7-Prescaler-SP 88052500
dbpf $(IOC)-$(DEV1):TrigEvt7-EvtCode-SP $(HeartBeatEvtCODE)
dbpf $(IOC)-$(DEV1):TrigEvt7-TrigSrc-Sel "Mxc7"

# Is there something similar to sleep(5)????
epicsThreadSleep 5
dbpf $(IOC)-$(DEV1):SyncTimestamp-Cmd 1

