import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtPositioning 5.6
import QtLocation 5.9
import LocationComponents 1.0

Window {
    id: win
    visible: true
    width: 640
    height: 640
    property var copyVisible : false

    GeoservicePlugins {
        id: plugins
    }

    Map {
        id: mapBase
        opacity: 1.0
        anchors.fill: parent
        plugin: plugins.mapbox
        activeMapType: mapBase.supportedMapTypes[7]
        gesture.enabled: false
        center: map.center
        zoomLevel: map.zoomLevel
        tilt: map.tilt;
        bearing: map.bearing
        fieldOfView: map.fieldOfView
        z: parent.z + 1
        copyrightsVisible: win.copyVisible
    }

    Map {
        id: map
        gesture.enabled: true
        objectName: "mapComponent"
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        plugin: plugins.osm
        center: QtPositioning.coordinate(45,10)
        activeMapType: map.supportedMapTypes[7]
        zoomLevel: 4
        z : mapBase.z + 1
        copyrightsVisible: win.copyVisible
    }

    MapCrosshair {
        width: 20
        height: 20
        anchors.centerIn: parent
        z: map.z + 1
    }

    MapSliders {
        id: sliders
        z: map.z + 1
        map: map
    }
}
