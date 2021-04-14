HEADERS = Qarma.h
SOURCES = Qarma.cpp
QT      += dbus gui widgets
unix:!macx:QT += x11extras
TARGET  = qarma

unix:!macx:LIBS    += -lX11
unix:!macx:DEFINES += QARMA_X11EXTRA

target.path += /usr/bin
INSTALLS += target