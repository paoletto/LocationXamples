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
    property alias pluginParametersJsonURL: pluginManager.pluginParameterJsonUrl

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

            var pluginNames = []
            for (var tn in mapTypeNames)
                pluginNames.push(tn)
            pluginNames.sort()

            for (var pni in pluginNames) { // k = PluginName
                var k = pluginNames[pni]
                var le = { text: k, root: true }
                var elems = []

                var pluginNodeNames = []
                for (var pnn in mtn[k])
                    pluginNodeNames.push(pnn)
                pluginNodeNames.sort()


                for (var pnni in pluginNodeNames) { // The plugin map types/categories
                    var t = pluginNodeNames[pnni]
                    var leNode = { text: t, root: false }
                    if (mtn[k][t].constructor === Array) {
                        var nodeElems = []

                        var leafNames = mtn[k][t].slice()
                        leafNames.sort()

                        for (var j in leafNames) {
                            var dataEntry = { text : mapTypes[mtn[k][t][j]]["displayName"]
                                ,root: false
                                ,key : mtn[k][t][j]
                                ,idxx: mapTypes[mtn[k][t][j]]["mapTypeIndex"]
                                ,overlay: mapTypes[mtn[k][t][j]]["overlay"]
                                ,pluginName: k}
                            nodeElems.push(dataEntry)
                        }
                        leNode["elements"] = nodeElems
                    } else {
                        leNode["key"] = mtn[k][t]
                        leNode["overlay"] = mapTypes[mtn[k][t]]["overlay"]
                        leNode["pluginName"] = k
                        leNode["idxx"] = mapTypes[mtn[k][t]]["mapTypeIndex"]
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
                                                color: model.root ?
                                                    Qt.rgba(178/255, 34/255, 34/255, 1)
                                                    : !!model.elements ?
                                                        loader.expanded ?
                                                            Qt.rgba(.8, .7, .8, 1)
                                                            : Qt.rgba(.6, .4, .6, 1)
                                                        : Qt.rgba(.8, 1,1,1)
                                                //border.color: "red"
                                                height: txt.height * 2
                                                width: treeView.width //txt.width

                                                property var key : model.key
                                                property var text: model.text
                                                property var idxx: model.idxx
                                                property var overlay: model.overlay
                                                property var map: model.mapObject
                                                property var pluginName: model.pluginName

                                                Drag.active: ma.drag.active
                                                Drag.dragType: (!model.elements) ? Drag.Automatic : Drag.None
                                                Drag.imageSource : "qrc:/LocationComponents/icons/icon_maplayer64.png"
//                                                Drag.onActiveChanged: console.log("active", active)
//                                                Drag.onDragStarted: console.log("rect drag started")
//                                                Drag.onDragFinished: console.log("rect drag finished")

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
            id: map
            anchors.fill: parent
            color: 'transparent'
            center : parent.center
            zoomLevel: parent.zoomLevel
            gesture.enabled: false
            tilt: parent.tilt
            bearing: parent.bearing
            fieldOfView: parent.fieldOfView
            visible: (checked && (zoomLevel >= minimumZoomLevel))
            z: parent.z + 1
            property bool checked: true
        }
    }

    function updateLayersZ()
    {
        for (var i =0; i< enabledLayersModel.count; i++) {
            enabledLayersModel.get(i).mapObject.z = i+1
        }
    }

    function deleteMapItem(model, index)
    {
        //                                    console.log(model.key)
        //                                    console.log(model.mapObject.plugin.name)
        //                                    console.log(index)

        var mapToDestroy = model.mapObject
        mapToDestroy.destroy()
        enabledLayersModel.remove(index)

        updateLayersZ()
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
            var pluginName = "osm"
            var idxx = "0"

            if (dragSource !== undefined) {
                key = dragSource.key
                text = dragSource.text
                overlay = dragSource.overlay
                pluginName = dragSource.pluginName
                idxx = dragSource.idxx
            }

            var mapTypes = pluginManager.getMapTypes()
            var mapType = mapTypes[key]


            var map = mapComponent.createObject(mapContainer);
            map.activeMapType = mapType["mapType"]
            map.plugin = mapType["plugin"]
            map.z = map.z + enabledLayersModel.count

            //container.maps.push(map)
            enabledLayersModel.append({ text: text
                                       ,key: key
                                       ,idxx: idxx
                                       ,overlay: overlay
                                       ,mapObject: map
                                       ,pluginName: pluginName})
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
                    delegate: DraggableItem {
                        Rectangle {
                            height: textLabel.height * 2
                            width: listViewEnabled.width
                            color: "white"

                            Text {
                                id: pluginLabel
                                color: "crimson"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                font.pixelSize: textLabel.font.pixelSize / 1.3
                                text: model.pluginName + " - " + model.idxx
                            }

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

//                            MouseArea {
//                                id: ma
//                                anchors.fill: parent

//                                onDoubleClicked: {
////                                    console.log(model.key)
////                                    console.log(model.mapObject.plugin.name)
////                                    console.log(index)
//                                    var mapToDestroy = model.mapObject
//                                    mapToDestroy.destroy()
//                                    enabledLayersModel.remove(index)

//                                    updateLayersZ()
//                                }

                                CheckBox {
                                    id: checkBox
                                    checked: true
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right: parent.right
                                    anchors.rightMargin: 8
                                    //activeFocusOnPress: true

                                    onCheckedChanged: {
                                        enabledLayersModel.get(index).mapObject.checked = checked
                                    }
                                }
//                            }
                        }

                        draggedItemParent: enabledLayers

                        onMoveItemRequested: {
                            enabledLayersModel.move(from, to, 1);
                            updateLayersZ()
                        }
                    }
                }
            }
        }
    } // enabledLayers
} // containerRow
