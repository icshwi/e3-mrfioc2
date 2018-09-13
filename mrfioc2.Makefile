#
#  Copyright (c) 2017 - Present  Jeong Han Lee
#  Copyright (c) 2017 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author  : Jeong Han Lee
# email   : han.lee@esss.se
# Date    : Thursday, September 13 19:06:31 CEST 2018
# version : 0.0.6
#

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include ${E3_REQUIRE_TOOLS}/driver.makefile

ifneq ($(strip $(DEVLIB2_DEP_VERSION)),)
devlib2_VERSION=$(DEVLIB2_DEP_VERSION)
endif



# *** ISSUES
# driver.makefile recursively read all include directories which were installed.
# The only way to exclude header files is....



iocStats_VERSION=
autosave_VERSION=
asyn_VERSION=
busy_VERSION=
modbus_VERSION=
ipmiComm_VERSION=
sequencer_VERSION=
sscan_VERSION=

std_VERSION=
ip_VERSION=
calc_VERSION=
pcre_VERSION=
stream_VERSION=
s7plc_VERSION=
recsync_VERSION=

#devlib2_VERSION=
#mrfioc2_VERSION=

exprtk_VERSION=
motor_VERSION=
ecmc_VERSION=
ethercatmc_VERSION=
ecmctraining_VERSION=


keypress_VERSION=
sysfs_VERSION=
symbolname_VERSION=
memDisplay_VERSION=
regdev_VERSION=
i2cDev_VERSION=

tosca_VERSION=
tsclib_VERSION=
ifcdaqdrv2_VERSION=

## The main issue is nds3, it is mandatory to disable it
## 
nds3_VERSION=
nds3epics_VERSION=
ifc14edrv_VERSION=
ifcfastint_VERSION=


nds_VERSION=
loki_VERSION=
nds_VERSION=
sis8300drv_VERSION=
sis8300_VERSION=
sis8300llrfdrv_VERSION=
sis8300llrf_VERSION=


ADSupport_VERSION=
ADCore_VERSION=
ADSimDetector_VERSION=
ADAndor_VERSION=
ADAndor3_VERSION=
ADPointGrey_VERSION=
ADProsilica_VERSION=

amcpico8_VERSION=
adpico8_VERSION=
adsis8300_VERSION=
adsis8300bcm_VERSION=
adsis8300bpm_VERSION=
adsis8300fc_VERSION=






# mrfioc2/configure/CONFIG_SITE
USR_CPPFLAGS += -DUSE_TYPED_RSET

# mrfCommon/Makefile 
USR_CFLAGS   += -DDEBUG_PRINT
USR_CPPFLAGS += -DDEBUG_PRINT


# COMMUNITY Dependency 
# mrfCommon (mrfioc2), mrmShared (mrfioc2), epicsvme (devlib2), epicspci (devlib2)
EVGMRMAPP:= evgMrmApp
EVGMRMAPPSRC:=$(EVGMRMAPP)/src
EVGMRMAPPDB:=$(EVGMRMAPP)/Db

SOURCES += $(EVGMRMAPPSRC)/evgInit.cpp
SOURCES += $(EVGMRMAPPSRC)/evg.cpp
SOURCES += $(EVGMRMAPPSRC)/evgMrm.cpp
SOURCES += $(EVGMRMAPPSRC)/evgAcTrig.cpp
SOURCES += $(EVGMRMAPPSRC)/evgEvtClk.cpp

SOURCES += $(EVGMRMAPPSRC)/evgTrigEvt.cpp
SOURCES += $(EVGMRMAPPSRC)/devSupport/devEvgTrigEvt.cpp

SOURCES += $(EVGMRMAPPSRC)/evgMxc.cpp

SOURCES += $(EVGMRMAPPSRC)/evgDbus.cpp
SOURCES += $(EVGMRMAPPSRC)/devSupport/devEvgDbus.cpp

SOURCES += $(EVGMRMAPPSRC)/evgInput.cpp

SOURCES += $(EVGMRMAPPSRC)/evgOutput.cpp

SOURCES += $(EVGMRMAPPSRC)/mrmevgseq.cpp

SOURCES += $(EVGMRMAPPSRC)/seqconst.c
SOURCES += $(EVGMRMAPPSRC)/seqnsls2.c

DBDS    += $(EVGMRMAPPSRC)/evgInit.dbd

HEADERS += $(EVGMRMAPPSRC)/evgMrm.h
HEADERS += $(EVGMRMAPPSRC)/evgRegMap.h
HEADERS += $(EVGMRMAPPSRC)/evgAcTrig.h
HEADERS += $(EVGMRMAPPSRC)/evgEvtClk.h
HEADERS += $(EVGMRMAPPSRC)/evgTrigEvt.h
HEADERS += $(EVGMRMAPPSRC)/evgMxc.h
HEADERS += $(EVGMRMAPPSRC)/evgDbus.h
HEADERS += $(EVGMRMAPPSRC)/evgInput.h
HEADERS += $(EVGMRMAPPSRC)/evgOutput.h
HEADERS += $(EVGMRMAPPSRC)/mrmevgseq.h



