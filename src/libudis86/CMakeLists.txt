cmake_minimum_required (VERSION 3.9)

project (udis86)

if (MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()

set(
  lib_sources
  src/libudis86/decode.c
  src/libudis86/itab.c
  src/libudis86/syn-att.c
  src/src/libudis86/syn-intel.c
  libudis86/syn.c
  src/libudis86/udis86.c
)

set(lib_headers
  src/libudis86/decode.h
  src/libudis86/itab.h
  src/libudis86/extern.h
  src/libudis86/syn.h
  src/libudis86/types.h
  src/libudis86/udint.h
)

set(cli_srcs  udcli/udcli.c)

include_directories(.)

add_library(libudis86 ${lib_sources})

if(BUILD_SHARED_LIBS)
  target_compile_definitions(libudis86 PRIVATE -D_USRDLL)
endif()

add_executable(udcli ${cli_srcs})
target_link_libraries(udcli libudis86)


install(
  TARGETS libudis86
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

if(NOT DISABLE_INSTALL_TOOLS)
  install (
    TARGETS udcli
    RUNTIME DESTINATION tools/libudis86
  )
endif()

if(NOT DISABLE_INSTALL_HEADERS)
  install(FILES ${lib_headers} DESTINATION include/src/libudis86)
  install(FILES src/udis86.h DESTINATION include)
endif()