### Bash script to configure the EVG/EVR sequencer
### All values in us, as configured with $1-$2:SoftSeq0-TsResolution-Sel
### Set up the sequence content, events and timestamps
### Event 127 is always needed at the end, it is the end-of-sequence event and stops the sequencer
### The first event in the its list is sent with the first delay in its list, the second event after the second delay (the start of time is always the moment when the sequencer is triggered) and so on
### The timestamps should be monotonically increasing

# Event code 14 (14 Hz), 127 is the end of sequence 
# caput -a $1-$2:SoftSeq0-EvtCode-SP 2 14 127
caput -a $1-$2:SoftSeq0-EvtCode-SP 2 14 127

# Defining time at which the event codes are sent in us (timestamps), as configured with $1-$2: SoftSeq0-TsResolution-Sel
caput -a $1-$2:SoftSeq0-Timestamp-SP 2 0 1

# Commit the sequence to HW
caput $1-$2:SoftSeq0-Commit-Cmd 1
