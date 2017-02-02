import QtQuick 2.4

Item {
    property var crossColor: "deepskyblue"
    property var thickness: 2
    Rectangle {
        id: crossHairH
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.thickness
        color: parent.crossColor
        border.width: 0
    }
    Rectangle {
        id: crossHairV
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.thickness
        color: parent.crossColor
        border.width: 0
    }
}

