TEMPLATE = subdirs

SUBDIRS += \
LocationComponents \
MapAddMeridians \
MapboxGLMulti \
MapCircleBothPoles \
MapCircleNorthPole \
MapCircleSouthPole \
MapConstrained \
MapCopyrightNotices \
MapEnabled \
MapGestureArea \
MapInFrame \
MapItemGroup \
MapItemsLayer \
MapItemView \
MapItemsPerformance \
MapLayers \
MapLayersDynamic \
MapLayersSwipeView \
MapObjectsSimple \
MapParameters \
MapPluginEsri \
MapPluginHere \
MapPluginHereHiDpi \
MapPluginMapbox \
MapPluginMapboxGL \
MapPluginMapboxGLEmpty \
MapPluginMapboxGLOffline \
MapParametersMapboxGL \
MapPluginMapboxGLExp \
MapPluginMapboxHiDpi \
MapPluginMapboxTokenEnvironment \
MapPluginOpenaccess \
MapPluginOsmHiDpi \
MapPluginOsmOffline \
MapPluginOsmOfflineNoNetwork \
MapPolygonSelfIntersections \
MapPolygon \
MapPolygons \
MapPolyline \
MapPolylineMapboxGL \
MapRoute \
MapRouteObject \
MapRectangle \
MapSetBearing \
MapText \
MapQuickItem3D \
#MapQuickItemQt3D \
MapVisibleArea \
MapDoubleClick \
MapQuickItemPerf \
MapQuickItemVideo \
MapQuickItemZoom \
MapQuickItem \
MapTileOverlay

greaterThan(QT_MINOR_VERSION, 9) {
    SUBDIRS += PluginTileoverlay
}
