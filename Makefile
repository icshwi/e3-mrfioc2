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
# Date    : Sunday, November  5 01:44:45 CET 2017
# version : 0.2.3
#

TOP:=$(CURDIR)


ifneq (,$(findstring dev,$(MAKECMDGOALS)))
include $(TOP)/configure/CONFIG_DEV
else
include $(TOP)/configure/CONFIG
endif


-include $(TOP)/$(E3_ENV_NAME)/$(E3_ENV_NAME)
-include $(TOP)/$(E3_ENV_NAME)/epics-community-env


ifndef VERBOSE
  QUIET := @
endif

ifdef DEBUG_SHELL
  SHELL = /bin/sh -x
endif


# Keep always the module up-to-date
define git_update =
git submodule deinit -f $@/
sed -i '/submodule/,$$d'  $(TOP)/.git/config
rm -rf $(TOP)/.git/modules/$@
git submodule init $@/
git submodule update --init --recursive $@/.
git submodule update --remote --merge $@/
endef



# Pass necessary driver.makefile variables through makefile options
#
M_OPTIONS := -C $(EPICS_MODULE_SRC_PATH)
M_OPTIONS += -f $(ESS_MODULE_MAKEFILE)
M_OPTIONS += LIBVERSION="$(LIBVERSION)"
M_OPTIONS += PROJECT="$(PROJECT)"
M_OPTIONS += EPICS_MODULES="$(EPICS_MODULES)"
M_OPTIONS += EPICS_LOCATION="$(EPICS_LOCATION)"
M_OPTIONS += DEFAULT_EPICS_VERSIONS="$(DEFAULT_EPICS_VERSIONS)"
M_OPTIONS += BUILDCLASSES="Linux"


# # help is defined in 
# # https://gist.github.com/rcmachado/af3db315e31383502660
help:
	$(info --------------------------------------- )	
	$(info Available targets)
	$(info --------------------------------------- )
	$(QUIET) awk '/^[a-zA-Z\-\_0-9]+:/ {            \
	  nb = sub( /^## /, "", helpMsg );              \
	  if(nb == 0) {                                 \
	    helpMsg = $$0;                              \
	    nb = sub( /^[^:]*:.* ## /, "", helpMsg );   \
	  }                                             \
	  if (nb)                                       \
	    print  $$1 "\t" helpMsg;                    \
	}                                               \
	{ helpMsg = $$0 }'                              \
	$(MAKEFILE_LIST) | column -ts:	



default: help


## install  EPICS Module
install: uninstall 
	$(QUIET) sudo -E bash -c 'make $(M_OPTIONS) install'

## Uninstall "Require" Module in order not to use it
uninstall: conf
	$(QUIET) sudo -E bash -c 'make $(M_OPTIONS) uninstall'

## Build the EPICS Module
build: conf version.h 
	$(QUIET) make $(M_OPTIONS) build

## clean, build, and install again.
rebuild: clean build install

## Clean the EPICS Module
clean: conf
	$(QUIET) make $(M_OPTIONS) clean

## Show driver.makefile help
help2:
	$(QUIET) make $(M_OPTIONS) help

## Show driver.makefile help
debug:
	$(QUIET) make $(M_OPTIONS) debug

#
## Initialize EPICS BASE and E3 ENVIRONMENT Module
init: git-submodule-sync $(EPICS_MODULE_SRC_PATH) $(E3_ENV_NAME)

git-submodule-sync:
	$(QUIET) git submodule sync


$(EPICS_MODULE_SRC_PATH):
	$(QUIET) $(git_update)
	cd $@ && git checkout $(EPICS_MODULE_TAG)


checkout: 
	cd $(EPICS_MODULE_SRC_PATH) && git checkout $(EPICS_MODULE_TAG)


$(E3_ENV_NAME): 
	$(QUIET) $(git_update)


## Print EPICS and ESS EPICS Environment variables
env:
	$(QUIET) echo ""

	$(QUIET) echo "EPICS_MODULE_SRC_PATH       : "$(EPICS_MODULE_SRC_PATH)
	$(QUIET) echo "ESS_MODULE_MAKEFILE         : "$(ESS_MODULE_MAKEFILE)
	$(QUIET) echo "EPICS_MODULE_TAG            : "$(EPICS_MODULE_TAG)
	$(QUIET) echo "LIBVERSION                  : "$(LIBVERSION)
	$(QUIET) echo "PROJECT                     : "$(PROJECT)

	$(QUIET) echo ""
	$(QUIET) echo "----- >>>> EPICS BASE Information <<<< -----"
	$(QUIET) echo ""
	$(QUIET) echo "EPICS_BASE_TAG              : "$(EPICS_BASE_TAG)
