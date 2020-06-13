HEADERS = Qarma.h
SOURCES = Qarma.cpp
QT      += gui widgets
unix:!macx:QT += x11extras
TARGET  = qarma

!QARMA_DBUS {
    DEFINES += QARMA_DBUS
    QT += dbus
}

unix:!macx:LIBS    += -lX11
unix:!macx:DEFINES += QARMA_X11EXTRA

target.path += /usr/bin
INSTALLS += target
