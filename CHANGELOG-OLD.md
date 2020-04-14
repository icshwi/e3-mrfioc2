Changelog
--
# master
- 2.2.0-rclatest
## Changed
- PBCfg to PBState : from boolean to enumeration, compatibility to the latest documentation (and to avoid 0 value).

# 7.0.3.1-3.1.2/R-2.2.0-rc8-a1baa66-2002031236
## Requirements
- mrfioc2 <= 2.2.0-ess-rc8
- rc8 is recommended for the support of the gated events (moving widths)
## Added
- Compatybility to the supercycleEngine
## Changed
- Modifications to the databuffer (see the manual)
- PBLen, PBEn, PBCurr: the databuffer records from float to uint32.
- PBOn to PBCfg : from boolean to enumeration (On==1, Off==2, Ignore==0) - to avoid 0 value.

# 2.2.0-rc7
## Requirements
- mrfioc2 <= 2.2.0-ess-rc7
## Added
- EVR databuffer support (obsolete)

# 7.0.3-3.1.2/R-2.2.0-rc7
## Requirements
- mrfioc2 <= 2.2.0-ess-rc7.
## Added
- mrfioc2 == 2.2.0-ess-rc7 (support for MTCA EVR: FP, Univ, BP inputs; PCIe EVR: FP, Univ inputs).
- evr-mtca-300u-ess.substitutions to support FP, Univ, BP inputs.
- evr-pcie-300dc-ess.substitutions to support FP, Univ inputs.

# 2.2.0-rc6
## Requirements
- mrfioc2 <= 2.2.0-ess-rc6.
## Added
- mrfioc2 == 2.2.0-ess-rc6.
