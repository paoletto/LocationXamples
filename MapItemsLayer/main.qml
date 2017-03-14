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

    Map {
        id: mapBase
        gesture.enabled: false
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        plugin: osmPlugin

        activeMapType: supportedMapTypes[0]

        z : mapOverlay.z - 1
        copyrightsVisible: win.copyVisible

        center: mapOverlay.center
        minimumFieldOfView: mapOverlay.minimumFieldOfView
        maximumFieldOfView: mapOverlay.maximumFieldOfView
        minimumTilt: mapOverlay.minimumTilt
        maximumTilt: mapOverlay.maximumTilt
        minimumZoomLevel: mapOverlay.minimumZoomLevel
        maximumZoomLevel: mapOverlay.maximumZoomLevel
        zoomLevel: mapOverlay.zoomLevel
        tilt: mapOverlay.tilt;
        bearing: mapOverlay.bearing
        fieldOfView: mapOverlay.fieldOfView
    }

    Map {
        id: mapOverlay
        opacity: 1.0
        anchors.fill: parent
        plugin: nomap
        zoomLevel: 4
        center: QtPositioning.coordinate(45,10)

        color: 'transparent'



        z: parent.z + 2
        copyrightsVisible: win.copyVisible

        MapItemGroupFlower {
            id: itemGroup
        }

        // The code below to enable SSAA
        layer.enabled: true
        layer.smooth: true
        property int w : mapOverlay.width
        property int h : mapOverlay.height
        property int pr: Screen.devicePixelRatio
        layer.textureSize: Qt.size(w  * 2 * pr, h * 2 * pr)
    }


    MapCrosshair {
        width: 20
        height: 20
        anchors.centerIn: parent
        z: mapOverlay.z + 1
    }

    MapSliders {
        id: sliders
        z: mapOverlay.z + 1
        mapSource: mapOverlay
    }

    Plugin {
        id: osmPlugin
        name: "osm"
        PluginParameter{ name: "osm.mapping.custom.host"; value: "http://c.tiles.wmflabs.org/hillshading/"}
        PluginParameter{ name: "osm.mapping.custom.mapcopyright"; value: "The <a href='https://wikimediafoundation.org/wiki/Terms_of_Use'>WikiMedia Foundation</a>"}
    }

    Plugin {
        id: nomap
        name: "itemsoverlay"
    }
}
