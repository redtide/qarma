cmake_minimum_required(VERSION 3.5)

project(qarma LANGUAGES CXX)
set(${PROJECT_NAME}_DESCRIPTION "Zenity Clone for Qt")
set(${PROJECT_NAME}_HOMEPAGE_URL "https://github.com/luebking/qarma")

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
    pkg_check_modules(DBUS REQUIRED)
endif()

set(${PRJ_PREFIX}_SOURCES
    Qarma.cpp
    Qarma.h
)
include(QtDefaults)

if(UNIX AND NOT APPLE)
    target_link_libraries(${PROJECT_NAME} PRIVATE X11)
endif()
