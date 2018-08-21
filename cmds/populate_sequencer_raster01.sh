# Bash script to configure the EVG/EVR sequencer
# All values in us

# Event code 14 (14 Hz), 127 is the end of sequence
caput -a RM01-PCIE:EVR1:SoftSeq0-EvtCode-SP 2 14 127

# Defining time at which the event codes are sent in us
caput -a RM01-PCIE:EVR1:SoftSeq0-Timestamp-SP 2 0 1

# Commit the sequence to HW
caput RM01-PCIE:EVR1:SoftSeq0-Commit-Cmd 1
