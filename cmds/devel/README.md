# Parameters

## EVG
* EXTREF='' - external synchronization reference
* INTREF='' - internal synchronization reference

# To apply parameters

* iocsh.bash -c 'epicsEnvSet("IOC", "TD11")' evr.cmd
* iocsh.bash img_dry_run.cmd |grep -i FWVersion