# COMMUNITY Dependency
# mrfCommon (mrfioc2), mrmShared (mrfioc2), evr (mrfioc2), epicsvme (devlib2), epicspci (devlib2)
EVRMRMAPP:= evrMrmApp
EVRMRMAPPSRC:=$(EVRMRMAPP)/src
EVRMRMAPPDB:=$(EVRMRMAPP)/Db


SOURCES += $(EVRMRMAPPSRC)/drvemIocsh.cpp
SOURCES += $(EVRMRMAPPSRC)/drvemSetup.cpp
SOURCES += $(EVRMRMAPPSRC)/drvem.cpp
SOURCES += $(EVRMRMAPPSRC)/drvemOutput.cpp
SOURCES += $(EVRMRMAPPSRC)/drvemInput.cpp
SOURCES += $(EVRMRMAPPSRC)/drvemPrescaler.cpp
SOURCES += $(EVRMRMAPPSRC)/drvemPulser.cpp
SOURCES += $(EVRMRMAPPSRC)/drvemCML.cpp
SOURCES += $(EVRMRMAPPSRC)/delayModule.cpp
SOURCES += $(EVRMRMAPPSRC)/drvemRxBuf.cpp
SOURCES += $(EVRMRMAPPSRC)/devMrmBuf.cpp
SOURCES += $(EVRMRMAPPSRC)/mrmevrseq.cpp
SOURCES += $(EVRMRMAPPSRC)/bufrxmgr.cpp
SOURCES += $(EVRMRMAPPSRC)/devMrmBufRx.cpp
SOURCES += $(EVRMRMAPPSRC)/os/default/irqHack.cpp
SOURCES += $(EVRMRMAPPSRC)/mrmGpio.cpp

DBDS    += $(EVRMRMAPPSRC)/drvemSupport.dbd





# # COMMUNITY Dependency

# mrfCommon
EVRAPP:= evrApp
EVRAPPSRC:=${EVRAPP}/src
EVRAPPDB:=${EVRAPP}/Db

HEADERS += $(EVRAPPSRC)/evr/pulser.h
HEADERS += $(EVRAPPSRC)/evr/output.h
HEADERS += $(EVRAPPSRC)/evr/delay.h
HEADERS += $(EVRAPPSRC)/evr/input.h
HEADERS += $(EVRAPPSRC)/evr/prescaler.h
HEADERS += $(EVRAPPSRC)/evr/evr.h
HEADERS += $(EVRAPPSRC)/evr/cml.h



DBDS    += $(EVRAPPSRC)/evrSupport.dbd


SOURCES += $(EVRAPPSRC)/evr.cpp
HEADERS += $(EVRAPPSRC)/evrGTIF.h
SOURCES += $(EVRAPPSRC)/evrGTIF.cpp
SOURCES += $(EVRAPPSRC)/devEvrStringIO.cpp
SOURCES += $(EVRAPPSRC)/devEvrEvent.cpp
SOURCES += $(EVRAPPSRC)/devEvrMapping.cpp
SOURCES += $(EVRAPPSRC)/devEvrPulserMapping.cpp
SOURCES += $(EVRAPPSRC)/asub.c
SOURCES += $(EVRAPPSRC)/devWfMailbox.c
SOURCES_Linux += $(EVRAPPSRC)/ntpShm.cpp
SOURCES_DEFAULT += $(EVRAPPSRC)/ntpShmNull.cpp






# COMMUNITY Dependency
# mrfCommon
MRMSHARED:= mrmShared
MRMSHAREDSRC:=${MRMSHARED}/src
MRMSHAREDDB:=${MRMSHARED}/Db


HEADERS += $(MRMSHAREDSRC)/mrmDataBufTx.h
HEADERS += $(MRMSHAREDSRC)/mrmSeq.h
HEADERS += $(MRMSHAREDSRC)/mrmpci.h
HEADERS += $(MRMSHAREDSRC)/sfp.h


SOURCES += $(MRMSHAREDSRC)/mrmDataBufTx.cpp
SOURCES += $(MRMSHAREDSRC)/mrmSeq.cpp
SOURCES += $(MRMSHAREDSRC)/devMrfBufTx.cpp
SOURCES += $(MRMSHAREDSRC)/sfp.cpp
SOURCES += $(MRMSHAREDSRC)/mrmtimesrc.cpp

