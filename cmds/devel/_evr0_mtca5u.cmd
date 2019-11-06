# .cmd
# ====

epicsEnvSet("TOP", "$(E3_CMD_TOP)/../..")
iocshLoad("$(TOP)/iocsh/env-init.iocsh")
epicsEnvSet("EPICS_DB_INCLUDE_PATH", "$(TOP)/template")

epicsEnvSet("LOCATION","MTCA:AMC2")
epicsEnvSet("IOC", "MTCA5U")
epicsEnvSet("DEV", "EVR")

require mrfioc2, 2.2.0-rc7

# mTCA-XU
iocshLoad("$(TOP)/iocsh/evr-mtca-init.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=$(MTCA_5U_PCIID2)")
# iocshLoad("$(TOP)/iocsh/evr-mtca-300.iocsh", "S=$(IOC), DEV=$(DEV), PCIID=0e:00.0, RT=wtRT")
# dbLoadRecords("evrevent.db","EN=$(IOC)-$(DEV):Evt18, OBJ=$(DEV), CODE=18, EVNT=18")
# dbLoadRecords("evr-databuffer.db","SYS=$(IOC), D=$(DEV)")
# dbLoadTemplate("$(TOP)/template/evr-databuffer-ess.substitutions", "PREFIX=$(IOC)-$(DEV):")
# dbLoadRecords("evr-databuffer-ess.db", "PREFIX=$(IOC)-$(DEV):")

iocInit()

iocshLoad("$(TOP)/iocsh/evr-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")
iocshLoad("$(TOP)/iocsh/evr-mtca-tclk-run.iocsh", "IOC=$(IOC), DEV=$(DEV)")

dbl > "${IOC}-${DEV}_PVs.list"

#EOF
