# This the full setup for the Timing System with E3.
#

require devlib2, 2.9.0
require mrfioc2, 2.2.0
require iocStats, 1856ef5
#require autosave, 5.8.0

epicsEnvSet("ENGINEER","hanlee x3409")
epicsEnvSet("LOCATION","Rack 1 at ICS Tuna Lab")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "TS01-CPCI")
epicsEnvSet("DEV1", "EVG0")
epicsEnvSet("DEV2", "EVR0")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

#epicsEnvSet("BeaconEvt"  "126")
#epicsEnvSet("1KHzFreq"  "88000")

mrmEvgSetupPCI($(DEV1), "16:0e.0")
mrmEvrSetupPCI($(DEV2),  "16:09.0")
dbLoadRecords("cpci-evg230-ess.db",  "SYS=$(IOC), D=$(DEV1), EVG=$(DEV1), FEVT=$(ESSEvtClockRate), FRF=$(ESSEvtClockRate), FDIV=1")
dbLoadRecords("evr-cpci-230.db","SYS=$(IOC), D=$(DEV2), EVR=$(DEV2),  FEVT=$(ESSEvtClockRate)")

# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000

# mrmEvrLoopback($(DEV2),1,0)

# iocStats
dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC)-IocStats")


# Auto save/restore

# Directory should be existent before IOC runing
#epicsEnvSet("AUTOSAVE", "/home/timinguser/autosave")

#var save_restoreDebug 1

#dbLoadRecords("save_restoreStatus.db", "P=$(IOC):Autosave")
#save_restoreSet_status_prefix("$(IOC):Autosave")
#set_savefile_path("${AUTOSAVE}")
#set_requestfile_path("${AUTOSAVE}")
#set_pass0_restoreFile("mrf_settings.sav")
#set_pass0_restoreFile("mrf_values.sav")
#set_pass1_restoreFile("mrf_values.sav")
#set_pass1_restoreFile("mrf_waveforms.sav")


iocInit()


dbl > "${IOC}_PVs.list"


#makeAutosaveFileFromDbInfo("${AUTOSAVE}/mrf_settings.req",  "autosaveFields_pass0")
#makeAutosaveFileFromDbInfo("${AUTOSAVE}/mrf_values.req",    "autosaveFields")
#makeAutosaveFileFromDbInfo("${AUTOSAVE}/mrf_waveforms.req", "autosaveFields_pass1")

#create_monitor_set("mrf_settings.req",   5 , "")
#create_monitor_set("mrf_values.req",     5 , "")
#create_monitor_set("mrf_waveforms.req", 30 , "")


dbpf "$(IOC)-$(DEV1):1ppsInp-Sel" "Sys Clk"

############### Configure RF input ##########
dbpf $(IOC)-$(DEV1):EvtClk-Source-Sel "RF"
dbpf $(IOC)-$(DEV1):EvtClk-RFFreq-SP 88.0525
dbpf $(IOC)-$(DEV1):EvtClk-RFDiv-SP 1
############### Configure RF input ##########

############## Configure front panel for evr 125 1 Hz ##############
dbpf $(IOC)-$(DEV1):TrigEvt1-EvtCode-SP 125
dbpf $(IOC)-$(DEV1):TrigEvt1-TrigSrc-Sel "Univ0"
dbpf $(IOC)-$(DEV1):1ppsInp-Sel "Univ0"
dbpf $(IOC)-$(DEV1):1ppsInp-MbbiDir_.TPRO 1
############## Configure front panel for evr 125 1 Hz ##############

# # Master Event Rate 14 Hz
dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 6289464
dbpf $(IOC)-$(DEV1):TrigEvt0-EvtCode-SP $(MainEvtCODE)
dbpf $(IOC)-$(DEV1):TrigEvt0-TrigSrc-Sel "Mxc0"

# # Heart Beat 1 Hz
dbpf $(IOC)-$(DEV1):Mxc7-Prescaler-SP 88052500
dbpf $(IOC)-$(DEV1):TrigEvt7-EvtCode-SP $(HeartBeatEvtCODE)
dbpf $(IOC)-$(DEV1):TrigEvt7-TrigSrc-Sel "Mxc7"

# # Beacon event 0x7e for EVM as fanout
#dbpf $(IOC)-$(DEV1):Mxc6-Prescaler-SP $(1KHzFreq)
#dbpf $(IOC)-$(DEV1):TrigEvt6-EvtCode-SP $(BeaconEvt)
#dbpf $(IOC)-$(DEV1):TrigEvt6-TrigSrc-Sel "Mxc6"

# # EVR configuration
# dbpf $(IOC)-$(DEV2):DlyGen0-Width-SP 10000
# dbpf $(IOC)-$(DEV2):DlyGen0-Evt-Trig0-SP $(MainEvtCODE)
# dbpf $(IOC)-$(DEV2):OutFPUV0-Src-Pulse-SP "Pulser 0"

# Is there something similar to sleep(5)????
dbpf $(IOC)-$(DEV1):SyncTimestamp-Cmd 1


