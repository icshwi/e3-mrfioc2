
## Fru info

```
nat> show_fruinfo 7
---------------------------------------
FRU Info for device 7:
---------------------------------------
Common Header    : 0x01 0x00 0x00 0x01 0x0c 0x19 0x00 0xd9 
---------------------------------------
Internal Use Area : -
---------------------------------------
Chassis Info Area : -
---------------------------------------
Board Info Area          : at offs=8, len=88
Manufacturer(25)         : Micro-Research Finland Oy
Board Name(12)           : mTCA-EVR-300
Serial Number(07)        : P376053
Part Number(12)          : mTCA-EVR-300
FRU file ID(16)          : mtcaevr300dc.fru
---------------------------------------
Product Info Area        : at offs=96, len=104
Manufacturer(25)         : Micro-Research Finland Oy
Product Name(21)         : mTCA.4 Event Receiver
Product Number(12)       : mTCA-EVR-300
Part Version(04)         : v1.1
Product Serial Number(07): P376053
Asset Tag(00)            :  -
FRU file ID(16)          : mtcaevr300dc.fru
---------------------------------------
Multi Record Area  : at offs=200

Record(0): Type ID=0xc0, PICMG Record ID=0x16, offset=0x000, len=11
Module Current Requirements Record:
    Current Draw: 2.0 A

Record(1): Type ID=0xc0, PICMG Record ID=0x19, offset=0x00b, len=21
AMC Point-to-Point record:
AMC Slot  3, OEM GUID Count = 0
    Record Type = AMC, len=21
    Channel Descriptor count = 1
    Channel(0): Port[4 - - -] 
    Link Descriptors: size=5
    Link 0 of Channel 0: lanes[0..3]=[1000], PCIe,  Gen 1, no SSC, Grp=0x0, Match=0x1
---------------------------------------
```



## Sensor Info

```
nat> show_sensorinfo 7
Sensor Information for FRU 7 / AMC3
==================================================================
  #   SDRType  Sensor Entity Inst  Value   State    Name
------------------------------------------------------------------
  -   MDevLoc          0xc1  0x63                    mTCA-EVR-300 
  0   Full     0xf2    0xc1  0x63  0x04              Hot Swap
  1   Full     Voltage 0xc1  0x63  2.368 V    ok     REF
  2   Full     Voltage 0xc1  0x63  5.9 V      ok     Temp 1
  3   Full     Voltage 0xc1  0x63  0.5 V      ok     Temp 2
  4   Full     Voltage 0xc1  0x63  0.992 V    ok     1.0 V
  5   Full     Voltage 0xc1  0x63  1.776 V    ok     1.8 V
  6   Full     Voltage 0xc1  0x63  12.3 V     ok     12 V
  7   Full     Voltage 0xc1  0x63  3.296 V    ok     3.3 V
  8   Full     Voltage 0xc1  0x63  3.200 V    ok     3.3 V MP
  9   Compact  0x0b    0xc1  0x63  0x00              0x00  FPGA Done
 10   Full     Temp    0xc1  0x63  28.0 C     ok     Local
 11   Full     Temp    0xc1  0x63  39.0 C     ok     FPGA
 12   Compact  0xf0    0xc1  0x63  0x10              HS 007 AMC3
--------------------
```