# After 2.2.0, 2.2.0-ess-rc3,
# mrfioc2.Makefile needs to handel new file with the compatibility with
# old version up to 2.2.0-ess-rc2
mrmspi_src += $(MRMSHAREDSRC)/mrmspi.cpp
SOURCES += $(filter $(mrmspi_src), $(wildcard $(MRMSHAREDSRC)/*.cpp))

DBDS    += $(MRMSHAREDSRC)/mrmShared.dbd




MRFCOMMOM:= mrfCommon/src

HEADERS += $(MRFCOMMOM)/mrfBitOps.h
HEADERS += $(MRFCOMMOM)/mrfCommon.h
HEADERS += $(MRFCOMMOM)/mrfCommonIO.h
HEADERS += $(MRFCOMMOM)/mrfFracSynth.h
HEADERS += $(MRFCOMMOM)/linkoptions.h
HEADERS += $(MRFCOMMOM)/mrfcsr.h
HEADERS += $(MRFCOMMOM)/mrf/databuf.h
HEADERS += $(MRFCOMMOM)/mrf/object.h
HEADERS += $(MRFCOMMOM)/mrf/version.h
HEADERS += $(MRFCOMMOM)/devObj.h
HEADERS += $(MRFCOMMOM)/configurationInfo.h
HEADERS += $(MRFCOMMOM)/plx9030.h
HEADERS += $(MRFCOMMOM)/plx9056.h
HEADERS += $(MRFCOMMOM)/latticeEC30.h


DBDS    += $(MRFCOMMOM)/mrfCommon.dbd

SOURCES += $(MRFCOMMOM)/mrfFracSynth.c
SOURCES += $(MRFCOMMOM)/linkoptions.c
SOURCES += $(MRFCOMMOM)/object.cpp
SOURCES += $(MRFCOMMOM)/devObj.cpp
SOURCES += $(MRFCOMMOM)/devObjAnalog.cpp
SOURCES += $(MRFCOMMOM)/devObjLong.cpp
SOURCES += $(MRFCOMMOM)/devObjBinary.cpp
SOURCES += $(MRFCOMMOM)/devObjMBB.cpp
SOURCES += $(MRFCOMMOM)/devObjMBBDirect.cpp
SOURCES += $(MRFCOMMOM)/devObjString.cpp
SOURCES += $(MRFCOMMOM)/devObjCommand.cpp
SOURCES += $(MRFCOMMOM)/devObjWf.cpp
SOURCES += $(MRFCOMMOM)/devMbboDirectSoft.c
SOURCES += $(MRFCOMMOM)/devlutstring.cpp
SOURCES += $(MRFCOMMOM)/databuf.cpp
SOURCES += $(MRFCOMMOM)/mrfCommon.cpp
SOURCES += $(MRFCOMMOM)/spi.cpp
SOURCES += $(MRFCOMMOM)/flash.cpp

# After 2.2.0, 2.2.0-ess-rc3,
# mrfioc2.Makefile needs to handel new file with the compatibility with
# old version up to 2.2.0-ess-rc2
pollirq_src += $(MRFCOMMOM)/pollirq.cpp
SOURCES += $(filter $(pollirq_src), $(wildcard $(MRFCOMMOM)/*.cpp))

SOURCES += $(MRFCOMMOM)/flashiocsh.cpp



HEADERS += $(MRFCOMMOM)/mrf/version.h

flashiocsh$(DEP): version.h

version.h: 
	$(RM) $@
	$(PERL) -I$(EPICS_BASE)/lib/perl $(where_am_I)/$(MRFCOMMOM)/genVersionHeader.pl -t "" -V $(E3_MODULE_VERSION) -N MRF_VERSION $(where_am_I)/$(MRFCOMMOM)/mrf/$@




TEMPLATES += $(wildcard $(MRMSHAREDDB)/*.db)
TEMPLATES += $(wildcard $(EVRAPPDB)/*.db)
TEMPLATES += $(wildcard $(EVGMRMAPPDB)/*.db)
TEMPLATES += $(wildcard $(EVRMRMAPPDB)/*.db)

TEMPLATES += $(wildcard $(MRMSHAREDDB)/*.template)
TEMPLATES += $(wildcard $(EVRAPPDB)/*.template)
TEMPLATES += $(wildcard $(EVGMRMAPPDB)/*.template)
TEMPLATES += $(wildcard $(EVRMRMAPPDB)/*.template)

#TEMPLATES += $(wildcard $(MRMSHAREDDB)/*.substitutions)
#TEMPLATES += $(wildcard $(EVRAPPDB)/*.substitutions)
#TEMPLATES += $(wildcard $(EVGMRMAPPDB)/*.substitutions)
#TEMPLATES += $(wildcard $(EVRMRMAPPDB)/*.substitutions)


USR_DBFLAGS += -I . -I ..
USR_DBFLAGS += -I $(EPICS_BASE)/db
USR_DBFLAGS += -I $(MRMSHAREDDB)
USR_DBFLAGS += -I $(EVGMRMAPPDB)
USR_DBFLAGS += -I $(EVRMRMAPPDB)
USR_DBFLAGS += -I $(EVRAPPDB)


EVG_SUBS=$(wildcard $(EVGMRMAPPDB)/*.substitutions)
EVG_TMPS=$(wildcard $(EVGMRMAPPDB)/*.template)
EVR_SUBS=$(wildcard $(EVRMRMAPPDB)/*.substitutions)


db: $(EVG_SUBS) $(EVR_SUBS) $(EVG_TMPS)

$(EVG_SUBS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

$(EVG_TMPS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@


$(EVR_SUBS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@


.PHONY: db $(EVG_SUBS) $(EVR_SUBS) $(EVG_TMPS)


