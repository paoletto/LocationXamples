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

function addMapMarkers(map, latitudeDelta, longitudeDelta)
{
    var cnt = 0
    for (var longi=-180; longi<180; longi = longi + longitudeDelta) {
        for (var lati=-90; lati<=90; lati = lati + longitudeDelta) {
            var marker = Qt.createQmlObject ("import QtQuick 2.5;"
                                          +"import QtLocation 5.6;"
                                          +"MapMarker {"
                                          +" w: 16; h: 16;"
                                          +" coordinate {"
                                          +"  latitude: "+ lati +";"
                                          +"  longitude: "+ longi +";"
                                          +" }"
                                          +"}", map)
            map.addMapItem(marker)
            cnt += 1
        }
    }
    console.log("Added " + cnt + " markers")
}

function addMeridians(map, color, thickness)
{
    var longi = -180.0
    for (var i=0; i<36; i++) {
        var meridianColor = color
        if (longi == -180.0)
            meridianColor = "red"
        var line = Qt.createQmlObject ("import QtQuick 2.5;"
                                      +"import QtLocation 5.6;"
                                      +"MapPolyline {"
                                      +"line.width: "+ thickness +";"
                                      +"line.color: '"+meridianColor+"'"
                                      +"}", map)
        line.addCoordinate(QtPositioning.coordinate(90,longi))
        line.addCoordinate(QtPositioning.coordinate(-90,longi))
        line.opacity = 0.4
        map.addMapItem(line)
        longi = longi + 10.0
    }
}

function addParallels(map, color, thickness)
{
    var lati = -80.0
    for (var i=0; i<16; i++) {
        var parallelColor = color
        if (lati == 0.0)
            parallelColor = "red"
/* Single line, disappears very easily
        var line = Qt.createQmlObject ("import QtQuick 2.5;"
                                      +"import QtLocation 5.6;"
                                      +"MapPolyline {"
                                      +"line.width: "+ thickness +";"
                                      +"line.color: '"+parallelColor+"'"
                                      +"}", map)
        line.addCoordinate(QtPositioning.coordinate(lati,-180.0))
        line.addCoordinate(QtPositioning.coordinate(lati, -90.0))
        line.addCoordinate(QtPositioning.coordinate(lati,   0.0))
        line.addCoordinate(QtPositioning.coordinate(lati,  90.0))
        line.addCoordinate(QtPositioning.coordinate(lati, 179.9))
        line.opacity = 0.4
        map.addMapItem(line)
*/
        // one line per sector

        var longi = -180.0
        for (var j=0; j<36; j++) {
            var line = Qt.createQmlObject ("import QtQuick 2.5;"
                                          +"import QtLocation 5.6;"
                                          +"MapPolyline {"
                                          +"line.width: "+ thickness +";"
                                          +"line.color: '"+parallelColor+"'"
                                          +"}", map)

            line.addCoordinate(QtPositioning.coordinate(lati,longi))
            line.addCoordinate(QtPositioning.coordinate(lati,longi + 10.0))
            line.opacity = 0.4
            map.addMapItem(line)
            longi = longi + 10.0
        }

        lati = lati + 10.0
    }
}
