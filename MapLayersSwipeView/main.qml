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
import QtQuick.Controls 2.0
import QtPositioning 5.6
import QtLocation 5.9
import LocationComponents 1.0

ApplicationWindow {
    id: win
    visible: true
    width: 640
    height: 480

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {
            id: page1
            Item {
                id: containerItem
                anchors.fill: parent
                Component {
                    id: mapComponent

                    Map {
                        id: mapTest
                        anchors.fill: parent
                        color: 'transparent'
                        plugin: Plugin {
                            name:"osm"
                        }
                        center: QtPositioning.coordinate(43,-71)
                        zoomLevel: 4
                        z: parent.z + 50
                    }
                }

                Component.onCompleted: {
                    var map = mapComponent.createObject(containerItem);
                    map.z = 50
                }

                // Should be able to see this rectangle, but can't
                Rectangle {
                    width: 30
                    height: 30
                    z: parent.z + 100
                    anchors.centerIn: parent
                    color: 'blue'
                }

                // Can't see this one
                Rectangle {
                    width: 30
                    height: 30
                    z: parent.z + 1
                    anchors.fill: parent
                    color: 'green'
                }
            }
        }

        Page {
            id: page2

            Map {
                id: mapTest
                anchors.fill: parent
                color: 'transparent'
                plugin: Plugin {
                    name:"osm"
                }

                center: QtPositioning.coordinate(43,-71)
                zoomLevel: 4
                z : 50
            }

            // Can see this rectangle
            Rectangle {
                width: 30
                height: 30
                z: 100
                anchors.centerIn: parent
                color: 'red'
            }

            // Can't see this one
            Rectangle {
                width: 30
                height: 30
                z: 0
                anchors.fill: parent
                color: 'red'
            }
        }
    }


    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
    }
}
