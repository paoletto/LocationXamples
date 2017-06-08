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

    MapWithSliders {
        id: map
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        //plugin: tilting
        plugin: plugins.osm
        //plugin: itemsoverlay
        center: QtPositioning.coordinate(18.859820495687384, 50.164062499994515)//QtPositioning.coordinate(45,10)
        //activeMapType: map.supportedMapTypes[0]
        zoomLevel: 2.0
        copyrightsVisible: win.copyVisible
        fieldOfView: 90

        MapQuickItemQt {
            zoomLevel: 1.32
            anchorPoint.x: sourceItem.width / 2
            anchorPoint.y: sourceItem.height / 2
            //z: 456
        }

        MapQuickItemQt {
            //zoomLevel: 1.32
            coordinate: QtPositioning.coordinate(35, 0)
            anchorPoint.x: sourceItem.width / 2
            anchorPoint.y: sourceItem.height / 2
            //z: 456
        }

        MapQuickItem {
            id: markerTest
            z: 10

            zoomLevel: 2.0

            coordinate { latitude: 42.350000000; longitude: -71.0}

            sourceItem: Rectangle {
                id: isSelectedMarker

                width: testRectangle.height * 1.3
                radius: width/2
                height: width
                color: "transparent"
                border.color: "black"

                Rectangle {
                    id: testRectangle
                    anchors.centerIn: parent
                    width: 20
                    height: 40
                    color: "red"
                    opacity: markerMouseArea.pressed ? 0.6 : 1.0

//                    MouseArea  {
//                        id: markerMouseArea
//                        anchors.fill: isSelectedMarker
//                        drag.target: markerTest
//                    }
                }

                MouseArea  {
                    id: markerMouseArea
                    anchors.fill: isSelectedMarker
                    drag.target: markerTest
                }
            }
        }
    }

    Plugin {
        id: tilting
        name: "tilting"
    }
    Plugin {
        id: itemsoverlay
        name: "itemsoverlay"
    }
}



// Simpler example
//import QtQuick 2.7
//import QtQuick.Window 2.2
//import QtQuick.Controls 1.4
//import QtPositioning 5.6
//import QtLocation 5.9
//import LocationComponents 1.0
//Window {
//    id: win
//    visible: true
//    width: 640
//    height: 640

//    Map {
//        id: map
//        anchors.fill: parent
//        plugin: Plugin { name: "osm" }
//        center: QtPositioning.coordinate(18.859820495687384, 50.164062499994515)
//        zoomLevel: 18.0
//        tilt: 70
//        bearing: 180
//        fieldOfView: 90

//        MapQuickItem {
//            id: mqi
//            zoomLevel: 1.32
//            anchorPoint.x: sourceItem.width / 2
//            anchorPoint.y: sourceItem.height / 2
//            coordinate: QtPositioning.coordinate(19,50)

//            sourceItem: Rectangle{
//                width:40
//                height:40
//                color:'red'

//                MouseArea{
//                    anchors.fill: parent
//                    drag.target: mqi
//                }
//            }
//        }
//    }
//}
