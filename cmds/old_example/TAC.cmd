require mrfioc2, 2.2.0-rc5

epicsEnvSet("IOC", "TAC")
epicsEnvSet("DEV1", "EVM1")
epicsEnvSet("DEV2", "EVR1")
epicsEnvSet("DEV3", "EVR2")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvgSetupPCI($(DEV1), "07:00.0")
dbLoadRecords("evm-mtca-300-ess.db",  "SYS=$(IOC), D=$(DEV1), EVG=$(DEV1), FEVT=$(ESSEvtClockRate), FRF=$(ESSEvtClockRate), FDIV=1")

### Register the EVR with the IOC and load the database ###
mrmEvrSetupPCI("$(DEV2)",  "0a:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV2), SYS=$(IOC), D=$(DEV2), FEVT=$(ESSEvtClockRate)")
mrmEvrSetupPCI("$(DEV3)",  "09:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV3), SYS=$(IOC), D=$(DEV3), FEVT=$(ESSEvtClockRate)")

### Needed with software timestamp source w/o RT thread scheduling ###
var evrMrmTimeNSOverflowThreshold 100000

dbLoadRecords("/home/iocuser/javier/evr-databuffer.db","SYS=$(IOC), D=$(DEV2)")
dbLoadRecords("/home/iocuser/javier/evr-databuffer.db","SYS=$(IOC), D=$(DEV3)")


iocInit()

dbpf "$(IOC)-$(DEV1):1ppsInp-Sel" "Sys Clk"

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
system("/bin/sh /home/iocuser/e3/e3-mrfioc2/iocsh/configure_sequencer_14Hz.bash $(IOC) $(DEV1)")
#system("/bin/sh /home/iocuser/javier/configure_sequencer_prod.bash $(IOC) $(DEV1)")

# Heart Beat 1 Hz
dbpf $(IOC)-$(DEV1):Mxc7-Prescaler-SP 88052500
dbpf $(IOC)-$(DEV1):TrigEvt7-EvtCode-SP $(HeartBeatEvtCODE)
dbpf $(IOC)-$(DEV1):TrigEvt7-TrigSrc-Sel "Mxc7"

# EVR configuration
dbpf $(IOC)-$(DEV2):DC-Tgt-SP 70
dbpf $(IOC)-$(DEV2):Time-Clock-SP $(ESSEvtClockRate)
dbpf $(IOC)-$(DEV2):DlyGen0-Width-SP 10000
dbpf $(IOC)-$(DEV2):DlyGen0-Evt-Trig0-SP $(MainEvtCODE)
dbpf $(IOC)-$(DEV2):OutFP0-Src-SP 0
dbpf $(IOC)-$(DEV3):DC-Tgt-SP 70
dbpf $(IOC)-$(DEV3):Time-Clock-SP $(ESSEvtClockRate)
dbpf $(IOC)-$(DEV3):DlyGen0-Width-SP 10000
dbpf $(IOC)-$(DEV3):DlyGen0-Evt-Trig0-SP $(MainEvtCODE)
dbpf $(IOC)-$(DEV3):OutFP0-Src-SP 0

### Trigger backplane trigger line X at 14 Hz ###
#dbpf $(IOC)-$(DEV2):DlyGen3-Evt-Trig0-SP $(MainEvtCODE)
#dbpf $(IOC)-$(DEV2):DlyGen3-Width-SP 1000 # time in us
#dbpf $(IOC)-$(DEV2):OutBack0-Src-SP 0 # trigger from delay generator 0
#dbpf $(IOC)-$(DEV2):OutBack1-Src-SP 0 # trigger from delay generator 0
#dbpf $(IOC)-$(DEV2):OutBack2-Src-SP 0 # trigger from delay generator 0
#dbpf $(IOC)-$(DEV2):OutBack3-Src-SP 0 # trigger from delay generator 0
#dbpf $(IOC)-$(DEV2):OutBack4-Src-SP 0 # trigger from delay generator 0
#dbpf $(IOC)-$(DEV2):OutBack5-Src-SP 0 # trigger from delay generator 0
#dbpf $(IOC)-$(DEV2):OutBack6-Src-SP 0 # trigger from delay generator 0
#dbpf $(IOC)-$(DEV2):OutBack7-Src-SP 0 # trigger from delay generator 0

# Is there something similar to sleep(5)????
dbpf $(IOC)-$(DEV1):SyncTimestamp-Cmd 1


