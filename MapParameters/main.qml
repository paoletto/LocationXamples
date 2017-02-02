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

    GeoservicePlugins {
        id: plugins
    }

    MapWithSliders {
        id: map
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        plugin: plugins.mapboxgl
        center: QtPositioning.coordinate(45,10)
        activeMapType: map.supportedMapTypes[1]
        zoomLevel: 4
    }
}
