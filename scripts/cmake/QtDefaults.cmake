set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(QT NAMES Qt6 Qt5)

if(NOT QT_DEFAULT_MAJOR_VERSION)
    set(QT_DEFAULT_MAJOR_VERSION 5)
endif()
set(QT_MAJOR_VERSION ${QT_DEFAULT_MAJOR_VERSION} CACHE STRING "Qt version to use (5 or 6), defaults to ${QT_DEFAULT_MAJOR_VERSION}")

option(${PRJ_PREFIX}_NEED_QT5 "Use Qt 5" OFF)
option(${PRJ_PREFIX}_NEED_QT6 "Use Qt 6" OFF)

if(${PRJ_PREFIX}_NEED_QT6)
  set(${PRJ_PREFIX}_BUILD_QT6 ON)
endif()

if(${PRJ_PREFIX}_BUILD_QT5)
    set(QT_MAJOR_VERSION 5)
elseif(${PRJ_PREFIX}_BUILD_QT6)
    set(QT_MAJOR_VERSION 6)
else()
    if(QT_MAJOR_VERSION EQUAL 5)
        set(${PRJ_PREFIX}_BUILD_QT5 ON)
    elseif(QT_MAJOR_VERSION EQUAL 6)
        set(${PRJ_PREFIX}_BUILD_QT6 ON)
    else()
        set(${PRJ_PREFIX}_BUILD_QT5 ON)
        set(QT_MAJOR_VERSION 5)
        set(QT_MIN_VERSION 5.8)
    endif()
endif()

list(APPEND ${PRJ_PREFIX}_QT_COMPONENTS Widgets)
list(APPEND ${PRJ_PREFIX}_QT_LIBRARIES Qt${QT_MAJOR_VERSION}::Widgets)

if(${PRJ_PREFIX}_NEED_QT_DBUS AND DBUS_FOUND AND NOT WIN32)
    list(APPEND ${PRJ_PREFIX}_QT_COMPONENTS DBus)
endif()

if(${PRJ_PREFIX}_NEED_QT_EXTRA)
    if(X11_FOUND)
        list(APPEND ${PRJ_PREFIX}_QT_COMPONENTS X11Extras)
    elseif(WIN32)
        list(APPEND ${PRJ_PREFIX}_QT_COMPONENTS WinExtras)
    endif()
endif()

find_package(Qt${QT_MAJOR_VERSION} ${QT_MIN_VERSION} REQUIRED COMPONENTS
    ${${PRJ_PREFIX}_QT_COMPONENTS}
)

if(${PRJ_PREFIX}_NEED_QT_DBUS AND Qt${QT_MAJOR_VERSION}DBus_FOUND)
    list(APPEND ${PRJ_PREFIX}_QT_LIBRARIES Qt${QT_MAJOR_VERSION}::DBus)
    set(${PRJ_PREFIX}_DBUS ON)
    message(STATUS "Qt: Using DBus")
endif()

if(${PRJ_PREFIX}_NEED_QT_EXTRA)
    if(Qt${QT_MAJOR_VERSION}X11Extras_FOUND)
        list(APPEND  ${PRJ_PREFIX}_QT_LIBRARIES Qt${QT_MAJOR_VERSION}::X11Extras)
        set(${PRJ_PREFIX}_X11EXTRA ON)
        message(STATUS "Qt: Using X11Extras")
    elseif(Qt${QT_MAJOR_VERSION}WinExtras_FOUND)
        list(APPEND  ${PRJ_PREFIX}_QT_LIBRARIES Qt${QT_MAJOR_VERSION}::WinExtras)
        set(${PRJ_PREFIX}_WINEXTRA ON)
        message(STATUS "Qt: Using WinExtras")
    endif()
endif()

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(${PROJECT_NAME}
        ${${PRJ_PREFIX}_SOURCES}
    )
else()
    add_executable(${PROJECT_NAME}
        ${${PRJ_PREFIX}_SOURCES}
    )
endif()

target_link_libraries(${PROJECT_NAME} PRIVATE ${${PRJ_PREFIX}_QT_LIBRARIES})

if(${PRJ_PREFIX}_DBUS)
    target_compile_definitions(${PROJECT_NAME} PUBLIC ${PRJ_PREFIX}_DBUS)
endif()
if (${PRJ_PREFIX}_X11EXTRA)
    target_compile_definitions(${PROJECT_NAME} PUBLIC ${PRJ_PREFIX}_X11EXTRA)
elseif(${PRJ_PREFIX}_WINEXTRA)
    target_compile_definitions(${PROJECT_NAME} PUBLIC ${PRJ_PREFIX}_WINEXTRA)
endif()
