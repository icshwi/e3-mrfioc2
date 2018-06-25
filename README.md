# e3-mrfioc2


## Kernel modules compiliation and installation


```sh
$ make modules
$ make modules_install
```

In order to remove the mrf.ko from the system.

```sh
$ make modules_uninstall
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
