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
    width: 512
    height: 512

    GeoservicePlugins {
        id: plugins
    }

    Button {
        id: vaButton
        anchors.top: parent.top
        anchors.right: parent.horizontalCenter
        anchors.topMargin: 32
        width: 64
        height: 32
        z : 100

        text: "full"
        onClicked: {
            console.log("Setting visible area to "+ Qt.rect(0,0,win.width,win.height))
            map.visibleArea = Qt.rect(0,0,win.width,win.height)
        }
    }

    Button {
        id: vaButton2
        anchors.top: parent.top
        anchors.left: parent.horizontalCenter
        anchors.topMargin: 32
        width: 64
        height: 32
        z : 100

        text: "256"
        onClicked: {
            console.log("Setting visible area to "+ Qt.rect(0,256,256,256))
            map.visibleArea = Qt.rect(0,256,256,256)
        }
    }

    Button {
        id: b3
        anchors.top: parent.top
        anchors.left: vaButton2.right
        anchors.topMargin: 32
        width: 64
        height: 32
        z : 100

        text: "fit"
        onClicked: {
            map.visibleRegion = circle.geoShape
            var poly = QtPositioning.shapeToPolygon(map.visibleRegion)
            console.log(poly)
        }
    }

    //    Map {
    //        id: baseMap
    //        anchors.fill: parent
    //        opacity: 1.0
    //        color: 'transparent'
    //        plugin: plugins.osm
    //        gesture.enabled: false
    //        center: map.center
    //        tilt: map.tilt
    //        bearing: map.bearing
    //        fieldOfView: map.fieldOfView
    //        zoomLevel: map.zoomLevel
    //        visibleArea: map.visibleArea
    //    }

    MapWithSliders {
//        z: baseMap.z + 1
        id: map
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        plugin: plugins.osm
//        plugin: Plugin {name: "mapboxgl" }
        center: QtPositioning.coordinate(45,10)
        zoomLevel: 4.0
        fieldOfView: 36.87
        //visibleArea : Qt.rect(128,128,384,384)

        function coord(pt) {
            var crd = map.toCoordinate(pt)
            return Qt.point(crd.latitude, crd.longitude)
        }

        MouseArea {
            id: ma
            anchors.fill: parent
            onClicked: {
                var pt = Qt.point(mouseX, mouseY)
                console.log("clicked",pt, map.coord(pt))
                console.log("center at: ", map.fromCoordinate(map.center))
            }
        }

        MapQuickItem {
            coordinate: QtPositioning.coordinate(45,10) //positionSource.position.coordinate // invalid coordinate or null
            visible: true
            anchorPoint.x: rect.width * 0.5
            anchorPoint.y: rect.height * 0.5

            zoomLevel: 4

            sourceItem: Rectangle {
                id: rect
                width: 16
                height: 16
                color: "blue"
                opacity: 0.8
                radius: width/2

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("CLICKED!")
                    }
                }
            }
        }

        MapCircle {
            id: circle
            center: QtPositioning.coordinate(44,10)
            color: 'green'
            border.width: 0
            radius: 50 * 1000

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("CLICKED2!")
                }
            }
        }
    }
}
