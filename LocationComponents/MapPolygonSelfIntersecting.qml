import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

    MapPolygon {
        id: selfIntersectingPolygon
        color: 'darkmagenta'
        opacity: 1.0
        path: [
            { latitude: 19, longitude: 49 },
            { latitude: 18, longitude: 49 },
            { latitude: 18, longitude: 51 },
            { latitude: 20, longitude: 51 },
            { latitude: 20, longitude: 50 },
            { latitude: 18.5, longitude: 50 },
            { latitude: 18.5, longitude: 52 },
            { latitude: 19, longitude: 52 }
        ]

        MouseArea{
            anchors.fill: parent
            drag.target: parent
        }
    }

