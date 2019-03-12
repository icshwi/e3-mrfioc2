# This the full setup for the Timing System with E3.
# 
#require require,2.5.4
require devlib2,2.9.0
require mrfioc2,2.2.0
require iocStats,1856ef5


epicsEnvSet("ENGINEER","Han")
epicsEnvSet("LOCATION","Table at ICS Tuna Lab")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "RM01-PCIE")
epicsEnvSet("DEV1", "EVR1")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvrSetupPCI("$(DEV1)",  "01:00.0")
dbLoadRecords("evr-pcie-300dc-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")

# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000


# iocStats
dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC)-IocStats")



iocInit()

dbl > "${IOC}_PVs.list"

dbpf $(IOC)-$(DEV1):Ena-Sel 1

# Get current time from system clock
dbpf $(IOC)-$(DEV1):TimeSrc-Sel "Sys. Clock"

# Set delay compensation to 70 ns, needed to avoid timesptamp issue
dbpf $(IOC)-$(DEV1):DC-Tgt-SP 70

# Set up the prescaler that will trigger the sequencer at 14 Hz
dbpf $(IOC)-$(DEV1):PS0-Div-SP 6289464

# Set up the sequencer
dbpf $(IOC)-$(DEV1):SoftSeq0-RunMode-Sel "Normal"
dbpf $(IOC)-$(DEV1):SoftSeq0-TrigSrc-2-Sel "Prescaler 0"
dbpf $(IOC)-$(DEV1):SoftSeq0-TsResolution-Sel "uSec"
dbpf $(IOC)-$(DEV1):SoftSeq0-Load-Cmd 1
dbpf $(IOC)-$(DEV1):SoftSeq0-Enable-Cmd 1
# Remember to run the script that populates the sequencer!

# Set up the output
dbpf $(IOC)-$(DEV1):DlyGen0-Evt-Trig0-SP $(MainEvtCODE)
dbpf $(IOC)-$(DEV1):DlyGen0-Width-SP 1000 # Time in us
dbpf $(IOC)-$(DEV1):OutRB08-Src-SP 0 # Delay generator 0

dbpf $(IOC)-$(DEV1):OutRB09-Src-SP 41 # Prescaler 1
dbpf $(IOC)-$(DEV1):PS1-Div-SP 10000000

pcidiagset 1 0 0 
#pciread 32 0x50 100
#pciwrite 32 0x50 42000200

