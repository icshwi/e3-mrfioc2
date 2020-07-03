# e3-mrfioc2
## Prerequisites  
In addition to EPICS_BASE and E3 Require, it is required to install the devlib2 library prior to installing mrfioc2 E3 module.  
## Check the PCI Address of MRF HW
One can find the correct PCI Address by `lspci` command, and e3 also provide a wrapper script for this. 
```
$ bash tools/get_pciaddr.bash 
Usage: get_pciaddr.bash possible_devices [cpcievr220|cpcievr230|cpcievr300|pcieevr300
                                          |mtcaevr300|cpcievg220|cpcievg230|
										  cpcievg300|mtcaevm300] 

```
For example, if one has one MRF PCIE EVR 300DC, one can find 
```sh
$ bash tools/get_pciaddr.bash pcieevr300
1 : Input pcieevr300 ---- PCI ID    03:00.0
```

## Kernel module (mrf.ko) can be installed via DKMS


```sh
$ make init
$ make dkms_add
$ make dkms_build
$ make dkms_install
```

In order to remove them

```sh
$ make dkms_uninstall
$ make dkms_remove
```

## Kernel modules configuration

* Create and load udev rule in /etc/udev/rules.d/99-mrfioc2.rules
* Create and load the autoload configuration in /etc/modules-load.d/mrf.conf
* Remove and load the kernel module with modprobe

```sh
$ make setup
```

In order to clean the configuration,

```sh
$ make setup_clean
```

## Notice
If one has already the running dkms.service in systemd, the next reboot with new kernl image will make the kernel module be ready. However, if one doesn't have one, please run bash dkms/dkms_setup.bash in order to enable dkms.service.

```
$ bash dkms/dkms_setup.bash
$ systemctl status dkms
● dkms.service - Builds and install new kernel modules through DKMS
   Loaded: loaded (/etc/systemd/system/dkms.service; enabled; vendor preset: ena
   Active: active (exited) since Sun 2018-07-29 01:13:59 CEST; 4s ago
     Docs: man:dkms(8)
  Process: 3271 ExecStart=/bin/sh -c dkms autoinstall --verbose --kernelver $(un
 Main PID: 3271 (code=exited, status=0/SUCCESS)


```
