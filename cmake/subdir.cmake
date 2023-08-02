file(GLOB children src/*)

foreach(child ${children})
  get_filename_component(subdir_name ${child} NAME)
  string(TOUPPER ${subdir_name} subdir_name)
  if (ENABLE_CPP_20)
    option(BUILD_${subdir_name} "BUILD_${subdir_name}" ON)
  else()
    option(BUILD_${subdir_name} "BUILD_${subdir_name}" OFF)
  endif()
endforeach()

if (NOT ENABLE_CPP_20)
  Set(BUILD_STRUCT_PACK ON)
endif()

foreach(child ${children})
  get_filename_component(subdir_name ${child} NAME)
  string(TOUPPER ${subdir_name} subdir_name)
  message(STATUS "BUILD_${subdir_name}: ${BUILD_${subdir_name}}")
endforeach()

foreach(child ${children})
  get_filename_component(subdir_name ${child} NAME)
  string(TOUPPER ${subdir_name} subdir_name)
  if (BUILD_${subdir_name})
    if(BUILD_UNIT_TESTS AND EXISTS ${child}/examples)
      add_subdirectory(${child}/examples)
    endif()
    if(BUILD_BENCHMARK AND EXISTS ${child}/tests)
      add_subdirectory(${child}/tests)
    endif()
    if(BUILD_EXAMPLES AND EXISTS ${child}/benchmark)
      add_subdirectory(${child}/benchmark)
    endif()
  endif()
endforeach()
if (BUILD_STRUCT_PB)
  add_subdirectory(src/struct_pb)
endif()