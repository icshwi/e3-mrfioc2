# e3-mrfioc2



## Kernel Module, and its Setup (for only HOST)

* Create and load udev rule in /etc/udev/rules.d/99-mrfioc2.rules
* Create and load the autoload configuration in /etc/modules-load.d/mrf.conf
* Remove and load the kernel module with modprobe

```sh
$ make setup
```

One can clean all others via
```sh
$ make setup_clean
```
