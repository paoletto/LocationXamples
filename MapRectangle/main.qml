/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

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
        id: map
        anchors.centerIn: parent
        width: parent.width * 0.9
        height: parent.height * 0.9
        opacity: 1.0
        color: 'transparent'
        plugin: plugins.osm
        activeMapType: map.supportedMapTypes[0]

//        center: QtPositioning.coordinate(59.91, 10.75) // Oslo
//        zoomLevel: 14

        center: QtPositioning.coordinate(45,10)
        zoomLevel: 4

        copyrightsVisible: win.copyVisible

        MapRectangle {
            topLeft: QtPositioning.coordinate(40, 10)
            bottomRight: QtPositioning.coordinate(38, 13)
            color: "deepskyblue"
            //x: 40
            //width: 300

           MouseArea {
              anchors.fill: parent
              drag.target: parent
           }
        }

        MapCircle {
            center: QtPositioning.coordinate(40, 10)
            radius: 100000
            color: "deepskyblue"
            //x: 40
            //width: 300

           MouseArea {
              anchors.fill: parent
              drag.target: parent
           }
        }

        MapPolygon {
            id: poly
            objectName: "bloodyPoly"

            color: "red"
            path: [
                { latitude: 45, longitude: -60 },
                { latitude: 45, longitude: 60 },
                { latitude: -45, longitude: 60 },
                { latitude: -45, longitude: -60 }
            ]

            MouseArea{
                id:ma
                objectName: "maPoly"
                anchors.fill: parent
                drag.target: parent
            }
        }

        MapPolygon {
            id: poly2


            color: "green"
            path: [
                { latitude: 45, longitude: -60 },
                { latitude: 45, longitude: -50 },
                { latitude: 35, longitude: -50 },
                { latitude: 35, longitude: -60 }
            ]

            MouseArea{
                id:ma2
                objectName: "maPoly"
                anchors.fill: parent
                drag.target: parent
            }
        }

        function printCoords()
        {
            return;
            var coord1 = map.toCoordinate(Qt.point(width/2, height/2))
            var coord2 = map.toCoordinate(Qt.point(width/2, 0))
            var coord3 = map.toCoordinate(Qt.point(width/2, -200), false)
            console.log(coord1.latitude, coord1.longitude)
            console.log(coord2.latitude, coord2.longitude)
            console.log(coord3.latitude, coord3.longitude)
        }

        onMapReadyChanged: {
            console.log("MAPREADY")
            printCoords()
        }

        onTiltChanged: {
            printCoords()
        }


//        MapRectangle {
//           id: blueRect_
//           topLeft: QtPositioning.coordinate(59.91, 10.75)
//           bottomRight: QtPositioning.coordinate(59.90, 10.76) // QtPositioning.coordinate(topLeft.latitude - 0.01, topLeft.longitude + 0.01)
//           color: "blue"

//           MouseArea {
//              anchors.fill: parent
//              drag.target: parent
//           }

////           onXChanged: {
////               console.log( "blue", x, y, width, height, topLeft.latitude, topLeft.longitude, bottomRight.latitude, bottomRight.longitude )
////           }

////           onYChanged: {
////              console.log( "blue", x, y, width, height, topLeft.latitude, topLeft.longitude, bottomRight.latitude, bottomRight.longitude )
////           }
//        }


    }
}
