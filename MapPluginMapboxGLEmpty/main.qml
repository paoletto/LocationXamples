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
//    color: 'transparent'


    property var boundary : [QtPositioning.coordinate( 10, -10),
                             QtPositioning.coordinate( 10,  10),
                             QtPositioning.coordinate(-10,  10),
                             QtPositioning.coordinate(-10, -10)]

    property var hole1 : [QtPositioning.coordinate( 5, -5),
                QtPositioning.coordinate( 5,  5),
                QtPositioning.coordinate(-5,  5),
                QtPositioning.coordinate(-5, -5)]

    property var hole2 : [QtPositioning.coordinate( 7, 7),
                QtPositioning.coordinate( 7, 8),
                QtPositioning.coordinate(8,  8),
                QtPositioning.coordinate(8, 7)]

    property var holes : [hole1, hole2]

    property int baseZ: 2
    Map {
        id: baseMap
        anchors.fill: parent
        plugin: Plugin { name: "osm" }
        gesture.enabled: false
        center: map.center
        zoomLevel: map.zoomLevel
        tilt: map.tilt
        bearing: map.bearing
        fieldOfView: map.fieldOfView
        z: baseZ
    }

    MapWithSliders {
        id: map
        anchors.fill: parent
        opacity: 1
        z: baseZ + 1
        color: 'transparent'
        plugin: Plugin {
            name: "mapboxgl"
             PluginParameter {
                 name: "mapboxgl.mapping.additional_style_urls"
                 value: "qrc:/empty.json"
             }
        }
        center: QtPositioning.coordinate(45,10)
        activeMapType: map.supportedMapTypes[0]
        zoomLevel: 3

        onMapReadyChanged: {
            for (var i = 0; i < map.supportedMapTypes.length; i++) {
                console.log(map.supportedMapTypes[i].name)
            }
        }

        MapPolyline {
            id: timeline
            line.color: "red"
            line.width: 4
            path: [
                { latitude: 90, longitude: 180 },
                { latitude: -90, longitude: 180 }
            ]
        }

        MapPolygon {
            id: holed
            color: "firebrick"
            geoShape: QtPositioning.polygon(boundary, holes)
        }


        MapPolygon {
            id: poly1
            color: "red"
            path: [
                { latitude: 45, longitude: 170 },
                { latitude: 55, longitude: -175 },
                { latitude: 45, longitude: -160 },
                { latitude: 35, longitude: 178 }
            ]
        }

        MapPolygon {
            id: poly2
            color: "green"
            path: [
                { latitude: -45, longitude: -170 },
                { latitude: -55, longitude: -155 },
                { latitude: -45, longitude: -130 },
                { latitude: -35, longitude: -155 }
            ]
        }

        MapPolygon {
            id: poly3
            color: "deepskyblue"
            path: [
                { latitude: 65, longitude: -20 },
                { latitude: 75, longitude: 140 },
                { latitude: 65, longitude: 80 },
                { latitude: 55, longitude: -30 }
            ]
        }
    }
}
