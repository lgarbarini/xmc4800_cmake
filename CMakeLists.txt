cmake_minimum_required(VERSION 3.14)
project(uart LANGUAGES C ASM)

set(TOOLCHAIN_PREFIX $ENV{TOOLCHAIN_PREFIX})
set(xmclib_dir $ENV{XMCLIB_DIR})

set(xmc4800_dir "${CMAKE_CURRENT_LIST_DIR}/board")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

include(arm-none-eabi)
include(xmc4800)

add_definitions(-DXMC4800_F100x2048)

xmc_add_library(xmc4_scu
    ${xmclib_dir}/XMCLib/src/xmc4_scu.c
)

xmc_add_library(xmc_uart
    ${xmclib_dir}/XMCLib/src/xmc_uart.c
)
target_link_libraries(xmc_uart
    xmc4_scu
)

xmc_add_library(xmc_gpio
    ${xmclib_dir}/XMCLib/src/xmc_gpio.c
)

xmc_add_library(xmc_usic
    ${xmclib_dir}/XMCLib/src/xmc_usic.c
)
target_link_libraries(xmc_usic
    xmc4_scu
)

xmc_add_library(newlib
    "${xmclib_dir}/ThirdPartyLibraries/Newlib/syscalls.c"
)


add_executable(main
    main.c
    # retarget_io.c
    # ring_buffer.c
    serial.c
)
xmc4800_target(main)
target_link_libraries(main
    xmc_uart
    xmc_gpio
    xmc_usic
    xmc4_scu
    newlib
)
