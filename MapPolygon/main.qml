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
    objectName: "win"
    property var copyVisible : false

    GeoservicePlugins {
        id: plugins
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
        plugin: plugins.osm
        center: QtPositioning.coordinate(45,10)
        activeMapType: map.supportedMapTypes[2]
        zoomLevel: 2
        z : parent.z + 1
        copyrightsVisible: win.copyVisible

//        MapCrosshair {
//            width: 20
//            height: 20
//            anchors.centerIn: parent
//            z: parent.z + 1
//        }

        MapSliders {
            id: sliders
            z: parent.z + 1
            mapSource: map
            edge: Qt.RightEdge
        }

        property matrix4x4 proj: Qt.matrix4x4()
        function updateProj() {
            map.proj = map.projectionTransformation()
            console.log(map.proj)
        }

        onZoomLevelChanged: updateProj()
        onWidthChanged: updateProj()
        onHeightChanged: updateProj()
        onCenterChanged: updateProj()
        onTiltChanged: updateProj()
        onBearingChanged: updateProj()
        onFieldOfViewChanged: updateProj()

        MapPolygon {
            id: poly
            objectName: "bloodyPoly"
            transform: Matrix4x4 {
                matrix: map.proj
            }

            color: "red"
            path: [
                { latitude: 45, longitude: -60 },
                { latitude: 45, longitude: 60 },
                { latitude: -45, longitude: 60 },
                { latitude: -45, longitude: -60 }
            ]

            Drag.onDragStarted: {
                console.log("drag started")
            }

            onXChanged: {
                console.log("POLY SIZE"+poly.x + "," + poly.y + " " + poly.width+"x"+poly.height)

            }

            onWidthChanged: {
                console.log("POLY SIZE"+poly.x + "," + poly.y + " " + poly.width+"x"+poly.height)

            }

            MouseArea{
                id:ma
                objectName: "maPoly"
                anchors.fill: parent
                drag.target: parent

//                x: parent.x
//                y: parent.y

                preventStealing: true

                onClicked: {
                    console.log("CLICKED")
                }

                onPressed: {
                    console.log("CLICKED")
                }
                onDoubleClicked: {
                    console.log("CLICKED")
                }

                onHeightChanged: {
                    console.log("MA SIZE "+ma.x + "," + ma.y + " " + ma.width+"x"+ma.height)
                }

                onXChanged: {
                    console.log("MA SIZE X "+ma.x + "," + ma.y + " " + ma.width+"x"+ma.height)
                }
            }
        }

        onMapReadyChanged: {
            console.log("polySize: " + poly.width + " " + poly.height);
            console.log("polyPos: " + poly.x + " " + poly.y);
        }
    }
}
