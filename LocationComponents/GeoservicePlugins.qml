import QtQuick 2.4
import QtLocation 5.9
import LocationComponents 1.0

Item {
    id: plugins

    property var osm : osmPlugin
    property var esri: esriPlugin
    property var here: herePlugin
    property var mapbox: mapboxPlugin
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

    property var mapboxPlugin
    property var mapboxglPlugin
    property var herePlugin

    onMapboxAccessTokenChanged: {
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
        mapboxPlugin = Qt.createQmlObject(
                   "import QtQuick 2.4;
                    import QtLocation 5.9;
                    Plugin {
                        name: 'mapbox';
                        PluginParameter {
                            name: \"mapboxgl.access_token\" ;
                            value: '"+mapboxAccessToken+"';
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
