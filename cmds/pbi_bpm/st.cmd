require mrfioc2,2.2.1rc1

errlogInit(20000)

epicsEnvSet("CONTROL_GROUP",                "LAB-BPM20")
epicsEnvSet("AMC_DEVICE",                   "0f:00.0")
epicsEnvSet("AMC_NAME",                     "TS-EVR-000")
epicsEnvSet("PREFIX",                       "$(CONTROL_GROUP):$(AMC_NAME):")
epicsEnvSet("EVENT_CLOCK"                   "88.0525")

#- load MTCA support
iocshLoad("$(mrfioc2_DIR)bpm_evr_mtca_300.iocsh", "P=$(PREFIX), R=, S=, DEV=$(AMC_NAME), PCIID=$(AMC_DEVICE)")

#- After init snippets

#- setup EVR clock
afterInit(iocshLoad("$(mrfioc2_DIR)bpm_evr_mtca_tclk.iocsh", "PREFIX=$(PREFIX)"))




#- setup EVR triggers for BPM system
afterInit(iocshLoad("$(mrfioc2_DIR)bpm_triggers_init.iocsh", "PREFIX=$(PREFIX)"))

###############################################################################
iocInit
###############################################################################

#- bugfix for EVR loosing the timestamp for 5 seconds every 7-8 hours
dbpf $(PREFIX)DC-Tgt-SP 70

#- enable the EVR
dbpf $(PREFIX)Ena-Sel "Enabled"

date
###############################################################################
