# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appweigo_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appweigo_autogen.dir/ParseCache.txt"
  "appweigo_autogen"
  )
endif()
