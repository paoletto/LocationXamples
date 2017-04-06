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

import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.1 as C2
import LocationComponents 1.0

Rectangle {
    id: container
    color: "transparent"
    anchors.fill: parent

    property var mapSource
    property var mapContainer
    property int edge: Qt.LeftEdge
    property alias pluginParameters: layerManager.pluginParameters

    function rightEdge() {
        return (container.edge === Qt.RightEdge);
    }

    Rectangle {
        id : bar
        color: Qt.rgba(37/255.0, 40/255.0, 42/255.0, 0.80)


        property real fontSize : 14

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        x:0
        y:0
    //    anchors.right: rightEdge() ? parent.right : undefined
    //    anchors.left: rightEdge() ? undefined : parent.left

        width: 48

        property int topSpacing : 20
        property int verticalSpacing : 15
        property int leftSpacing : 0
        property int rightSpacing : 8
        property int collapsedWidth : 16
        property int xcollapsed : (rightEdge()) ? parent.width - collapsedWidth : -width + collapsedWidth
        property int xexpanded : (rightEdge()) ? parent.width - width : 0
        property int xinvisible: (rightEdge()) ? parent.width : -width

        state: "COLLAPSED"

        states: [
            State {
                name: "COLLAPSED"
                PropertyChanges { target: bar; x: xcollapsed}
            },
            State {
                name: "EXPANDED"
                PropertyChanges { target: bar; x: xexpanded}
            },
            State {
                name: "INVISIBLE"
                PropertyChanges { target: bar; x: xinvisible}
            }
        ]

        transitions: [
            Transition {
                to: "EXPANDED"
                PropertyAnimation {
                    target: bar
                    duration: 100
                    property: "x";
                }
            },
            Transition {
                to: "COLLAPSED"
                PropertyAnimation {
                    target: bar
                    duration: 100
                    property: "x";
                }
            },
            Transition {
                to: "INVISIBLE"
                PropertyAnimation {
                    target: bar
                    duration: 100
                    property: "x";
                }
            }
        ]

        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true

            onHoveredChanged: {
                if (bar.state == "INVISIBLE")
                    return

                if (containsMouse) {
                    console.log("hovering")
                    bar.state = "EXPANDED"
                } else {
                    console.log("not hovering")
                    bar.state = "COLLAPSED"
                }
            }

            Button {
                id: slidersButton
                x: parent.x + (rightEdge()) ? bar.rightSpacing : bar.leftSpacing
                y: parent.y + bar.topSpacing
                width: bar.width - bar.rightSpacing - bar.leftSpacing
                height: width
                style: ButtonStyle {
                    background: Rectangle {
                        color:"green"
                        radius: 4
                    }

                    padding {
                        left: 1
                        right: 1
                        top: 1
                        bottom: 1
                    }

                    label: Image {
                        source: "qrc:/LocationComponents/icons/icon_sliders.png"
                        fillMode: Image.PreserveAspectFit  // ensure it fits
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    color: "black"
                    opacity: parent.pressed ? 0.5 : 0
                }

                onClicked: {
                    bar.state = "INVISIBLE"
                    sliders.checked = true
                }
            }

            Button {
                id: layersButton
                x: parent.x + (rightEdge()) ? bar.rightSpacing : bar.leftSpacing
                y: parent.y + bar.topSpacing + width + bar.verticalSpacing
                width: bar.width - bar.rightSpacing - bar.leftSpacing
                height: width
                style: ButtonStyle {
                    background: Rectangle {
                        color:"red"
                        radius: 4
                    }

                    padding {
                        left: 1
                        right: 1
                        top: 1
                        bottom: 1
                    }

                    label: Image {
                        source: "qrc:/LocationComponents/icons/icon_layers.png"
                        fillMode: Image.PreserveAspectFit  // ensure it fits
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    color: "black"
                    opacity: parent.pressed ? 0.5 : 0
                }

                onClicked: {
                    bar.state = "INVISIBLE"
                    layerManager.checked = true
                }
            }
        }




    } // bar


    MapSliders {
        id: sliders
        mapSource: parent.mapSource
        edge: parent.edge
        checked: false

        onCheckedChanged: {
            if (!checked)
                bar.state = "COLLAPSED"
        }
    }

    LayerManager {
        id: layerManager
        mapContainer: parent.mapContainer
        mapSource: parent.mapSource
        edge: parent.edge
        checked: false

        onCheckedChanged: {
            if (!checked)
                bar.state = "COLLAPSED"
        }
    }

} // container
