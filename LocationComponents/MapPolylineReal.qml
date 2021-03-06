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


import QtLocation 5.9
import QtPositioning 5.9
import QtQuick 2.7

MapPolyline {
    line.width: 7
    line.color: 'deepskyblue'
    MouseArea{
        anchors.fill: parent
        drag.target: parent
    }
    path : [QtPositioning.coordinate(43.773175, 11.255386),
            QtPositioning.coordinate(43.773546 , 11.255372),
            QtPositioning.coordinate(43.77453 , 11.255734),
            QtPositioning.coordinate(43.774781 , 11.255828),
            QtPositioning.coordinate(43.775014 , 11.255123),
            QtPositioning.coordinate(43.775204 , 11.254521),
            QtPositioning.coordinate(43.775363 , 11.253992),
            QtPositioning.coordinate(43.775486 , 11.253609),
            QtPositioning.coordinate(43.775077 , 11.252986),
            QtPositioning.coordinate(43.774931 , 11.252746),
            QtPositioning.coordinate(43.774711 , 11.252419),
            QtPositioning.coordinate(43.774778 , 11.25229),
            QtPositioning.coordinate(43.774809 , 11.251065),
            QtPositioning.coordinate(43.774843 , 11.250919),
            QtPositioning.coordinate(43.774844 , 11.250815),
            QtPositioning.coordinate(43.775137 , 11.250577),
            QtPositioning.coordinate(43.77503 , 11.250166),
            QtPositioning.coordinate(43.775061 , 11.250004),
            QtPositioning.coordinate(43.775065 , 11.249956),
            QtPositioning.coordinate(43.775178 , 11.249807),
            QtPositioning.coordinate(43.775209 , 11.249711),
            QtPositioning.coordinate(43.775232 , 11.249688),
            QtPositioning.coordinate(43.775249 , 11.249568),
            QtPositioning.coordinate(43.775252 , 11.24953),
            QtPositioning.coordinate(43.775231 , 11.249087),
            QtPositioning.coordinate(43.775235 , 11.24897),
            QtPositioning.coordinate(43.775271 , 11.247805),
            QtPositioning.coordinate(43.775325 , 11.247684),
            QtPositioning.coordinate(43.775452 , 11.24748),
            QtPositioning.coordinate(43.775543 , 11.247398),
            QtPositioning.coordinate(43.775628 , 11.247345),
            QtPositioning.coordinate(43.775768 , 11.247234),
            QtPositioning.coordinate(43.775827 , 11.247141),
            QtPositioning.coordinate(43.775852 , 11.247111),
            QtPositioning.coordinate(43.775883 , 11.247072),
            QtPositioning.coordinate(43.775918 , 11.247028),
            QtPositioning.coordinate(43.775987 , 11.246942),
            QtPositioning.coordinate(43.776077 , 11.246827),
            QtPositioning.coordinate(43.776153 , 11.246731),
            QtPositioning.coordinate(43.776272 , 11.246579),
            QtPositioning.coordinate(43.776452 , 11.246347),
            QtPositioning.coordinate(43.776636 , 11.246122),
            QtPositioning.coordinate(43.776683 , 11.246084),
            QtPositioning.coordinate(43.776744 , 11.246036),
            QtPositioning.coordinate(43.776786 , 11.246003),
            QtPositioning.coordinate(43.77701 , 11.245844),
            QtPositioning.coordinate(43.777194 , 11.245729),
            QtPositioning.coordinate(43.77723 , 11.245718),
            QtPositioning.coordinate(43.77724 , 11.245718),
            QtPositioning.coordinate(43.777265 , 11.245717),
            QtPositioning.coordinate(43.77728 , 11.245718),
            QtPositioning.coordinate(43.777303 , 11.245719),
            QtPositioning.coordinate(43.77734 , 11.245722),
            QtPositioning.coordinate(43.777377 , 11.245722),
            QtPositioning.coordinate(43.777409 , 11.245718),
            QtPositioning.coordinate(43.777433 , 11.245704),
            QtPositioning.coordinate(43.777453 , 11.245674),
            QtPositioning.coordinate(43.77746 , 11.245644),
            QtPositioning.coordinate(43.777462 , 11.245621),
            QtPositioning.coordinate(43.777453 , 11.245565),
            QtPositioning.coordinate(43.77745 , 11.245501),
            QtPositioning.coordinate(43.777465 , 11.245441),
            QtPositioning.coordinate(43.777986 , 11.244386)]
}
