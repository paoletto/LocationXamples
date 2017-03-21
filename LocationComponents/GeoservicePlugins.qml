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

import QtQuick 2.4
import QtLocation 5.9
import LocationComponents 1.0

Item {
    id: plugins

    property var osm : osmPlugin
    property var osmHiDpi : osmPluginHiDpi
    property var esri: esriPlugin
    property var here: herePlugin
    property var hereHiDpi: herePluginHiDpi
    property var mapbox: mapboxPlugin
    property var mapboxHiDpi: mapboxPluginHiDpi
    property var mapboxgl: mapboxglPlugin

    property var mapboxAccessToken: SystemEnvironment.variable("MAPBOX_ACCESS_TOKEN")
    property var hereAppId: SystemEnvironment.variable("HERE_APP_ID")
    property var hereToken: SystemEnvironment.variable("HERE_TOKEN")

    Plugin {
        id: osmPlugin
        name: "osm"
        PluginParameter{ name: "osm.mapping.custom.host"; value: "http://c.tiles.wmflabs.org/hillshading/"}
        PluginParameter{ name: "osm.mapping.custom.mapcopyright"; value: "The <a href='https://wikimediafoundation.org/wiki/Terms_of_Use'>WikiMedia Foundation</a>"}
    }

    Plugin {
        id: osmPluginHiDpi
        name: "osm"
        PluginParameter{ name: "osm.mapping.custom.host"; value: "http://c.tiles.wmflabs.org/hillshading/"}
        PluginParameter{ name: "osm.mapping.custom.mapcopyright"; value: "The <a href='https://wikimediafoundation.org/wiki/Terms_of_Use'>WikiMedia Foundation</a>"}
        PluginParameter{ name: "osm.mapping.highdpi_tiles"; value: true}
    }


    property var mapboxglPlugin
    property var herePlugin

    property var mapboxPluginHiDpi
    property var herePluginHiDpi

// DOESNT WORK
//    Plugin {
//        id: mapboxPlugin
//        name: 'mapboxgl';
//        PluginParameter {
//            name: "mapboxgl.access_token"
//            value: SystemEnvironment.variable("MAPBOX_ACCESS_TOKEN")
//        }
//    }
    property var mapboxPlugin
    onMapboxAccessTokenChanged: {
        mapboxPlugin = Qt.createQmlObject(
                   "import QtQuick 2.4;
                    import QtLocation 5.9;
                    Plugin {
                        name: 'mapbox';
                        PluginParameter {
                            name: \"mapbox.access_token\" ;
                            value: '"+mapboxAccessToken+"';
                        }
                    }", win, "");

        mapboxglPlugin = Qt.createQmlObject(
                   "import QtQuick 2.4;
                    import QtLocation 5.9;
                    Plugin {
                        name: 'mapboxgl';
                        PluginParameter {
                            name: \"mapboxgl.access_token\" ;
                            value: '"+mapboxAccessToken+"';
                        }
                    }", win, "");

        mapboxPluginHiDpi = Qt.createQmlObject(
                   "import QtQuick 2.4;
                    import QtLocation 5.9;
                    Plugin {
                        name: 'mapbox';
                        PluginParameter {
                            name: \"mapbox.access_token\" ;
                            value: '"+mapboxAccessToken+"';
                        }
                        PluginParameter {
                            name: \"mapbox.mapping.highdpi_tiles\" ;
                            value: true;
                        }
                    }", win, "");
    }

    onHereTokenChanged: {
        herePlugin = Qt.createQmlObject(
                   "import QtQuick 2.4;
                    import QtLocation 5.9;
                    Plugin {
                        name: 'here';
                        PluginParameter {
                            name: \"here.app_id\" ;
                            value: '"+hereAppId+"';
                        }
                        PluginParameter {
                            name: \"here.token\" ;
                            value: '"+hereToken+"';
                        }
                    }", win, "");

        herePluginHiDpi = Qt.createQmlObject(
                   "import QtQuick 2.4;
                    import QtLocation 5.9;
                    Plugin {
                        name: 'here';
                        PluginParameter {
                            name: \"here.app_id\" ;
                            value: '"+hereAppId+"';
                        }
                        PluginParameter {
                            name: \"here.token\" ;
                            value: '"+hereToken+"';
                        }
                        PluginParameter {
                            name: \"here.mapping.highdpi_tiles\" ;
                            value: true;
                        }
                    }", win, "");

    }

    Plugin {
        id: esriPlugin
        name: "esri"
    }

    Plugin {
        id: tileOverlay
        name: "tileoverlay"
    }

// Somehow not working in here
//    Plugin {
//        id: testPlugin;
//        name: "qmlgeo.test.plugin";
//        allowExperimental: true
//        PluginParameter { name: "finishRequestImmediately"; value: true}
//        PluginParameter { name: "backgroundColor"; value: "transparent"}
//        PluginParameter { name: "textColor"; value: "#A0FF0000"}
//    }

//    Plugin {
//        id: tilting
//        name: "tilting"
//    }
}
