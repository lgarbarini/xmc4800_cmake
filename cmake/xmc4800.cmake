#Set Compiler Debug options
set( compiler_debug_options
    "-g" "-gdwarf-2"
    CACHE INTERNAL "CMAKE Compiler options for debug builds"
)

#Set compiler warnings level
set( compiler_warnings
    "-Wall"
    CACHE INTERNAL "CMake compiler warning"
)

#Set compiler optimization level
set( compiler_optimization_options "-O2" "-ffunction-sections" "-fdata-sections"
    CACHE INTERNAL ""
)

#Set ARM GCC options
set( compiler_arm_options "-mfloat-abi=softfp" "-mcpu=cortex-m4" "-mfpu=fpv4-sp-d16" "-mthumb"
    CACHE INTERNAL ""
)

#Set other compiler options and flags
set( compiler_misc_options
     "-std=c99"
     "-c"
     "-fmessage-length=0"
     CACHE INTERNAL ""
)

#All compiler options
set( compiler_flags
     ${compiler_debug_options}
     ${compiler_warnings}
     ${compiler_optimization_options}
     ${compiler_arm_options}
     ${compiler_misc_options}
     "-pipe"
     CACHE INTERNAL ""
)


#All assembler options
set( assembler_flags
     "-x"
     "assembler-with-cpp"
     ${compiler_debug_options}
     ${compiler_warnings}
     ${compiler_optimization_options}
     ${compiler_arm_options}
     ${compiler_misc_options}
     CACHE INTERNAL ""
)

#Linker script path
set( linker_script
    "${xmc4800_dir}/XMC4800x2048.ld"
    CACHE INTERNAL ""
)

#All linker options
set( linker_flags
     "-T" ${linker_script}
     "-nostartfiles"
     "-Xlinker"
     "--gc-sections"
     "-specs=nosys.specs"
     "-Wl,-Map,aws_demos.map"
     ${compiler_arm_options}
     ${compiler_debug_options}
     CACHE INTERNAL ""
)

#Linker libraries
set(linker_libs
    "m"
    CACHE INTERNAL ""
)

# System

set(compiler_src
    "${xmclib_dir}/CMSIS/Infineon/XMC4800_series/Source/system_XMC4800.c"
    "${xmclib_dir}/CMSIS/Infineon/XMC4800_series/Source/GCC/startup_XMC4800.S"
)

set( board_includes
     "${xmclib_dir}/CMSIS/Include"
     "${xmclib_dir}/CMSIS/Core/Include"
     "${xmclib_dir}/XMCLib/inc"
     "${xmclib_dir}/CMSIS/Infineon/XMC4800_series/Include"
)


function(xmc_add_library library_target srcs)
    add_library(${library_target} OBJECT EXCLUDE_FROM_ALL
        ${srcs}
    )

    target_include_directories(${library_target} 
        PRIVATE "${board_includes}"
    )

    target_compile_options(${library_target}
        PRIVATE
            $<$<COMPILE_LANGUAGE:C>:${compiler_flags}>
    )

    target_compile_options(${library_target}
        PRIVATE
            $<$<COMPILE_LANGUAGE:ASM>:${assembler_flags}>
    )

    target_link_options(${library_target}
        PRIVATE
            ${linker_flags}
    )

    target_compile_definitions(${library_target}
        INTERFACE
            ${defined_symbols}
    )
endfunction()

xmc_add_library(system_xmc4800
    "${xmclib_dir}/CMSIS/Infineon/XMC4800_series/Source/system_XMC4800.c"
)

xmc_add_library(startup_xmc4800
    "${xmclib_dir}/CMSIS/Infineon/XMC4800_series/Source/GCC/startup_XMC4800.S"
)


function(xmc4800_target exec_target)
    target_include_directories(${exec_target} 
        PRIVATE "${board_includes}"
    )

    target_compile_options(${exec_target}
        PRIVATE
            $<$<COMPILE_LANGUAGE:C>:${compiler_flags}>
    )

    target_compile_options(${exec_target}
        PRIVATE
            $<$<COMPILE_LANGUAGE:ASM>:${assembler_flags}>
    )

    target_link_options(${exec_target}
        PRIVATE
            ${linker_flags}
    )

    target_compile_definitions(${exec_target}
        PRIVATE
            ${defined_symbols}
    )

    target_link_libraries(${exec_target}
        system_xmc4800
        startup_xmc4800
    )
    # Print size information after build
    add_custom_command(TARGET ${exec_target} POST_BUILD
        COMMAND ${CMAKE_SIZE_BIN} "${exec_target}"
    )
    # Targets for creating Intel HEX and binary executable forms
    add_custom_target(hex DEPENDS ${exec_target} COMMAND ${CMAKE_OBJCOPY_BIN} -O ihex "${exec_target}" "${exec_target}.hex")
    add_custom_target(bin DEPENDS ${exec_target} COMMAND ${CMAKE_OBJCOPY_BIN} -O binary "${exec_target}" "${exec_target}.bin")
endfunction()