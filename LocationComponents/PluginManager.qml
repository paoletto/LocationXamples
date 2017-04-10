/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
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

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtLocation 5.6
import QtPositioning 5.5
import LocationComponents 1.0

Item {
    id: manager

    // these properties are for caching purposes
    property var pluginNames : {}
    property var geoservicePlugins : {}
    property var geoservicePluginsDict : {}
    property var mappingPluginsDict : {}
    property var routingPluginsDict : {}
    property var dummyMapsDict : undefined
    property var pluginParameters : []
    property var commonPluginParameters : []
    property var mapTypeNames : {}
    property var mapTypes : {}
    property var pluginParameterJsonUrl : undefined
    property var allPluginParameters : undefined

    signal supportedMapTypesChanged()

    // fixme!!! properly read files from qrc:/ or :/ urls
    function getCommonParameters()
    {

        if (typeof pluginParameterJsonUrl === 'undefined')
            pluginParameterJsonUrl = SystemEnvironment.variable("QTLOCATION_PLUGIN_PARAMETERS_URL")

        console.log("PluginManager loading "+pluginParameterJsonUrl)

        var request = new XMLHttpRequest()
        // NOTE: does not work with qrc:/ , only file:/// or remote
        request.open('GET', pluginParameterJsonUrl, false) // false makes the request synchronous
        request.send()
        if (request.readyState !== XMLHttpRequest.DONE)
            return ""
        var data = request.responseText
        var JsonObject= JSON.parse(data);

        var params = []

        for (var key in JsonObject) {
            var parameter = Qt.createQmlObject(
                        "import QtQuick 2.0;
                         import QtLocation 5.6;
                         PluginParameter {
                             name: '" + key + "' ;
                             value: '"+ JsonObject[key] +"';
                         }", manager, "");
            params.push(parameter)
        }
        return params

    }

    function availablePluginNames()
    {
        if (typeof manager.pluginArray === "undefined") {
            // Initializing the plugin Array
            var plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin {}', manager)
            var arr = new Array()
            var plugPars = getCommonParameters()
            manager.commonPluginParameters = plugPars
            //var allowed = ["osm","mapbox","here","esri"]
            for (var i = 0; i<plugin.availableServiceProviders.length; i++) {
                //if (allowed.indexOf(plugin.availableServiceProviders[i]) >= 0 )
                {
                    var tempPlugin
                    tempPlugin = Qt.createQmlObject('import QtLocation 5.6;
                                                     Plugin {
                                                        name: "' + plugin.availableServiceProviders[i] + '";
                                                        parameters: manager.commonPluginParameters
                                                     }', manager)
                    if (tempPlugin.supportsMapping() || tempPlugin.supportsRouting())
                        arr.push(tempPlugin.name)
                    tempPlugin.destroy()
                }
            }
            arr.sort()
            manager.pluginNames = arr;
            plugin.destroy()
            //console.log(arr)
            return arr
        } else  {
            return manager.pluginNames
        }
    }

    function setPluginParameters(pluginParams) {
        if (! manager.pluginParameters) {
            manager.pluginParameters = pluginParams
            updatePlugins()
        }
    }

    function getPlugins() {
        if (typeof manager.geoservicePlugins === "undefined") {
            updatePlugins()
        }
        return manager.geoservicePlugins
    }
    function getPluginsDict() {
        if (typeof manager.geoservicePlugins === "undefined") {
            updatePlugins()
        }
        return manager.geoservicePluginsDict
    }

    function getRoutingPlugins() {
        if (!manager.routingPluginsDict)
            updatePlugins()
        return manager.routingPluginsDict
    }

    function getMappingPlugins() {
        if (!manager.mappingPluginsDict)
            updatePlugins()
        return manager.mappingPluginsDict
    }

    function getMappingPlugin(name)
    {
        if (!manager.mappingPluginsDict)
            updatePlugins()
        if (name in manager.mappingPluginsDict)
            return manager.mappingPluginsDict[name]

        return undefined
    }

    function getSupportedMapTypes(name)
    {
        if (!manager.dummyMapsDict)
            updateDummyMaps()
        if (name in manager.dummyMapsDict) {
            return manager.dummyMapsDict[name].supportedMapTypes
        } else
            console.log(name + " not in manager.dummyMapsDict")

        return []
    }

    function updatePlugins()
    {
        // Does this require to explicitly destroy current plugins?
        for (p in manager.geoservicePlugins) {
            p.destroy()
        }

        manager.geoservicePlugins = new Array()
        manager.geoservicePluginsDict = new Object()
        manager.mappingPluginsDict = new Object()
        manager.routingPluginsDict = new Object()

        var plugin_names = availablePluginNames()
        manager.allPluginParameters = manager.commonPluginParameters.concat(manager.pluginParameters)

        for (var i = 0; i < plugin_names.length; i++) {
            var plugin
//            if (manager.pluginParameters.length > 0)
                plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin{ name:"' + plugin_names[i] + '"; parameters: manager.allPluginParameters }', manager)
//            else
//                plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin{ name:"' + plugin_names[i] + '"}', manager)

            manager.geoservicePlugins.push(plugin)
            manager.geoservicePluginsDict[plugin_names[i]] = plugin

            if (plugin.supportsMapping(Plugin.AnyMappingFeatures))
                manager.mappingPluginsDict[plugin_names[i]] = plugin

            if (plugin.supportsRouting(Plugin.AnyRoutingFeatures))
                manager.routingPluginsDict[plugin_names[i]] = plugin
        }
    }

    function initializeDummyMaps()
    {
        var plugin_dict = getMappingPlugins();
        delete manager.dummyMapsDict
        manager.dummyMapsDict = new Object()
        for (var key in plugin_dict) {

            if (key in manager.dummyMapsDict) {
            } else {
                //console.log("Initializing map for "+key)
                var dummyMap = Qt.createQmlObject ('import QtLocation 5.6; Map { visible: false }', manager)
                dummyMap.plugin = plugin_dict[key]
                //console.log(dummyMap.plugin.parameters)
                manager.dummyMapsDict[key] = dummyMap

                dummyMap.supportedMapTypesChanged.connect( manager.supportedMapTypesChanged )
            }
        }
    }

    function updateDummyMaps() {
        for (var key in manager.dummyMapsDict) {
            manager.dummyMapsDict[key].destroy()
            delete manager.dummyMapsDict[key]
        }
        initializeDummyMaps()
    }

    /* Returns a
       {
            <plugin_name> : {
                                <mapTypeName | mapTypeCategory>
                                    : <pluginName>.<mapTypeName> | [ <pluginName>.<mapTypeName>, .. ]
                              }
       }

       access the relevant map type info by
       getMapTypes()[<pluginName>.<mapTypeName>]

       this returns a { "overlay" : true|false, "displayName" : <displayName>, "mapType" : MapType_Object }
     */
    function updateMapTypes() {
        var mappingPlugins_ = getMappingPlugins()
        manager.mapTypeNames = {}
        manager.mapTypes = {}

        for (var p in mappingPlugins_) {

            var availableMapTypes = getSupportedMapTypes(p)
            var pluginMapTypes = {}

            for (var mt in availableMapTypes) {

                var mapTypeName = availableMapTypes[mt].name
                var mapTypeDescription = availableMapTypes[mt].description
                var key = p + "." + mapTypeName

                var mapTypeRecord = {}
                mapTypeRecord["overlay"] = false
                if (mapTypeDescription.startsWith("o."))
                    mapTypeRecord["overlay"] = true
                mapTypeRecord["displayName"] = mapTypeName
                mapTypeRecord["mapType"] = availableMapTypes[mt]
                mapTypeRecord["mapTypeIndex"] = mt
                mapTypeRecord["plugin"] = mappingPluginsDict[p]

                manager.mapTypes[key] = mapTypeRecord

                if (mapTypeName.indexOf(".") > 0) { // Subcategory
                    var catName = mapTypeName.substring(0, mapTypeName.indexOf("."))

                    mapTypeRecord["displayName"] = mapTypeName.substring(mapTypeName.indexOf(".") + 1)

                    if (!(catName in pluginMapTypes))
                        pluginMapTypes[catName] = []

                    if (pluginMapTypes[catName].constructor === Array) {
                        pluginMapTypes[catName].push(key)
                    } else {
                        // key present and not array. Do nothing
                    }
                } else { // A map type not belonging to any subcategory
                    pluginMapTypes[mapTypeName] = key
                }
            }

            manager.mapTypeNames[p] = pluginMapTypes
        }
    }

    function getMapTypeNames()
    {
        if (! manager.mapTypeNames) {
            updateMapTypes()
        }
        return manager.mapTypeNames
    }

    function getMapTypes()
    {
        if (! manager.mapTypes) {
            updateMapTypes()
        }
        return manager.mapTypes
    }
}
