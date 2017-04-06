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
import QtQuick.Layouts 1.1
import QtLocation 5.6

Rectangle {
    id: container

    property var mapContainer
    property var mapSource
    property real fontSize : 14
    property color labelBackground : "transparent"
    property int edge: Qt.RightEdge
    property alias pluginParameters : pluginManager.pluginParameters

    property var maps : []

    function rightEdge() {
        return (container.edge === Qt.RightEdge);
    }

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: rightEdge() ? parent.right : undefined
    anchors.left: rightEdge() ? undefined : parent.left

    property alias checked: sliderToggler.checked
    visible: checked

    color: "transparent"

    Item { id: dummy } // Workaround for QTBUG-59940

    PanelToggler {
        id: sliderToggler
        checked: false
        anchors.left: (rightEdge()) ? undefined : enabledLayers.right
        anchors.right: (rightEdge()) ? availableLayers.left : undefined
    }

    onVisibleChanged: {
        if (visible && !availableLayersModel.count) {
            pluginManager.populateMapTypeNamesListModel(availableLayersModel)
        }
    }

    PluginManager {
        id: pluginManager

        function populateMapTypeNamesListModel(lm) {
            var mtn = pluginManager.getMapTypeNames()
            var mapTypes = pluginManager.getMapTypes()

//            var mtn = pluginManager.getMapTypeNames()
//            var mapTypes = pluginManager.getMapTypes()
//            for (var k in mtn) {
//                console.log(k)
//                for (var t in mtn[k])

//                    if (mtn[k][t].constructor === Array) {
//                        console.log(" "+t)
//                        for (var j in mtn[k][t])
//                            console.log("  " + mtn[k][t][j] + " : " +
//                                        mapTypes[mtn[k][t][j]]["displayName"])
//                    } else {
//                        console.log("  "+ mtn[k][t] + " : " +
//                                    mapTypes[mtn[k][t]]["displayName"])
//                    }
//            }

            for (var k in mapTypeNames) { // k = PluginName
                var le = { text: k }
                var elems = []

                for (var t in mtn[k]) { // The plugin map types/categories
                    var leNode = { text: t }
                    if (mtn[k][t].constructor === Array) {
//                        console.log( k + t + " isArray")
                        var nodeElems = []
                        for (var j in mtn[k][t])
                            nodeElems.push({ text : mapTypes[mtn[k][t][j]]["displayName"]
                                               ,key : mtn[k][t][j]
                                               ,overlay: mapTypes[mtn[k][t][j]]["overlay"]  })
                        leNode["elements"] = nodeElems
                    } else {
                        leNode["key"] = mtn[k][t]
                        leNode["overlay"] = mapTypes[mtn[k][t]]["overlay"]
                    }

                    elems.push(leNode)
                }

                if (elems)
                    le["elements"] = elems
                lm.append(le)
            }
        }
    }

    ListModel {
        id: enabledLayersModel
    }

    ListModel {
        id: availableLayersModel
//        ListElement {
//            text: "Level 1, Node 1" }
//        ListElement {
//            text: "Level 1, Node 2"
//            elements: [
//                ListElement { text: "Level 2, Node 1"
//                    elements: [
//                        ListElement {
//                            text: "Level 3, Node 1" }
//                    ]
//                },
//                ListElement {
//                    text: "Level 2, Node 2" }
//            ]
//        }
//        ListElement { text: "Level 1, Node 3" }
    }

    Rectangle {
        id: availableLayers
        height: parent.height
        width: 180
        color: Qt.rgba(.5,.5,.5,.7)

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        DropArea {
            anchors { fill: parent; margins: 10 }

            onDropped:
            {
                console.log("Dropped " + drag.source + drag.source.layerClass)
            }
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                color: "lightblue"
                height: 50
                Layout.fillWidth: true

                Text {
                    anchors.centerIn: parent
                    text: "Available Layers"
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Flickable {
                    id: treeView
                    property var model: availableLayersModel
                    anchors.fill: parent
                    flickableDirection: Flickable.VerticalFlick
                    boundsBehavior: Flickable.StopAtBounds

                    contentHeight: content.height
                    contentWidth: content.width

                    Loader {
                        id: content
                        sourceComponent: treeBranch
                        property var elements: treeView.model
                        property bool isRoot: true

                        Component {
                            id: treeBranch

                            Item {
                                id: root

                                implicitHeight: column.implicitHeight
                                implicitWidth: column.implicitWidth

                                Column {
                                    id: column
                                    anchors.fill: parent
                                    //x: 2
                                    Repeater {
                                        model: elements

                                        Column {

                                            Rectangle {
                                                color: !!model.elements ? loader.expanded ? Qt.rgba(.8, .7, .8, 1) : Qt.rgba(.6, .4, .6, 1) : Qt.rgba(.8, 1,1,1)
                                                //border.color: "red"
                                                height: txt.height * 2
                                                width: treeView.width //txt.width

                                                property var key : model.key
                                                property var text: model.text
                                                property var overlay: model.overlay
                                                property var map: model.mapObject

                                                Drag.active: ma.drag.active
                                                Drag.dragType: (!model.elements) ? Drag.Automatic : Drag.None
                                                Drag.imageSource : "qrc:/LocationComponents/icons/icon_maplayer64.png"
                                                Drag.onActiveChanged: console.log("active", active)
                                                Drag.onDragStarted: console.log("rect drag started")
                                                Drag.onDragFinished: console.log("rect drag finished")

                                                Text {
                                                    id: txt
                                                    text: model.text
                                                    color: model.overlay ? "deepskyblue" : "black"
                                                    anchors.centerIn: parent
                                                }

                                                // Bottom line border
                                                Rectangle {
                                                    anchors {
                                                        left: parent.left
                                                        right: parent.right
                                                        bottom: parent.bottom
                                                    }
                                                    height: 1
                                                    color: "gray"
                                                }

                                                MouseArea {
                                                    id: ma
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onClicked: loader.expanded = !loader.expanded
                                                    drag.target: dummy // Workaround for QTBUG-59940
                                                }
                                            }
                                            Loader {
                                                id: loader
                                                height: expanded ? implicitHeight * 1 : 0

                                                property bool expanded: false
                                                property var elements: model.elements
                                                property var text: model.text
                                                sourceComponent: (expanded && !!model.elements) ? treeBranch : undefined
                                            }
                                        } // Column
                                    } // Repeater
                                } // Column
                            } // root Item
                        } // Component
                    } // Outer Loader
                } // Flickable
            } // ScrollView
        }
    }// availableLayers


    Component {
        id: mapComponent

        Map {
            anchors.fill: parent
            color: 'transparent'
            center : parent.center
            zoomLevel: parent.zoomLevel
            tilt: parent.tilt
            bearing: parent.bearing
            fieldOfView: parent.fieldOfView
            z: parent.z + 1
        }
    }

    Rectangle {
        id: enabledLayers
        height: parent.height
        width: 180
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: availableLayers.right
        color: Qt.rgba(.5,.5,.5,.7)

        function addMap(dragSource)
        {
            var key = "osm.Street Map"
            var text = "Street Map"
            var overlay = false

            if (dragSource !== undefined) {
                key = dragSource.key
                text = dragSource.text
                overlay = dragSource.overlay
            }

            var mapTypes = pluginManager.getMapTypes()
            var mapType = mapTypes[key]


            var map = mapComponent.createObject(mapContainer);
            map.plugin = mapType["plugin"]
            map.activeMapType = mapType["mapType"]
            map.z = map.z + enabledLayersModel.count

            //container.maps.push(map)
            enabledLayersModel.append({ text: text
                                       ,key: key
                                       ,overlay: overlay
                                       ,mapObject: map })
        }

        DropArea {
            anchors { fill: parent; margins: 10 }
            onDropped: enabledLayers.addMap(drag.source)
            Component.onCompleted: enabledLayers.addMap()
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                color: "lightblue"
                height: 50
                Layout.fillWidth: true

                Text {
                    anchors.centerIn: parent
                    text: "Enabled Layers"
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                ListView {
                    id: listViewEnabled
                    model: enabledLayersModel
                    delegate: Component {
                        Rectangle {
                            height: textLabel.height * 2
                            width: listViewEnabled.width
                            color: "white"

                            Text {
                                id: textLabel
                                color: model.overlay ? "deepskyblue" : "black"
                                anchors.centerIn: parent
                                text: model.text //+ " - idx " + index
                            }



                            // Bottom line border //container.maps[index]
                            Rectangle {
                                anchors {
                                    left: parent.left
                                    right: parent.right
                                    bottom: parent.bottom
                                }
                                height: 1
                                color: "lightgrey"
                            }

                            MouseArea {
                                id: ma
                                anchors.fill: parent

                                onDoubleClicked: {
                                    console.log(model.key)
                                    console.log(model.mapObject.plugin.name)
                                    console.log(index)
                                    var mapToDestroy = model.mapObject
                                    mapToDestroy.destroy()
                                    enabledLayersModel.remove(index)

                                    for (var i =0; i< enabledLayersModel.count; i++) {
                                        enabledLayersModel.get(i).mapObject.z = i+1
                                    }
                                }

                                CheckBox {
                                    id: checkBox
                                    checked: true
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right: parent.right
                                    anchors.rightMargin: 8
                                    //activeFocusOnPress: true

                                    onCheckedChanged: {
                                        enabledLayersModel.get(index).mapObject.visible = checked
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    } // enabledLayers
} // containerRow
