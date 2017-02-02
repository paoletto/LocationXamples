import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

MapQuickItem{
    id: mqi
    coordinate: QtPositioning.coordinate(19,50)
    opacity: 1

    sourceItem: Rectangle{
        width:40
        height:40
        color:'red'
        border.width: 2;
        border.color: "white";
        smooth: true;
        radius: 5

        MapCrosshair {
            anchors.fill: parent
        }

        MouseArea{
            anchors.fill: parent
            drag.target: mqi
        }
    }
}
