require mrfioc2,2.2.0-rc5

epicsEnvSet("IOC", "EMMTCAEVR300")
epicsEnvSet("DEV1", "EVR1")
epicsEnvSet("ESSEvtClockRate", "88.0525")
mrmEvrSetupPCI("$(DEV1)", "08:00.0")
dbLoadRecords("evr-mtca-300u-ess.db","EVR=$(DEV1), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")

# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000

iocInit()

# Set delay compensation to 70 ns, needed to avoid timestamp issue 
dbpf $(IOC)-$(DEV1):DC-Tgt-SP 70

### EVR standalone mode
### Get current time from system clock, this will be used for the timestamps ###
dbpf $(IOC)-$(DEV1):TimeSrc-Sel "Sys. Clock"

### Set up the prescaler that will trigger the sequencer at 14 Hz ###

# The value of the prescaler is the integer which gives the expected frequency (14 Hz in this example) when the event frequency (88.0525 MHz for ESS) is divided by the integer: 88.0525 MHz / 6289464 = 14 Hz
dbpf $(IOC)-$(DEV1):PS0-Div-SP 6289464

### Set up the sequencer ###
# Set the runmode to normal, so that the sequencer re-arms after it finishes running
dbpf $(IOC)-$(DEV1):SoftSeq0-RunMode-Sel "Normal" 
# Set the trigger of the sequencer as prescaler 0
dbpf $(IOC)-$(DEV1):SoftSeq0-TrigSrc-2-Sel "Prescaler 0"

# Set the engineering units (microseconds) for the delay of the events in the sequence (sequence timestamps) used in configure_sequencer_14Hz.sh; more information below 
dbpf $(IOC)-$(DEV1):SoftSeq0-TsResolution-Sel "uSec"

# Attach the soft sequence to a specific hardware sequence 
dbpf $(IOC)-$(DEV1):SoftSeq0-Load-Cmd 1

# Enable the sequencer
dbpf $(IOC)-$(DEV1):SoftSeq0-Enable-Cmd 1

### Run the script that configures the events and timestamps of the sequence, more information below ###
system("/bin/sh ./configure_sequencer_14Hz.sh $(IOC) $(DEV1)")

# Forward events with EVR
pcidiagset 8 0 0
pciwrite 32 0x40e0 0x90000000
