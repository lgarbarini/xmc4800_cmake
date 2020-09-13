# XMC4800 CMake project
A CMake flow for the Infineon XMC4800 microcontroller.

## Prequisites
 - ARM GCC -- tested with `gcc-arm-none-eabi-8-2018-q4-major`
 - XMCLib -- tested with `XMC_Peripheral_Library_v2.1.24`

Both of these need to be in your environment to be used by CMake, for example:
``` bash
export TOOLCHAIN_PREFIX=~/provisioning/gcc-arm-none-eabi-8-2018-q4-major
export XMCLIB_DIR=~/provisioning/XMC_Peripheral_Library_v2.1.24
```

NOTE: this repository is a WORK IN PROGRESS and should not be considered stable