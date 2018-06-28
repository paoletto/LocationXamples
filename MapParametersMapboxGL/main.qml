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
    width: 640
    height: 640



    GeoservicePlugins {
        id: plugins

        Component.onCompleted: {
            var code = '
        import QtQuick 2.7
        import QtQuick.Window 2.2
        import QtQuick.Controls 1.4
        import QtPositioning 5.6
        import QtLocation 5.9
        import LocationComponents 1.0


        MapWithSliders {
        id: map
        anchors.fill: parent
        opacity: 1.0
        color: "transparent"
        plugin: plugins.mapboxgl
        center: QtPositioning.coordinate(45,10)
        activeMapType: map.supportedMapTypes[0]
        zoomLevel: 4

        MapParameter {
            type: "source"

            property var name: "routeSource"
            property var sourceType: "geojson"
            property var data: \'{ "type": "FeatureCollection", "features": [{ "type": "Feature", "properties": {}, "geometry": { "type": "LineString", "coordinates": [[ 24.934938848018646, 60.16830257086771 ], [ 44.943315386772156, 40.16227776476442 ]]}}]}\'
        }


        MapParameter {
            type: "layer"

            property var name: "route"
            property var layerType: "line"
            property var source: "routeSource"

            // Draw under the first road label layer
            // of the mapbox-streets style.
            property var before: "road-label-small"
        }

        MapParameter {
            type: "paint"

            property var layer: "route"
            property var lineColor: "blue"
            property var lineWidth: 8.0
        }

        MapParameter {
            type: "layout"

            property var layer: "route"
            property var lineJoin: "round"
            property var lineCap: "round"
        }

        MapParameter {
            type: "layout"
            property var layer: "country-label-lg"
            property var textField: "name_de"
        }
    }'


            Qt.createQmlObject(code, win)
        }
    }



//    MapWithSliders {
//        id: map
//        anchors.fill: parent
//        opacity: 1.0
//        color: 'transparent'
//        plugin: plugins.mapboxgl
//        center: QtPositioning.coordinate(45,10)
//        activeMapType: map.supportedMapTypes[0]
//        zoomLevel: 4

//        MapParameter {
//            type: "source"

//            property var name: "routeSource"
//            property var sourceType: "geojson"
//            property var data: '{ "type": "FeatureCollection", "features": [{ "type": "Feature", "properties": {}, "geometry": { "type": "LineString", "coordinates": [[ 24.934938848018646, 60.16830257086771 ], [ 44.943315386772156, 40.16227776476442 ]]}}]}'
//        }


//        MapParameter {
//            type: "layer"

//            property var name: "route"
//            property var layerType: "line"
//            property var source: "routeSource"

//            // Draw under the first road label layer
//            // of the mapbox-streets style.
//            property var before: "road-label-small"
//        }

//        MapParameter {
//            type: "paint"

//            property var layer: "route"
//            property var lineColor: "blue"
//            property var lineWidth: 8.0
//        }

//        MapParameter {
//            type: "layout"

//            property var layer: "route"
//            property var lineJoin: "round"
//            property var lineCap: "round"
//        }
//    }
}
