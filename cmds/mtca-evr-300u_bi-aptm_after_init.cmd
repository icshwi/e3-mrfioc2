
#- iocshLoad "mtca-evr-300u.cmd" "UNIT=1, IOC=$(IOC), CMD_TOP=$(CMD_TOP)"
epicsEnvSet("_PORT_EVR", "EVR_$(UNIT):")
epicsEnvSet("_TOP",      "$(CMD_TOP)")

### Get current time from system clock ###
dbpf $(IOC)$(_PORT_EVR)TimeSrc-Sel 2

### Set up the prescaler that will trigger the sequencer at 14 Hz ###
dbpf $(IOC)$(_PORT_EVR)PS0-Div-SP 6289424 # in standalone mode because real freq from synthsiezer is 88.05194802 MHz, otherwise 6289464

### Set up the sequencer ###
dbpf $(IOC)$(_PORT_EVR)SoftSeq0-RunMode-Sel 0 # normal mode, rearm after finish
dbpf $(IOC)$(_PORT_EVR)SoftSeq0-TrigSrc-2-Sel 2 # trigger the sequence from prescaler 0
dbpf $(IOC)$(_PORT_EVR)SoftSeq0-TsResolution-Sel 2 # select us as the units of the timestamp array of the seuqncer
dbpf $(IOC)$(_PORT_EVR)SoftSeq0-Load-Cmd 1
dbpf $(IOC)$(_PORT_EVR)SoftSeq0-Enable-Cmd 1


### Run the script that configures the events and timestamp of the sequence ###
system("/bin/sh $(_TOP)/configure_sequencer_14Hz.sh $(IOC) $(_PORT_EVR)")



################ TRIGGER ALL BACKPLANE LINES ON INPUT ######################
### Trigger input on signal edge/level ###
dbpf $(IOC)$(_PORT_EVR)In0-Trig-Ext-Sel "Edge"
### Active Edge Rising/Falling ###
dbpf $(IOC)$(_PORT_EVR)In0-Edge-Sel "Active Rising"
### Active Level High/Low ###
#dbpf $(IOC)$(_PORT_EVR)In0-Lvl-Sel "Active High"
### Create event 10 when input is triggered ##
dbpf $(IOC)$(_PORT_EVR)In0-Code-Ext-SP 10
### Trigger delay generator 0 on input ###
dbpf $(IOC)$(_PORT_EVR)DlyGen0-Evt-Trig0-SP 10
### Set width of the trigger in us ###
dbpf $(IOC)$(_PORT_EVR)DlyGen0-Width-SP 1000
### Set delay of the trigger in us ###
dbpf $(IOC)$(_PORT_EVR)DlyGen0-Delay-SP 0
### Triger backplane lines in delay generator 0 ###
dbpf $(IOC)$(_PORT_EVR)OutBack0-Src-SP 0 # trigger from delay generator 0
dbpf $(IOC)$(_PORT_EVR)OutBack1-Src-SP 0
dbpf $(IOC)$(_PORT_EVR)OutBack2-Src-SP 0
dbpf $(IOC)$(_PORT_EVR)OutBack3-Src-SP 0
dbpf $(IOC)$(_PORT_EVR)OutBack4-Src-SP 0
dbpf $(IOC)$(_PORT_EVR)OutBack5-Src-SP 0
dbpf $(IOC)$(_PORT_EVR)OutBack6-Src-SP 0
dbpf $(IOC)$(_PORT_EVR)OutBack7-Src-SP 0

### Send event clock over backplane clock line TCLKB, MCH should be configured to send the clock back to the AMCs over TCLKA ###
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Src-SP 63
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Ena-Sel 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pwr-Sel 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.BF 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.BE 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.BD 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.BC 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.BB 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.BA 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B9 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B8 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B7 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B6 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B5 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B4 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B3 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B2 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B1 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low00_15-SP.B0 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low16_31-SP.BF 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low16_31-SP.BE 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low16_31-SP.BD 1
 dbpf $(IOC)$(_PORT_EVR)OutTCLKB-Pat-Low16_31-SP.BC 1
