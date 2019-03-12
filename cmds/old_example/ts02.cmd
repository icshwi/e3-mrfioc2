require mrfioc2, 2.2.0-rc4

epicsEnvSet("IOC", "TS02")
epicsEnvSet("DEV1", "EVM-M")
epicsEnvSet("DEV4", "EVM-FO")
epicsEnvSet("DEV2", "EVR1")
epicsEnvSet("DEV3", "EVR2")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvgSetupPCI($(DEV1), "06:00.0")
dbLoadRecords("evg-mtca-300-ess.db",  "SYS=$(IOC), D=$(DEV1), EVG=$(DEV1), FEVT=$(ESSEvtClockRate), FRF=$(ESSEvtClockRate), FDIV=1")
mrmEvgSetupPCI($(DEV4), "08:00.0")
dbLoadRecords("evg-mtca-300-ess.db",  "SYS=$(IOC), D=$(DEV4), EVG=$(DEV4), FEVT=$(ESSEvtClockRate)")

### Register the EVR with the IOC and load the database ###
mrmEvrSetupPCI("$(DEV2)",  "09:00.0")
dbLoadRecords("evr-mtca-300-ess.db","EVR=$(DEV2), SYS=$(IOC), D=$(DEV2), FEVT=$(ESSEvtClockRate)")
mrmEvrSetupPCI("$(DEV3)",  "0b:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV3), SYS=$(IOC), D=$(DEV3), FEVT=$(ESSEvtClockRate)")

### Needed with software timestamp source w/o RT thread scheduling ###
var evrMrmTimeNSOverflowThreshold 100000


iocInit()

### Configure fan-out
dbpf $(IOC)-$(DEV4):EvtClk-Source-Sel "Upstream (fanout)"

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

# EVR configuration
dbpf $(IOC)-$(DEV2):DC-Ena-Sel "Enable"
dbpf $(IOC)-$(DEV2):DC-Tgt-SP 5600
dbpf $(IOC)-$(DEV2):Time-Clock-SP $(ESSEvtClockRate)
# dbpf $(IOC)-$(DEV2):DlyGen0-Width-SP 10000
dbpf $(IOC)-$(DEV2):DlyGen0-Evt-Trig0-SP $(MainEvtCODE)
# dbpf $(IOC)-$(DEV2):OutFPUV0-Src-Pulse-SP "Pulser 0"
dbpf $(IOC)-$(DEV3):DC-Ena-Sel "Enable"
dbpf $(IOC)-$(DEV3):DC-Tgt-SP 5600
dbpf $(IOC)-$(DEV3):Time-Clock-SP $(ESSEvtClockRate)
# dbpf $(IOC)-$(DEV3):DlyGen0-Width-SP 10000
dbpf $(IOC)-$(DEV3):DlyGen0-Evt-Trig0-SP $(MainEvtCODE)
# dbpf $(IOC)-$(DEV3):OutFPUV0-Src-Pulse-SP "Pulser 0"

# Is there something similar to sleep(5)????
dbpf $(IOC)-$(DEV1):SyncTimestamp-Cmd 1
