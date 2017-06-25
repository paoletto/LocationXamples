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

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0
import QtQuick.Scene3D 2.0

import QtQuick.Controls 2.2

ApplicationWindow {
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
        center: QtPositioning.coordinate(18.859820495687384, 50.164062499994515)
        //activeMapType: map.supportedMapTypes[0]
        zoomLevel: 4.0
        copyrightsVisible: win.copyVisible
        fieldOfView: 45

        MapQuickItem {
            id: markerTest
            z: 10

            zoomLevel: 4.0

            coordinate { latitude: 42.350000000; longitude: -71.0}

            sourceItem: Rectangle {
                id: rectangleContainer

                width: 256
                height: 256
                color: "transparent"
                border.color: "black"

                Scene3D {
                    id: scene3d
                    anchors.fill: parent
//                    focus: true
                    aspects: ["input", "logic"]
                    cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

                    Entity {
                        id: sceneRoot

                        Camera {
                            id: camera
                            projectionType: CameraLens.PerspectiveProjection
                            fieldOfView: 45
                            nearPlane : 0.1
                            farPlane : 1000.0
                            position: Qt.vector3d( 0.0, 0.0, 40.0 )
                            upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                            viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
                        }

                        components: [
                            RenderSettings {
                                activeFrameGraph: ForwardRenderer {
                                    camera: camera
                                    clearColor: "transparent"
                                }
                            }
                        ]

                        PhongMaterial {
                            id: material
                        }

                        TorusMesh {
                            id: torusMesh
                            radius: 5
                            minorRadius: 1
                            rings: 100
                            slices: 20
                        }
                        Transform {
                            id: torusTransform
                            scale3D: Qt.vector3d(1.5, 1, 0.5)
                            rotation: fromAxisAndAngle(Qt.vector3d(1, 0, 0), 45)
                        }

                        Entity {
                            id: torusEntity
                            components: [ torusMesh, material, torusTransform ]
                        }
                        SphereMesh {
                            id: sphereMesh
                            radius: 3
                        }

                        Transform {
                            id: sphereTransform
                            property real userAngle: 0.0
                            matrix: {
                                var m = Qt.matrix4x4();
                                m.rotate(userAngle, Qt.vector3d(0, 1, 0))
                                m.translate(Qt.vector3d(20, 0, 0));
                                return m;
                            }
                        }

                        NumberAnimation {
                            target: sphereTransform
                            property: "userAngle"
                            duration: 10000
                            from: 0
                            to: 360

                            loops: Animation.Infinite
                            running: true
                        }

                        Entity {
                            id: sphereEntity
                            components: [ sphereMesh, material, sphereTransform ]
                        }
                    }
                }
            }

        }
    }
}

