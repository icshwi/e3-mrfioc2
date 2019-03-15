
## How to Run the IOC

```
~$ cd e3-3.15.5/e3-mrfioc2/
e3-mrfioc2 (master)$ source ../tools/setenv
e3-mrfioc2 (master)$ iocsh.bash cmds/ex01/evr_mtca_300u_standalone_with_FPOut.cmd
```

Please check the `e3-mrfioc2/iocsh/mtca-evr-FP0-output.iocsh` 
for further Trigger OUTPUT which supported by MTCA EVR 300U.

Add some .iocsh files in iocsh. One needs to run
```
e3-mrfioc2 (master)$ make install
```
One can use `$(E3_CMD_TOP)` in order to access the iocsh path. Please check the E3 training workbook. 


## How to enable the UNIV0 TTL OUT 
```
dbpf MTCA-EVR:DlyGen0-Evt-Trig0-SP 14
dbpf MTCA-EVR:DlyGen0-Width-SP 1000
dbpf MTCA-EVR:OutFP0-Src-SP 0 
```

## How to change the Pulse Width of TTL OUT

```
dbpf MTCA-EVR:DlyGen0-Width-SP 100000
```

## How to change the MainEvtCODE (Hz)

* For 14 Hz: 88052500 / 6289464 = 14
```
dbpf MTCA-EVR:PS0-Div-SP 6289464
```

* For 1 Hz : 88052500 / 88052500 = 1
```
dbpf MTCA-EVR:PS0-Div-SP 88052500
```


## How to Run the IOC


```
~$ cd e3-3.15.5/e3-mrfioc2/
e3-mrfioc2 (master)$ source ../tools/setenv
e3-mrfioc2 (master)$ iocsh.bash cmds/ex01/evr_mtca_300u_standalone_with_FPOut.cmd
```

Please check the e3-mrfioc2/iocsh/mtca-evr-FP0-output.iocsh for further Trigger OUTPUT which supported by MTCA EVR 300U.

Add some .iocsh files in iocsh. One needs to run

```
e3-mrfioc2 (master)$ make install
```

Friday, March 15 11:23:35 CET 2019