# e3-mrfioc2


## Kernel module (mrf.ko) can be installed via DKMS


```sh
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
Even if we buid the kernel DKMS, one needs the following commands after new Kernel install.
```
$ sudo dkms autoinstall
```

Or put dkms/dkms.service in your system dependent systemd service directory, and run
```
$ sudo systemctl enable dkms.service
$ sudo systemctrl start dkms.service
```
