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

    property var pluginNames : {}
    property var geoservicePlugins : {}
    property var geoservicePluginsDict : {}
    property var mappingPluginsDict : {}
    property var routingPluginsDict : {}
    property var dummyMapsDict : { "invalid" : undefined }
    property var supportedMaps : {}

    function availablePluginNames()
    {
        if (typeof pluginArray === "undefined") {
            // Initializing the plugin Array
            var plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin {}', win)
            var arr = new Array()
            //var allowed = ["osm","mapbox","here","esri","mapboxgl"]
            for (var i = 0; i<plugin.availableServiceProviders.length; i++) {
                //if (allowed.indexOf(plugin.availableServiceProviders[i]) >= 0 )
                {
                    var tempPlugin
                    if (plugin.availableServiceProviders[i] === "mapboxgl")
                       tempPlugin = Qt.createQmlObject ('import QtLocation 5.9; Plugin { name: "mapboxgl";  PluginParameter{ name: "mapboxgl.mapping.use_fbo"; value: false}  }', win)
                    else
                        tempPlugin = Qt.createQmlObject ('import QtLocation 5.9; Plugin {name: "' + plugin.availableServiceProviders[i]+ '"}', win)
                    if (tempPlugin.supportsMapping())
                        arr.push(tempPlugin.name)
                }
            }
            arr.sort()
            pluginNames = arr;
            return arr
        } else  {
            return pluginNames
        }
    }

    function updatePlugins()
    {
        // Does this require to explicitly destroy current plugins?
        geoservicePlugins = new Array()
        geoservicePluginsDict = new Object()
        mappingPluginsDict = new Object()
        routingPluginsDict = new Object()

        var plugin_names = availablePluginNames()
        for (var i = 0; i < plugin_names.length; i++) {
            var plugin
            if (plugin_names[i] === "mapboxgl")
                plugin = Qt.createQmlObject ('import QtLocation 5.9; Plugin { name: "mapboxgl";  PluginParameter{ name: "mapboxgl.mapping.use_fbo"; value: false}  }', win)
            else
                plugin = Qt.createQmlObject ('import QtLocation 5.9; Plugin{ name:"' + plugin_names[i] + '"}', win)

            geoservicePlugins.push(plugin)
            geoservicePluginsDict[plugin_names[i]] = plugin

            if (plugin.supportsMapping(Plugin.AnyMappingFeatures))
                mappingPluginsDict[plugin_names[i]] = plugin

            if (plugin.supportsRouting(Plugin.AnyRoutingFeatures))
                routingPluginsDict[plugin_names[i]] = plugin
        }
    }

    Item {
        id: dummyItem
        visible: false
    }

    function initializeDummyMaps(appWindow, mapMenu,  mapComponent)
    {
        var plugin_dict = mappingPluginsDict;

        var allowed = ["osm","mapbox","here","esri","mapboxgl"]
        for (var key in plugin_dict) {
            if ( !(key in dummyMapsDict)) {
                console.log("#"+key)
                if (allowed.indexOf(key) < 0 )
                    continue;
                var dummyMap = Qt.createQmlObject ('import QtLocation 5.9; Map { }', dummyItem)
                dummyMap.plugin = plugin_dict[key]
                dummyMapsDict[key] = dummyMap

                console.log("Supported maps in "+key+": " + dummyMap.supportedMapTypes)
                var arr = []

                for (var j = 0; j < dummyMap.supportedMapTypes.length; j++) {
                    arr.push(dummyMap.supportedMapTypes[j].name)
                }

                //supportedMaps[key] = arr
                console.log("Supported maps in "+key+": " + arr)
            }
        }
    }

    Component.onCompleted: {
        var availablePlugins = availablePluginNames();
        console.log("Plugins: " + availablePlugins);
        updatePlugins()
        console.log(geoservicePlugins)
        console.log(geoservicePluginsDict)
        console.log(mappingPluginsDict)
        console.log(routingPluginsDict)

        initializeDummyMaps()
    }

    MapWithSliders {
        id: map
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        plugin: Plugin {
            name: "mapboxgl";
            PluginParameter{
                name: "mapboxgl.mapping.use_fbo";
                value: false
            }
        }
        center: QtPositioning.coordinate(45,10)
        activeMapType: map.supportedMapTypes[0]
        zoomLevel: 4
    }
}
