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
    width: 960
    height: 960
    objectName: "win"
    property var copyVisible : false

    GeoservicePlugins {
        id: plugins
    }

    FpsMeter {
        z: map.z + 1
    }

    Map {



        id: map
        gesture.enabled: true
        objectName: "mapComponent"

//        width: win.width / 2
//        height: win.height / 2
        width: win.width
        height: win.height
        anchors.centerIn: parent

        opacity: 1.0
        color: 'transparent'
        plugin: plugins.mapboxgl
        center: QtPositioning.coordinate(45,10)
        activeMapType: map.supportedMapTypes[0]
        zoomLevel: 1.5
        z : parent.z + 1
        copyrightsVisible: win.copyVisible

        MapSliders {
            id: sliders
            z: parent.z + 1
            mapSource: map
            edge: Qt.RightEdge
        }

        MapPolyline {
            id: timeline
            line.color: "red"
            line.width: 4
            path: [
                { latitude: 90, longitude: 180 },
                { latitude: -90, longitude: -180 }
            ]
        }


        LongPoly {
            id: longPoly
            MouseArea {
                anchors.fill: parent
                drag.target: parent
                onPressed: {
                    console.log("pressed")
                }
            }

        }
        Rectangle {
            x: longPoly.x
            y: longPoly.y
            width: longPoly.width
            height: longPoly.height
            color: "transparent"
            border.color: "red"
        }

        onMapReadyChanged: {
//            var path = QtPositioning.path()

//            console.log(path.size())

//            var polyPath = QtPositioning.shapeToPath(longPoly.geoShape)
//            console.log(polyPath.size())

//            path.path = polyPath.path
//            console.log(path.size())

//            path.removeCoordinate(0)
//            console.log(path.size(), polyPath.size())
        }

//        LongPoly {
//            id: poly2
//        }

//        onMapReadyChanged: {
//            poly2.x = poly2.x - 100
//        }
    }
}
