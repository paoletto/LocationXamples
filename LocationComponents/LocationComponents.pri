INCLUDEPATH += ../LocationComponents

DEFINES += LOCATION_COMPONENTS_PWD="\"$$PWD/.."\"
message($$DEFINES)
HEADERS += ../LocationComponents/qmlenvironmentvariable.h \
           ../LocationComponents/locationcomponents.h

SOURCES += ../LocationComponents/qmlenvironmentvariable.cpp
