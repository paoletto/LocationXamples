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
        gesture.enabled: true
        objectName: "mapComponent"
        anchors.fill: parent

        opacity: 1.0
        color: 'transparent'
        plugin: plugins.osm
        center: QtPositioning.coordinate(19,49)
        activeMapType: map.supportedMapTypes[2]
        zoomLevel: 7
        z : parent.z + 1
        copyrightsVisible: win.copyVisible

//        MapPolygonSelfIntersecting {
//            id: selfIntersectingPolygon
//            border.color: Qt.rgba(0,0,1,0.3)
//            //border.width: 26
//            border.width: 26


////            layer.enabled: true
////            layer.samples: 4
//            visible: true
//        }

        MapCircle {
            id: circle
            //border.color: Qt.rgba(0,0,1,0.3)
            border.color: 'deepskyblue'
            border.width: 26
            center: QtPositioning.coordinate(19, 49);
            radius: 200*1000
            color: "firebrick"

            layer.enabled: true
            layer.samples: 4
        }

//        MapPolyline {
//            id: selfIntersectingPolyline
//            line.color: 'deepskyblue'
//            line.width: 26
//            opacity: 1.0
//            path: [
//                { latitude: 19, longitude: 49 },
//                { latitude: 18, longitude: 49 },
//                { latitude: 18, longitude: 51 },
//                { latitude: 20, longitude: 51 },
//                { latitude: 20, longitude: 50 },
//                { latitude: 18.5, longitude: 50 },
//                { latitude: 18.5, longitude: 52 },
//                { latitude: 19, longitude: 52 }
//            ]

//            MouseArea{
//                anchors.fill: parent
//                drag.target: parent
//            }

//            layer.enabled: true
//            layer.samples: 4
//        }

//        MapPolyline {
//            id: selfIntersectingPolyline2
//            line.color: 'firebrick'
//            line.width: 4
//            opacity: 1.0
//            path: [
//                { latitude: 19, longitude: 49 },
//                { latitude: 18, longitude: 49 },
//                { latitude: 18, longitude: 51 },
//                { latitude: 20, longitude: 51 },
//                { latitude: 20, longitude: 50 },
//                { latitude: 18.5, longitude: 50 },
//                { latitude: 18.5, longitude: 52 },
//                { latitude: 19, longitude: 52 }
//            ]

//            MouseArea{
//                anchors.fill: parent
//                drag.target: parent
//            }
//        }

//        MapPolyline {
//            id: selfIntersectingPolyline3
//            line.color: 'black'
//            line.width: 1
//            opacity: 1.0
//            path: [
//                { latitude: 19, longitude: 49 },
//                { latitude: 18, longitude: 49 },
//                { latitude: 18, longitude: 51 },
//                { latitude: 20, longitude: 51 },
//                { latitude: 20, longitude: 50 },
//                { latitude: 18.5, longitude: 50 },
//                { latitude: 18.5, longitude: 52 },
//                { latitude: 19, longitude: 52 }
//            ]

//            MouseArea{
//                anchors.fill: parent
//                drag.target: parent
//            }
//        }

        MapCrosshair {
            width: 20
            height: 20
            anchors.centerIn: parent
            z: parent.z + 1
        }

        MapSliders {
            id: sliders
            z: parent.z + 1
            mapSource: map
            edge: Qt.RightEdge
        }
    }
}
