import QtQuick 2.7
import QtLocation 5.9

Map {
    id: mapp
    anchors.fill: parent
    opacity: 1.0
    color: 'transparent'
    center: QtPositioning.coordinate(45,10)
    zoomLevel: 4

    onZoomLevelChanged: {
        console.log("zl "+zoomLevel)
    }

    MapCrosshair {
        width: 20
        height: 20
        anchors.centerIn: parent
        z: parent.z + 1
    }

    MapSliders {
        id: sliders
        z: parent.z + 1
        map: mapp
    }
}

