# This the full setup for the Timing System with E3.
#
#require require,2.5.4
#require devlib2,2.9.0
require mrfioc2,2.2.0-rc1
# require iocStats,1856ef5
# require autosave, 5.8.0


epicsEnvSet("ENGINEER","")
epicsEnvSet("LOCATION","")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "TESTIOC")
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
dbpf $(IOC)-$(DEV1):TimeSrc-Sel 2

# Set up the prescaler that will trigger the sequencer at 14 Hz
dbpf $(IOC)-$(DEV1):PS0-Div-SP 6289424 # in standalone mode because real freq from synthsiezer is
# 88.05194802 MHz, otherwise 6289464

# Set up the sequencer
dbpf $(IOC)-$(DEV1):SoftSeq0-RunMode-Sel 0 # normal mode
dbpf $(IOC)-$(DEV1):SoftSeq0-TrigSrc-2-Sel 2 # prescaler 0
dbpf $(IOC)-$(DEV1):SoftSeq0-TsResolution-Sel 2 # us
dbpf $(IOC)-$(DEV1):SoftSeq0-Load-Cmd 1
dbpf $(IOC)-$(DEV1):SoftSeq0-Enable-Cmd 1

# Trigger backplane trigger line X at 14 Hz
# dbpf $(IOC)-$(DEV1):DlyGen0-Evt-Trig0-SP $(MainEvtCODE)
# dbpf $(IOC)-$(DEV1):DlyGen0-Width-SP 1000 # time in us, as
# selected with $(IOC)-$(DEV1):SoftSeq0-TsResolution-Sel
# dbpf $(IOC)-$(DEV1):OutBackX-Src-SP 0 # trigger from delay generator 0

# Send event clock over backplane clock line TCLKB, MCH should be configured to send the clock back
# to the AMCs over TCLKA
# dbpf $(IOC)-$(DEV1):OutTCLKB-Src-SP 63
# dbpf $(IOC)-$(DEV1):OutTCLKB-Ena-Sel 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pwr-Sel 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.BF 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.BE 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.BD 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.BC 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.BB 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.BA 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B9 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B8 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B7 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B6 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B5 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B4 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B3 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B2 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B1 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low00_15-SP.B0 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low16_31-SP.BF 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low16_31-SP.BE 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low16_31-SP.BD 1
# dbpf $(IOC)-$(DEV1):OutTCLKB-Pat-Low16_31-SP.BC 1

system("/bin/sh ./configure_sequencer_14Hz.sh $(IOC) $(DEV1)")

