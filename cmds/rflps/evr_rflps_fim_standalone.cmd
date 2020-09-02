require mrfioc2,2.2.1rc1

epicsEnvSet("ENGINEER","RafaelMontano")
epicsEnvSet("LOCATION","RFLPS_LAB")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("SECSUB", "LAB-010")
epicsEnvSet("DISDEVID", "RFS-EVR-001")
epicsEnvSet("PREFIX", "$(SECSUB):$(DISDEVID):")

# Not use in this script, but it is needed for the expansion.
epicsEnvSet("MainEvtCODE" "14")

#- EVR PCI address
epicsEnvSet("PCIID", "05:00.0")

iocshLoad("$(mrfioc2_DIR)/evr-mtca-300.iocsh", "P=$(PREFIX), S=, DEV=$(DISDEVID), PCIID=$(PCIID)")

iocInit()

# The following script should be called after iocInit()
iocshLoad("$(mrfioc2_DIR)/evr-standalone-mode.iocsh", "PREFIX=$(PREFIX)")

# Set up of UnivIO 0 as Input. Generate Code 10 locally on rising edge.
dbpf $(PREFIX)In0-Trig-Ext-Sel "Edge"
dbpf $(PREFIX)In0-Code-Ext-SP 10

# Set up of DelayGenerator 0 to be triggered by event 14 (evr-standalone-mode).
dbpf $(PREFIX)DlyGen0-Evt-Trig0-SP 14
dbpf $(PREFIX)DlyGen0-Width-SP 1000

# Set up of DelayGenerator 1 to be triggered by event 14 (evr-standalone-mode) with 6000us delay
dbpf $(PREFIX)DlyGen1-Evt-Trig0-SP 14
dbpf $(PREFIX)DlyGen1-Width-SP 1000
dbpf $(PREFIX)DlyGen1-Delay-SP 6000

# Set up of DelayGenerator 2 to be triggered by event 10 (FP input 0).
dbpf $(PREFIX)DlyGen2-Evt-Trig0-SP 10
dbpf $(PREFIX)DlyGen2-Width-SP 1000

#- MTCA EVR Front Panel trigger from DlyGen0 (14 Hz standalone)
dbpf $(PREFIX)OutFP0-Src-SP 0
dbpf $(PREFIX)OutFP1-Src-SP 0
dbpf $(PREFIX)OutFP2-Src-SP 0
dbpf $(PREFIX)OutFP3-Src-SP 0

#- Backplane triggers based on DelayGenerator 1 (delayed 14Hz)

#- MTCA EVR Backplane0, RX17 (0)
dbpf $(PREFIX)OutBack0-Src-SP 1

#- MTCA EVR Backplane1, TX17 (1)
dbpf $(PREFIX)OutBack1-Src-SP 1

#- MTCA EVR Backplane2, RX18 (2)
dbpf $(PREFIX)OutBack2-Src-SP 1

#- MTCA EVR Backplane3, TX18 (3)
dbpf $(PREFIX)OutBack3-Src-SP 1

#- MTCA EVR Backplane4, RX19 (4)
dbpf $(PREFIX)OutBack4-Src-SP 1

#- MTCA EVR Backplane5, TX19 (5)
dbpf $(PREFIX)OutBack5-Src-SP 1

#- MTCA EVR Backplane6, RX20 (6)
dbpf $(PREFIX)OutBack6-Src-SP 1

#- MTCA EVR Backplane7, TX20 (7)
dbpf $(PREFIX)OutBack7-Src-SP 1
