cmake_minimum_required(VERSION 3.0.0)
project(bloodlink_edit_account VERSION 0.1.0)

include(CTest)
enable_testing()

add_library(bloodlink_edit_account bloodlink_edit_account.cpp)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
