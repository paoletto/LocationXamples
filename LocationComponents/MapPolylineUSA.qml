import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

MapPolyline {
    line.width: 7
    line.color: 'deepskyblue'
    path: [
        { latitude: 40, longitude: -60.0 },
        { latitude: 55, longitude: -120.0 },
        { latitude: 62, longitude: -100.0 }
    ]

    MouseArea{
        anchors.fill: parent
        drag.target: parent
        preventStealing: true
    }
}

