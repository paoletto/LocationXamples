INCLUDEPATH += ../LocationComponents

DEFINES += LOCATION_COMPONENTS_PWD="\"$$PWD/.."\"
#message($$DEFINES)
HEADERS += ../LocationComponents/qmlsystemenvironment.h \
           ../LocationComponents/locationcomponents.h

SOURCES += ../LocationComponents/qmlsystemenvironment.cpp
