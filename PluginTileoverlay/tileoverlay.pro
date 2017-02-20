TARGET = qtgeoservices_tileoverlay

QT += quick-private location-private positioning-private network

HEADERS += qgeoserviceproviderplugin_test.h \
           qgeotiledmappingmanagerengine_test.h \
           qgeotiledmap_test.h \
           qgeotilefetcher_test.h

SOURCES += qgeoserviceproviderplugin_test.cpp \
           qgeotiledmap_test.cpp

#Use this when building as part of Qt
#OTHER_FILES += \
#    tileoverlay.json \
#    place_data.json
#RESOURCES += testdata.qrc

#PLUGIN_TYPE = geoservices
#PLUGIN_CLASS_NAME = TestGeoServicePlugin
#load(qt_plugin)

# Use the following, instead, to build the plugin outside Qt
PLUGIN_TYPE = geoservices
PLUGIN_CLASS_NAME = TestGeoServicePlugin
TEMPLATE = lib
CONFIG += plugin relative_qt_rpath

DISTFILES += \
    tileoverlay_plugin.json

# Place the lib into a "geoservices" subdir, otherwise addLibraryPath wont work.
#DESTDIR = $$OUT_PWD/geoservices/
# Hardcoding the dest dir to be a subdir of the source dir
DESTDIR = $$PWD/bin/geoservices/
