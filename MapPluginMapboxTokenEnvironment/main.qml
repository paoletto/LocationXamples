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

    Map {
        id: map
        anchors.fill: parent
        opacity: 1.0
        plugin: mapboxPlugin
        center: QtPositioning.coordinate(45,10)
        activeMapType: map.supportedMapTypes[0]
        zoomLevel: 4
    }

    Plugin {
        id: mapboxPlugin
        name: 'mapbox';
        PluginParameter {
            id: tokenParam
            name: "mapbox.access_token"
            value: SystemEnvironment.variable("MAPBOX_ACCESS_TOKEN")
            // This works:
            //value: "<yourtoken>"
            Component.onCompleted: {
                console.log("tokenParam "+tokenParam.value)
            }
        }
        Component.onCompleted: {
            console.log("mapboxPlugin "+tokenParam.value)
        }
    }
}
