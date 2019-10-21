How to ....
===


* Get PCIE EVR 300 PCI Addr

```
$ bash get_pciaddr.bash pcieevr300
1 : Input pcieevr300 ---- PCI ID    03:00.0

```

## Install ioc@*.service

* CentOS

`/usr/lib/systemd/system`

```
sudo install -m 644 ioc@*.service /usr/lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable ioc@*.service
sudo systemctl start ioc@*.service
```

* Debian

`/etc/systemd/system`

## Create /var/log/procServ
```
sudo mkdir /var/log/procServ
sudo chown iocuser:iocgroup /var/log/procServ/
```

## Put the logrotate

```
# /etc/logrotate.d/softiocs
/var/log/procServ/*log {
    notifempty
    copytruncate
    daily
    rotate 7
    dateext
    compress
}
```



## Start the IOC

```
systemctl start ioc@BIEVG001
systemctl status ioc@BIEVG001
systemctl stop ioc@BIEVG001
```

## Connect the ioc within procSever after systemd

```
iocuser@ip5-33: tools (master)$ telnet localhost 20000
Trying ::1...
telnet: connect to address ::1: Connection refused
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
@@@ Welcome to procServ (procServ Process Server 2.7.0)
@@@ Use ^X to kill the child, auto restart is ON, use ^T to toggle auto restart
@@@ procServ server PID: 15780
@@@ Server startup directory: /
@@@ Child startup directory: /home/iocuser/e3-7.0.3/e3-mrfioc2/cmds/ex02
@@@ Child "BIEVG001" started as: /epics/base-7.0.3/require/3.1.2/bin/iocsh.bash
@@@ Child "BIEVG001" PID: 16119
@@@ procServ server started at: Mon Oct 21 14:42:37 2019
@@@ Child "BIEVG001" started at: Mon Oct 21 14:44:33 2019
@@@ 0 user(s) and 0 logger(s) connected (plus you)

```

Type the telnet escape character ^] to get back to a telnet prompt then "quit" to exit telnet


## chronyd

/etc/chrony.conf

```
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
server ntp-cluster01.tn.esss.lu.se iburst
server mmo1.ntp.se iburst
server gbg1.ntp.se iburst
server sth1.ntp.se iburst


# Record the rate at which the system clock gains/losses time.
driftfile /var/lib/chrony/drift


# Stop bad estimates upsetting machine clock.
maxupdateskew 100.0

# Allow the system clock to be stepped in the first three updates
# if its offset is larger than 1 second.
makestep 1.0 3

# Enable kernel synchronization of the real-time clock (RTC).
rtcsync

# Specify directory for log files.
logdir /var/log/chrony

```

systemctl restart chronyd

[root@ip5-33 etc]# chronyc tracking
Reference ID    : C23ACC14 (mmo1.ntp.se)
Stratum         : 2
Ref time (UTC)  : Mon Oct 21 14:07:37 2019
System time     : 0.000000252 seconds fast of NTP time
Last offset     : -0.000250431 seconds
RMS offset      : 0.000250431 seconds
Frequency       : 14.612 ppm slow
Residual freq   : -38.147 ppm
Skew            : 0.206 ppm
Root delay      : 0.001557056 seconds
Root dispersion : 0.000447442 seconds
Update interval : 2.0 seconds
Leap status     : Normal
[root@ip5-33 etc]# 


[root@ip5-33 etc]# chronyc sources
210 Number of sources = 4
MS Name/IP address         Stratum Poll Reach LastRx Last sample               
===============================================================================
^+ ntp-cluster01.tn.esss.lu>     1   6    17    19    -60us[ -310us] +/- 1363us
^* mmo1.ntp.se                   1   6    17    18    +14us[ -237us] +/-  817us
^+ gbg1.ntp.se                   1   6    17    18  +5208ns[ -245us] +/- 2510us
^- sth1.ntp.se                   1   6    17    18   +730us[ +480us] +/- 5180us


## autosave

sudo mkdir /opt/iocs
sudo chown iocuser:iocgroup /opt/iocs

mkdir /opt/iocs/autosave

