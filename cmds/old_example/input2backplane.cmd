# This the full setup for the Timing System with E3.
#
#require require,2.5.4
#require devlib2,2.9.0
require mrfioc2,2.2.0
# require iocStats,1856ef5
# require autosave, 5.8.0


epicsEnvSet("ENGINEER","")
epicsEnvSet("LOCATION","")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "INPUT2BACK")
epicsEnvSet("DEV1", "EVR1")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvrSetupPCI("$(DEV1)",  "06:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")

# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000


# iocStats
# dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC):IocStats")



iocInit()


# dbl > "${IOC}_PVs.list"

# Get current time from system clock
dbpf $(IOC)-$(DEV1):TimeSrc-Sel "Sys. Clock"

# Set delay compensation to 70 ns, needed to avoid timesptamp issue
dbpf $(IOC)-$(DEV1):DC-Tgt-SP 70

# Set up the prescaler that will trigger the sequencer at 14 Hz
dbpf $(IOC)-$(DEV1):PS0-Div-SP 6289424 # in standalone mode because real freq from synthsiezer is 88.05194802 MHz, otherwise 6289464

# Set up the sequencer
dbpf $(IOC)-$(DEV1):SoftSeq0-RunMode-Sel "Normal"
dbpf $(IOC)-$(DEV1):SoftSeq0-TrigSrc-2-Sel "Prescaler 0"
dbpf $(IOC)-$(DEV1):SoftSeq0-TsResolution-Sel "uSec"
dbpf $(IOC)-$(DEV1):SoftSeq0-Load-Cmd 1
dbpf $(IOC)-$(DEV1):SoftSeq0-Enable-Cmd 1

system("/bin/sh ./configure_sequencer_14Hz.sh $(IOC) $(DEV1)")

# Set up of UnivIO 0 as Input. Generate Code 10 locally on rising edge.
#dbpf $(IOC)-$(DEV1):OutRB00-Src-SP 61
dbpf $(IOC)-$(DEV1):In0-Trig-Ext-Sel "Edge"
dbpf $(IOC)-$(DEV1):In0-Code-Ext-SP 10

# Trigger backplane trigger line X at 14 Hz
# dbpf $(IOC)-$(DEV1):DlyGen0-Evt-Trig0-SP $(MainEvtCODE)
# dbpf $(IOC)-$(DEV1):DlyGen0-Width-SP 1000 # time in us, as
# selected with $(IOC)-$(DEV1):SoftSeq0-TsResolution-Sel
# dbpf $(IOC)-$(DEV1):OutBackX-Src-SP 0 # trigger from delay generator 0
