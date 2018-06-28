TEMPLATE = lib
CONFIG += qt plugin
QT += qml quick

DESTDIR = $$PWD/../bin/imports/
TARGET = locationcomponents

HEADERS += qmlsystemenvironment.h \
           locationcomponents.h

SOURCES += plugin.cpp \
           qmlsystemenvironment.cpp

RESOURCES += LocationComponents.qrc


OTHER_FILES +=  LocationComponents.pri \
                qmldir \
                Slide.qml \
                LocationTools.js \
                GeoservicePlugins.qml \
                MapCircleBothPoles.qml \
                MapCircleNorthPole.qml \
                MapCircleSouthPole.qml \
                MapCircleWithBoundingBox.qml \
                MapCrosshair.qml \
                MapItemGroupFlower.qml \
                MapPolygonSelfIntersecting.qml \
                MapPolylineUSA.qml \
                MapQuickItemQt.qml \
                MapSliders.qml \
                PluginManager.qml \
                LocationMenuBar.qml \
                MapWithSliders.qml \
                LayerManager.qml \
                PanelToggler.qml \
                DraggableItem.qml \
                LongPoly.qml \
                LocationComponents.qrc

DISTFILES += \
    MapMarker.qml \
    FpsMeter.qml \
    MapPolylineReal.qml \
    MediumPoly.qml



