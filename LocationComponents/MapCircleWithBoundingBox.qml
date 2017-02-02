import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

MapItemGroup {
    id: itemGroupFlower
    property alias position: mainCircle.center
    property var radius: 500 * 1000

    MapCircle {
        id: mainCircle
        center : QtPositioning.coordinate(40, 0)
        radius: parent.radius
        opacity: 1.0
        visible: true
        color: 'blue'

        MouseArea{
            anchors.fill: parent
            drag.target: parent
            id: maItemGroup
        }
        z : groupCircle.z + 1
    }

    MapRectangle {
        id: boundingBox
        topLeft: mainCircle.geoShape.boundingGeoRectangle().topLeft()
        bottomRight: mainCircle.geoShape.boundingGeoRectangle().bottomRight()
        color: 'crimson'
    }
}


