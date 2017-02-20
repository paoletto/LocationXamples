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
    width: 1280
    height: 720
    property var copyVisible : false

    GeoservicePlugins {
        id: plugins
    }

    Map {
        id: mapBase
        opacity: 1.0
        anchors.fill: parent
        plugin: plugins.mapbox
        activeMapType: mapBase.supportedMapTypes[4]
        gesture.enabled: false
        center: map.center
        zoomLevel: map.zoomLevel
        tilt: map.tilt;
        bearing: map.bearing
        fieldOfView: map.fieldOfView
        z: parent.z + 1
        copyrightsVisible: win.copyVisible
    }

    MapWithSliders {
        id: map
        gesture.enabled: true
        objectName: "mapComponent"
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        plugin: testPlugin
        center: QtPositioning.coordinate(45,10)
        minimumZoomLevel: mapBase.minimumZoomLevel
        maximumZoomLevel: mapBase.maximumZoomLevel
//        minimumTilt: mapBase.minimumTilt
//        maximumTilt: mapBase.maximumTilt
//        minimumFieldOfView: mapBase.minimumFieldOfView
//        maximumFieldOfView: mapBase.maximumFieldOfView
        zoomLevel: 4
        z : mapBase.z + 1
        copyrightsVisible: win.copyVisible
    }

    Plugin {
        id: testPlugin;
        name: "tileoverlay";
        allowExperimental: true
        PluginParameter { name: "tileoverlay.backgroundColor"; value: "transparent"}
        PluginParameter { name: "tileoverlay.textColor"; value: "#A0FF0000"}
    }
}
