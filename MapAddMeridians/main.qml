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
import QtQuick.Controls.Styles 1.4
import QtPositioning 5.6
import QtLocation 5.9
import LocationComponents 1.0

Window {
    id: win
    visible: true
    width: 640
    height: 640
    property var copyVisible : true

//    GeoservicePlugins {
//        id: plugins
//    }

    Item {
        id: mapContainer
        anchors.fill: parent

        property var center : mapItems.center
        property var zoomLevel: mapItems.zoomLevel
        property var tilt: mapItems.tilt
        property var bearing: mapItems.bearing
        property var fieldOfView: mapItems.fieldOfView


        Map {
            id: mapItems
            anchors.fill: parent
            opacity: 1.0
            color: 'transparent'
            plugin: Plugin { name: "itemsoverlay" }
            center: QtPositioning.coordinate(45,10)
            activeMapType: mapItems.supportedMapTypes[0]
            zoomLevel: 4
            copyrightsVisible: false
            z: parent.z + 100 // Topmost

            Component.onCompleted: {
                LocationTools.addMeridians(mapItems, "fuchsia", 1)
                LocationTools.addParallels(mapItems, "green", 1)
            }

            property real transitionDuration: 300;

            PropertyAnimation {
                id: zlAnim;
                target: mapItems;
                property: "zoomLevel";
                duration: mapItems.transitionDuration
            }

            CoordinateAnimation {
                id: centerAnim;
                target: mapItems;
                property: "center";
                duration: mapItems.transitionDuration
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onDoubleClicked: {
                    centerAnim.from = parent.center
                    centerAnim.to = parent.toCoordinate(Qt.point(mouse.x, mouse.y))
                    if (mouse.button === Qt.LeftButton) {
                        zlAnim.from = parent.zoomLevel
                        zlAnim.to = Math.floor(parent.zoomLevel + 1)
                    } else if (mouse.button === Qt.RightButton) {
                        zlAnim.from = parent.zoomLevel
                        zlAnim.to = Math.floor(parent.zoomLevel - 1)
                    }
                    zlAnim.start()
                    centerAnim.start()
                }
            }
        }
    }



    MapCrosshair {
        width: 20
        height: 20
        anchors.centerIn: parent
        z: mapItems.z + 1
    }

    LocationMenuBar {
        id: menuBar
        edge: Qt.LeftEdge
        mapSource: mapItems
        mapContainer: mapContainer
        //pluginParametersJsonURL: someUrl  // define this if QTLOCATION_PLUGIN_PARAMETERS_URL isn't present
    }
}
