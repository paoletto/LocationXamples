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

Window {
    id: win
    visible: true
    width: 640
    height: 640
    property var copyVisible : false

    Map {
        id: map
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        plugin: Plugin { name: "osm" }
        center: QtPositioning.coordinate(45,10)
        activeMapType: map.supportedMapTypes[0]
        zoomLevel: 4
        copyrightsVisible: win.copyVisible


        property real transitionDuration: 300;

        PropertyAnimation {
            id: zlAnim;
            target: map;
            property: "zoomLevel";
            duration: map.transitionDuration * 2
            easing.type: Easing.Bezier
            easing.bezierCurve: [0.47,1.03,0.36,0.944,1,1]
        }

        CoordinateAnimation {
            id: centerAnim;
            target: map;
            property: "center";
            duration: map.transitionDuration
            //easing.type: Easing.Linear
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