#	$(QUIET) echo "CROSS_COMPILER_TARGET_ARCHS : "$(CROSS_COMPILER_TARGET_ARCHS)
	$(QUIET) echo ""
	$(QUIET) echo "----- >>>> ESS EPICS Environment  <<<< -----"
	$(QUIET) echo ""
	$(QUIET) echo "EPICS_LOCATION              : "$(EPICS_LOCATION)
	$(QUIET) echo "EPICS_MODULES               : "$(EPICS_MODULES)
	$(QUIET) echo "DEFAULT_EPICS_VERSIONS      : "$(DEFAULT_EPICS_VERSIONS)
	$(QUIET) echo "BASE_INSTALL_LOCATIONS      : "$(BASE_INSTALL_LOCATIONS)
	$(QUIET) echo "REQUIRE_VERSION             : "$(REQUIRE_VERSION)
	$(QUIET) echo "REQUIRE_PATH                : "$(REQUIRE_PATH)
	$(QUIET) echo "REQUIRE_TOOLS               : "$(REQUIRE_TOOLS)
	$(QUIET) echo "REQUIRE_BIN                 : "$(REQUIRE_BIN)
	$(QUIET) echo ""

conf:
	$(QUIET) install -m 644 $(TOP)/$(ESS_MODULE_MAKEFILE)  $(EPICS_MODULE_SRC_PATH)/

version.h:
	m4 -D_VERSION_="$(EPICS_MODULE_TAG)" $(TOP)/configure/version_h.m4 | m4 -D_DEFINE_="#define" 	> $(EPICS_MODULE_SRC_PATH)/mrfCommon/src/mrf/version.h




### We have to think how to find $(EPICS_BASE) and
### $(EPICS_HOST_ARCH) during driver.makefile
### Friday, November  3 16:44:55 CET 2017, jhlee
### Currently feasible solutoin without touching driver.makefile
### is the following:
###
### 0) source setE3Env.bash 3.15.4
### 1) make db
### 2) make install
### 3) source setE3Env.bash 3.15.5
### 4) make db
### 5) make install

#SHELL := /bin/bash

db: conf
	install -m 644 $(TOP)/template/evg-*-ess.substitutions   $(EPICS_MODULE_SRC_PATH)/evgMrmApp/Db/
	install -m 644 $(TOP)/template/evr-*-ess.substitutions   $(EPICS_MODULE_SRC_PATH)/evrMrmApp/Db/
ifndef $(EPICS_BASE)
	$(QUIET) echo ""
	$(QUIET) echo "No EPICS_BASE is defined. Sourcing.... "
	$(QUIET) echo "We are using the default and only one EPICS base in order to inflat sub files to db files"
	$(QUIET) bash -c "source $(TOP)/$(E3_ENV_NAME)/setE3Env.bash && make $(M_OPTIONS) db"

else

	$(QUIET) make $(M_OPTIONS) db
endif


epics:
	$(QUIET)echo "DEVLIB2=$(M_DEVLIB2)"                 > $(TOP)/$(EPICS_MODULE_SRC_PATH)/configure/RELEASE.local
	$(QUIET)echo "EPICS_BASE=$(COMMUNITY_EPICS_BASE)"  >> $(TOP)/$(EPICS_MODULE_SRC_PATH)/configure/RELEASE.local
	$(QUIET)echo "INSTALL_LOCATION=$(M_MRFIOC2)"        > $(TOP)/$(EPICS_MODULE_SRC_PATH)/configure/CONFIG_SITE	
	sudo -E bash -c "$(MAKE) -C $(EPICS_MODULE_SRC_PATH)"

epics-clean:
	sudo -E bash -c "$(MAKE) -C $(EPICS_MODULE_SRC_PATH) clean"


.PHONY: env $(E3_ENV_NAME) $(EPICS_MODULE_SRC_PATH) git-submodule-sync init help help2 build clean install uninstall conf rebuild version.h epics epics-clean debug checkout


.PHONY: devinit devenv devbuild devclean devrebuild devuninstall devdb

##
devinit: git-submodule-sync  $(E3_ENV_NAME)
	git clone $(DEV_GIT_URL) $(EPICS_MODULE_SRC_PATH)

devenv: env
devbuild: build
devclean: clean
devinstall: install
devrebuild: rebuild
devuninstall : uninstall
devdb: db

