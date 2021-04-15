cmake_minimum_required(VERSION 3.5)

project(Qarma LANGUAGES CXX)
set(${PROJECT_NAME}_DESCRIPTION "Zenity Clone for Qt")
set(${PROJECT_NAME}_HOMEPAGE_URL "https://github.com/luebking/qarma")

string(TOLOWER ${PROJECT_NAME} PROJECT_TARGET_NAME)
string(TOUPPER ${PROJECT_NAME} PRJ_PREFIX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_CURRENT_SOURCE_DIR}/scripts/cmake")
set(${PRJ_PREFIX}_NEED_QT_DBUS ON)
set(${PRJ_PREFIX}_NEED_QT_EXTRA ON)

if(UNIX AND NOT APPLE)
    include(FindPkgConfig)
    find_package(X11)
    pkg_check_modules(DBUS REQUIRED dbus-1)
endif()

set(${PRJ_PREFIX}_SOURCES
    src/Qarma.cpp
    src/Qarma.h
)
include(QtDefaults)

set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_TARGET_NAME}")

if(UNIX AND NOT APPLE)
    target_link_libraries(${PROJECT_NAME} PRIVATE X11)
endif()
