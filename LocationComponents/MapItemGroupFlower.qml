import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

    MapItemGroup {
        id: itemGroupFlower
        property alias position: mainCircle.center
        property var radius: 100 * 1000
        property var borderHeightPct : 0.3

        MapCircle {
            id: mainCircle
            center : QtPositioning.coordinate(55, 0)
            //radius: itemGroup.radius * (1.0 + borderHeightPct)
            radius: parent.radius * (1.0 + parent.borderHeightPct)
            opacity: 0.05
            visible: true
            color: 'blue'

            MouseArea{
                anchors.fill: parent
                drag.target: parent
                id: maItemGroup
            }
        }

        MapCircle {
            id: groupCircle
    //        center: itemGroup.position
    //        radius: itemGroup.radius
            center: parent.position
            radius: parent.radius
            color: 'crimson'

            onCenterChanged: {
                groupPolyline.populateBorder();
            }
        }

        MapPolyline {
            id: groupPolyline
            line.color: 'green'
            line.width: 3

            function populateBorder() {
                groupPolyline.path = [] // clearing the path
                var waveLength = 8.0;
                var waveAmplitude = groupCircle.radius * parent.borderHeightPct;
                for (var i=0; i <= 360; i++) {
                    var wavePhase = (i/360.0 * 2.0 * Math.PI )* waveLength
                    var waveHeight = (Math.cos(wavePhase) + 1.0) / 2.0
                    groupPolyline.addCoordinate(groupCircle.center.atDistanceAndAzimuth(groupCircle.radius + waveAmplitude * waveHeight , i))
                }
            }

            Component.onCompleted: {
                populateBorder()
            }
        }
    }


