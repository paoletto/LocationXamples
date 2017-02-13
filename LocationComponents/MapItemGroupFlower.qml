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

import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

    MapItemGroup {
        id: itemGroupFlower
        property alias position: mainCircle.center
        property var radius: 100 * 1000
        property var borderHeightPct : 0.3

        MapCircle {
            id: mainCircle
            center : QtPositioning.coordinate(55, 0)
            //radius: itemGroup.radius * (1.0 + borderHeightPct)
            radius: parent.radius * (1.0 + parent.borderHeightPct)
            opacity: 0.05
            visible: true
            color: 'blue'

            MouseArea{
                anchors.fill: parent
                drag.target: parent
                id: maItemGroup
            }
        }

        MapCircle {
            id: groupCircle
    //        center: itemGroup.position
    //        radius: itemGroup.radius
            center: parent.position
            radius: parent.radius
            color: 'crimson'

            onCenterChanged: {
                groupPolyline.populateBorder();
            }
        }

        MapPolyline {
            id: groupPolyline
            line.color: 'green'
            line.width: 3

            function populateBorder() {
                groupPolyline.path = [] // clearing the path
                var waveLength = 8.0;
                var waveAmplitude = groupCircle.radius * parent.borderHeightPct;
                for (var i=0; i <= 360; i++) {
                    var wavePhase = (i/360.0 * 2.0 * Math.PI )* waveLength
                    var waveHeight = (Math.cos(wavePhase) + 1.0) / 2.0
                    groupPolyline.addCoordinate(groupCircle.center.atDistanceAndAzimuth(groupCircle.radius + waveAmplitude * waveHeight , i))
                }
            }

            Component.onCompleted: {
                populateBorder()
            }
        }
    }


