

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