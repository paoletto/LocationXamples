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
import QtMultimedia 5.8

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
        plugin: plugins.osm
        zoomLevel: 16.7
        activeMapType: map.supportedMapTypes[0]
        fieldOfView: 90
        center: QtPositioning.coordinate(37.562984, -122.514426)

        MapPolygon {
            color: "transparent"
            border.color: "red"
            path: [
                { longitude: -122.51596391201019, latitude: 37.56238816766053},
                { longitude: -122.51467645168304, latitude: 37.56410183312965},
                { longitude: -122.51309394836426, latitude: 37.563391708549425},
                { longitude: -122.51423120498657, latitude: 37.56161849366671}
            ]
            z: markerTest.z + 1
        }

        onSupportedMapTypesChanged: {
            markerTest.updateSize()
        }

        MapQuickItem {
            id: markerTest

            coordinate: QtPositioning.coordinate(37.56238816766053, -122.51596391201019)
            zoomLevel: 17

            function updateSize() {
                map.zoomLevel = 17
                var tl = map.fromCoordinate(QtPositioning.coordinate(37.56238816766053,
                                                                                   -122.51596391201019), false)
                var tr = map.fromCoordinate(QtPositioning.coordinate(37.56410183312965,
                                                                                   -122.51467645168304), false)
                var bl = map.fromCoordinate(QtPositioning.coordinate(37.56161849366671,
                                                                     -122.51423120498657), false)
                var sizew = Math.sqrt(Math.pow((tr.x - tl.x), 2.0) + Math.pow((tr.y - tl.y), 2.0))
                videoContainer.width = sizew
                var sizeh = Math.sqrt(Math.pow((bl.x - tl.x), 2.0) + Math.pow((bl.y - tl.y), 2.0))
                videoContainer.height = sizeh
            }

            sourceItem: Rectangle {
                id: videoContainer
                color: "transparent"
                border.color: "red"
                width: 40
                height: width
                opacity: 0.8
                rotation: -59
                Video {
                    id: video
                    anchors.fill: parent
                    autoLoad: true
                    autoPlay: true
                    fillMode: VideoOutput.Stretch
                    //source: "https://github.com/paoletto/mediastreamer/blob/master/BBBEXAMPLE/BBB_ffmpeg_360p_crf30.mkv?raw=true"
                    source: "https://www.mapbox.com/drone/video/drone.mp4"

                    onPlaybackStateChanged: {
                        if (video.playbackState == MediaPlayer.StoppedState) {
                            video.play()
                        }
                    }
                }
            }
        }
    }
}
