


## Fru info

```
nat> show_fruinfo 6
---------------------------------------
FRU Info for device 6:
---------------------------------------
Common Header    : 0x01 0x00 0x00 0x01 0x0c 0x18 0x00 0xda 
---------------------------------------
Internal Use Area : -
---------------------------------------
Chassis Info Area : -
---------------------------------------
Board Info Area          : at offs=8, len=88
Manufacturer(25)         : Micro-Research Finland Oy
Board Name(12)           : mTCA-EVM-300
Serial Number(07)        : P374002
Part Number(12)          : mTCA-EVM-300
FRU file ID(14)          : mtcaevm300.fru
---------------------------------------
Product Info Area        : at offs=96, len=96
Manufacturer(25)         : Micro-Research Finland Oy
Product Name(19)         : mTCA.4 Event Master
Product Number(12)       : mTCA-EVM-300
Part Version(04)         : v1.0
Product Serial Number(07): P374002
Asset Tag(00)            :  -
FRU file ID(14)          : mtcaevm300.fru
---------------------------------------
Multi Record Area  : at offs=192

Record(0): Type ID=0xc0, PICMG Record ID=0x16, offset=0x000, len=11
Module Current Requirements Record:
    Current Draw: 4.0 A

Record(1): Type ID=0xc0, PICMG Record ID=0x19, offset=0x00b, len=21
AMC Point-to-Point record:
AMC Slot  2, OEM GUID Count = 0
    Record Type = AMC, len=21
    Channel Descriptor count = 1
    Channel(0): Port[4 - - -] 
    Link Descriptors: size=5
    Link 0 of Channel 0: lanes[0..3]=[1000], PCIe,  Gen 1, no SSC, Grp=0x0, Match=0x1
---------------------------------------
```



## Sensor Info

```
nat> show_sensorinfo 6
Sensor Information for FRU 6 / AMC2
==================================================================
  #   SDRType  Sensor Entity Inst  Value   State    Name
------------------------------------------------------------------
  -   MDevLoc          0xc1  0x62                    mTCA-EVM-300 
  0   Full     0xf2    0xc1  0x62  0x04              Hot Swap
  1   Full     Voltage 0xc1  0x62  2.368 V    ok     REF
  2   Full     Voltage 0xc1  0x62  20.4 V     ok     Temp 1
  3   Full     Voltage 0xc1  0x62  5.4 V      ok     Temp 2
  4   Full     Voltage 0xc1  0x62  1.008 V    ok     1.0 V
  5   Full     Voltage 0xc1  0x62  1.776 V    ok     1.8 V
  6   Full     Voltage 0xc1  0x62  12.4 V     ok     12 V
  7   Full     Voltage 0xc1  0x62  3.312 V    ok     3.3 V
  8   Full     Voltage 0xc1  0x62  3.216 V    ok     3.3 V MP
  9   Compact  0x0b    0xc1  0x62  0x00              0x00  FPGA Done
 10   Full     Temp    0xc1  0x62  33.0 C     ok     Local
 11   Full     Temp    0xc1  0x62  47.0 C     ok     FPGA
 12   Compact  0xf0    0xc1  0x62  0x10              HS 006 AMC2
------------------------------------------------------------------


```
