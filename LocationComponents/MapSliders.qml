import QtQuick 2.4
import QtQuick.Controls 1.4

Rectangle {
    id: sliderContainer
    z : parent.z + 10
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    width: sliderRow.width + 40
    //visible: sliderToggler.checked
    color: Qt.rgba( 0, 191 / 255.0, 255 / 255.0, 0.1)

    property var map

    // the sliders value
    Rectangle {
        id: rowSlidersValuesContainer
        height: 50
        color: "transparent"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.rightMargin: 25
        anchors.leftMargin: 20
        anchors.bottomMargin: 0
        Row {
            id: rowSliderValues
            spacing: 16
            anchors.fill : parent

            property var fontSize : 14
            property var rectangleColor : "transparent"

            Rectangle{
                color: parent.rectangleColor
                width: labelZoomValue.height
                height: labelZoomValue.width
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    id: labelZoomValue
                    text: zoomSlider.value.toFixed(3)
                    font.pixelSize: rowSliderLabels.fontSize
                    rotation: -90
    //                transform: Rotation {
    //                    angle: -90
    //                } // rotate this text item
                    anchors.centerIn: parent
                }
            }

            Rectangle{
                color: parent.rectangleColor
                width: labelBearingValue.height
                height: labelBearingValue.width
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    id: labelBearingValue
                    text: bearingSlider.value.toFixed(2)
                    font.pixelSize: rowSliderLabels.fontSize
                    rotation: -90
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                color: parent.rectangleColor
                width: labelTiltValue.height
                height: labelTiltValue.width
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    id: labelTiltValue
                    text: tiltSlider.value.toFixed(2)
                    font.pixelSize: rowSliderLabels.fontSize
                    rotation: -90
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                color: parent.rectangleColor
                width: labelFovValue.height
                height: labelFovValue.width
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    id: labelFovValue
                    text: fovSlider.value.toFixed(2)
                    font.pixelSize: rowSliderLabels.fontSize
                    rotation: -90
                    anchors.centerIn: parent
                }
            }
//            Rectangle{
//                color: parent.rectangleColor
//                width: labelFovValue.height
//                height: labelFovValue.width
//                anchors.verticalCenter: parent.verticalCenter
//                Label {
//                    id: labelClipValue
//                    text: clipSlider.value.toFixed(2)
//                    font.pixelSize: rowSliderLabels.fontSize
//                    rotation: -90
//                    anchors.centerIn: parent
//                }
//            }
        }
    }

    // The sliders row
    Row {
        spacing: 20
        id: sliderRow
        anchors.top: rowSlidersValuesContainer.bottom
        anchors.bottom: rowSliderLabelsContainer.top
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 10
        anchors.bottomMargin: 0

        Slider {
            id: zoomSlider;
            minimumValue: map.minimumZoomLevel;
            maximumValue: map.maximumZoomLevel;
            anchors.margins: 30
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            orientation : Qt.Vertical
            value: map.zoomLevel
            onValueChanged: {
                    map.zoomLevel = value
            }
        }

        Slider {
            id: bearingSlider;
            minimumValue: 0;
            maximumValue: 360;
            anchors.margins: 30
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            orientation : Qt.Vertical
            value: map.bearing
            onValueChanged: {
                map.bearing = value;
            }
        }

        Slider {
            id: tiltSlider;
            minimumValue: map.minimumTilt;
            maximumValue: map.maximumTilt;
            anchors.margins: 30
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            orientation : Qt.Vertical
            value: map.tilt
            onValueChanged: {
                map.tilt = value;
            }
        }

        Slider {
            id: fovSlider;
            minimumValue: map.minimumFieldOfView;
            maximumValue: map.maximumFieldOfView;
            anchors.margins: 30
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            orientation : Qt.Vertical
            value: map.fieldOfView
            onValueChanged: {
                map.fieldOfView = value;
            }
        }

//        Slider {
//            id: clipSlider;
//            minimumValue: 0.01;
//            maximumValue: 100;
//            anchors.margins: 30
//            anchors.bottom: parent.bottom
//            anchors.top: parent.top
//            orientation : Qt.Vertical
//            value: 6
//            onValueChanged: {
//                map.clipDistance = value;
//            }
//        }
    }

    // The labels row
    Rectangle {
        id: rowSliderLabelsContainer
        height: 50
        color: "transparent"
        //opacity: 0.3
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottomMargin: 45
        anchors.rightMargin: 25
        anchors.leftMargin: 20
        anchors.topMargin: 0
        Row {
            id: rowSliderLabels
            spacing: 16
            anchors.fill : parent

            property var fontSize : 14
            property var rectangleColor : "transparent"

            Rectangle{
                color: parent.rectangleColor
                width: labelZoom.height
                height: labelZoom.width
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    id: labelZoom
                    text: "Zoom"
                    font.pixelSize: rowSliderLabels.fontSize
                    rotation: -90
    //                transform: Rotation {
    //                    angle: -90
    //                } // rotate this text item
                    anchors.centerIn: parent
                }
            }

            Rectangle{
                color: parent.rectangleColor
                width: labelBearing.height
                height: labelBearing.width
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    id: labelBearing
                    text: "Bearing"
                    font.pixelSize: rowSliderLabels.fontSize
                    rotation: -90
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                color: parent.rectangleColor
                width: labelTilt.height
                height: labelTilt.width
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    id: labelTilt
                    text: "Tilt"
                    font.pixelSize: rowSliderLabels.fontSize
                    rotation: -90
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                color: parent.rectangleColor
                width: labelFov.height
                height: labelFov.width
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    id: labelFov
                    text: "FOV"
                    font.pixelSize: rowSliderLabels.fontSize
                    rotation: -90
                    anchors.centerIn: parent
                }
            }
//            Rectangle{
//                color: parent.rectangleColor
//                width: labelFov.height
//                height: labelFov.width
//                anchors.verticalCenter: parent.verticalCenter
//                Label {
//                    id: labelClip
//                    text: "Clip"
//                    font.pixelSize: rowSliderLabels.fontSize
//                    rotation: -90
//                    anchors.centerIn: parent
//                }
//            }
        }
    }
}

