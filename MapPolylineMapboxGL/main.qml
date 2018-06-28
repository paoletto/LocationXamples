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
    width: 400
    height: 400
    property var copyVisible : false

    GeoservicePlugins {
        id: plugins
    }

    MapWithSliders {
        id: map
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        plugin: plugins.mapboxgl
        center: QtPositioning.coordinate((mediumPoly.path[0].latitude + mediumPoly.path[mediumPoly.path.length -1].latitude) * 0.5,
                                         (mediumPoly.path[0].longitude + mediumPoly.path[mediumPoly.path.length -1].longitude) * 0.5)
        //activeMapType: map.supportedMapTypes[5]
        zoomLevel: 15
        copyrightsVisible: win.copyVisible

//        MediumPoly {
//            id: mediumPoly
//            objectName: "mediumPoly"
//        }

////        MapParameter {
////            type: "layout"
////            property var layer: "QtLocation-mediumPoly"
////            property var lineJoin: "round" // bevel round miter
////            property var lineCap: "round" // butt round square
////        }
//        MapParameter {
//            type: "paint"
//            property var layer: "QtLocation-mediumPoly"
//            property var lineWidth: 3
//            property var lineColor: "white"
//            property var lineDasharray: [2, 2] // dashes
//        }

//        MapParameter {
//            type: "layer"
//            property var name: "mediumPolyCase"
//            property var layerType: "line"
//            property var source: "QtLocation-mediumPoly"
//            property var before: "QtLocation-mediumPoly"
//        }
//        MapParameter {
//            type: "layout"
//            property var layer: "mediumPolyCase"
//            property var lineJoin: "round" // bevel round miter
//            property var lineCap: "round" // butt round square
//        }
//        MapParameter {
//            type: "paint"
//            property var layer: "mediumPolyCase"
//            property var lineColor: "deepskyblue"
//            property var lineOpacity: 0.5
//            property var lineWidth: 10
//        }


        MediumPoly {
            objectName: 'polyDashed'
            id: mediumPoly
        } // MapPolyline

        MapParameter {
            type: 'layout'
            property var layer: 'QtLocation-polyDashed'
            property var lineJoin: 'round' // bevel round miter
            property var lineCap: 'round' // butt round square
        }

        MapParameter {
            type: "paint"
            property var layer: "QtLocation-polyDashed"
            property var lineWidth: 3
            property var lineColor: "white"
            property var lineDasharray: [1, 2] // dashes
        }

        MapParameter {
            type: "layer"
            property var name: "mediumPolyCase"
            property var layerType: "line"
            property var source: "QtLocation-polyDashed"
            property var before: "QtLocation-polyDashed"
        }
        MapParameter {
            type: "layout"
            property var layer: "mediumPolyCase"
            property var lineJoin: "round" // bevel round miter
            property var lineCap: "round" // butt round square
        }
        MapParameter {
            type: "paint"
            property var layer: "mediumPolyCase"
            property var lineColor: "deepskyblue"
            property var lineOpacity: 0.5
            property var lineWidth: 10
        }

        MapParameter {
            type: "layout"
            property var layer: "country-label-lg"
            property var textField: { return { type: "identity", property: "name_de" } }
        }
        MapParameter {
            type: "layout"
            property var layer: "place-city-lg-s"
            property var textField: { return { type: "identity", property: "name_de" } }
        }
        MapParameter {
            type: "layout"
            property var layer: "place-town"
            property var textField: { return { type: "identity", property: "name_de" } }
        }
        MapParameter {
            type: "layout"
            property var layer: "place-city-md-n"
            property var textField: { return { type: "identity", property: "name_de" } }
        }
        MapParameter {
            type: "layout"
            property var layer: "place-city-sm"
            property var textField: { return { type: "identity", property: "name_de" } }
        }

//        MapParameter {
//            type: 'paint'
//            property var layer: 'QtLocation-polyDashed'
//            property var lineWidth: 3
//            property var lineColor: 'white'
//            //property var lineBlur: 2
//            //property var lineGapWidth: 10
//            property var lineDasharray: [2, 2] // dashes
//        }

//        MapParameter {
//            type: 'layer'

//            property var name: 'polycase'
//            property var layerType: 'line'
//            property var source: 'QtLocation-polyDashed'

//    //        // Draw under the first road label layer
//    //        // of the mapbox-streets style.
//            property var before: 'QtLocation-poly'
//        }

//        MapParameter {
//            type: 'paint'
//            property var layer: 'polycase'
//            property var lineColor: 'deepskyblue'
//            property var lineWidth: 10
//            //property var lineDasharray: [0, 1.5] // dashes
//        }
    }
}
