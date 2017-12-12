# This the full setup for the Timing System with E3.
# 

require devlib2, 2.9.0
require mrfioc2, fff9b47
require iocStats, 1856ef5
# require autosave, 5.8.0


epicsEnvSet("ENGINEER","William")
epicsEnvSet("LOCATION","Table at ICS Tuna Lab")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "Doppler01-PCIE")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvrSetupPCI("EVR",  "01:00.0")
#dbLoadRecords("evr-pcie-300dc-ess.db","SYS=$(IOC), D=evr:1")

# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000


# iocStats
dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC):IocStats")


# Auto save/restore

# Directory should be existent before IOC runing
# epicsEnvSet("AUTOSAVE", "/home/icssev/autosave")

# var save_restoreDebug 1

# dbLoadRecords("save_restoreStatus.db", "P=$(IOC):Autosave")
# save_restoreSet_status_prefix("$(IOC):Autosave")
# set_savefile_path("${AUTOSAVE}")
#set_requestfile_path("${AUTOSAVE}")
#set_pass0_restoreFile("mrf_settings.sav")
#-set_pass0_restoreFile("mrf_values.sav")
#-set_pass1_restoreFile("mrf_values.sav")
#-set_pass1_restoreFile("mrf_waveforms.sav")


iocInit()


dbl > "${IOC}_PVs.list"


#+makeAutosaveFileFromDbInfo("${AUTOSAVE}/mrf_settings.req",  "autosaveFields_pass0")
#+makeAutosaveFileFromDbInfo("${AUTOSAVE}/mrf_values.req",    "autosaveFields")
#+makeAutosaveFileFromDbInfo("${AUTOSAVE}/mrf_waveforms.req", "autosaveFields_pass1")

#+create_monitor_set("mrf_settings.req",   5 , "")
#create_monitor_set("mrf_values.req",     5 , "")
#create_monitor_set("mrf_waveforms.req", 30 , "")




#dbpf "$(IOC){evg:1}1ppsInp-Sel" "Sys Clk"

# Master Event Rate 14 Hz
#dbpf $(IOC){evg:1-Mxc:0}Prescaler-SP 6289464
#dbpf $(IOC){evg:1-TrigEvt:0}EvtCode-SP $(MainEvtCODE)
#dbpf $(IOC){evg:1-TrigEvt:0}TrigSrc-Sel "Mxc0"

# Heart Beat 1 Hz 
#dbpf $(IOC){evg:1-Mxc:7}Prescaler-SP 88052496
#dbpf $(IOC){evg:1-TrigEvt:7}EvtCode-SP $(HeartBeatEvtCODE)
#dbpf $(IOC){evg:1-TrigEvt:7}TrigSrc-Sel "Mxc7"


#dbpf $(IOC){evr:4-DlyGen:0}Width-SP 10000
#dbpf $(IOC){evr:4-DlyGen:0}Evt:Trig0-SP $(MainEvtCODE)
#dbpf $(IOC){evr:4-Out:FPUV0}Src:Pulse-SP "Pulser 0"


