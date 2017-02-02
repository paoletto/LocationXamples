import QtQuick 2.4
import QtLocation 5.9

Item {
    id: plugins

    property var osm : osmPlugin
    property var esri: esriPlugin
    property var here: herePlugin
    property var mapbox: mapboxPlugin
    property var mapboxgl: mapboxglPlugin

    Plugin {
        id: osmPlugin
        name: "osm"
        PluginParameter{ name: "osm.mapping.custom.host"; value: "http://c.tiles.wmflabs.org/hillshading/"}
        PluginParameter{ name: "osm.mapping.custom.mapcopyright"; value: "The <a href='https://wikimediafoundation.org/wiki/Terms_of_Use'>WikiMedia Foundation</a>"}
    }

    Plugin {
        id: mapboxPlugin
        name: "mapbox"
        PluginParameter{ name: "mapbox.access_token"; value: ""}
    }

    Plugin {
        id: mapboxglPlugin
        name: "mapboxgl"
        PluginParameter{ name: "mapboxgl.access_token"; value: ""}
    }

    Plugin {
        id: herePlugin
        name: "here"
        PluginParameter{ name: "here.token"; value: ""}
        PluginParameter{ name: "here.app_id"; value: ""}
    }

    Plugin {
        id: esriPlugin
        name: "esri"
    }

//    Plugin {
//        id: tilting
//        name: "tilting"
//    }
}
