
require mrfioc2,2.2.0-rc5

epicsEnvSet("DEV1", "EVR1")

mrmEvrSetupPCI("$(DEV1)", "03:00.0")

iocInit()

