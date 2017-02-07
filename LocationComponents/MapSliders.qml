import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Row {
    id: containerRow
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    property var map
    property var fontSize : 14
    property var labelBackground : "transparent"

    Button {
        id: sliderToggler
        width: 32
        height: 96
        checkable: true
        checked: true
        anchors.verticalCenter: parent.verticalCenter

        style: ButtonStyle {
                background: Rectangle {
                    color: "transparent"
                    //border.color: "red"
                }
            }

        property real shear: 0.333
        property real buttonOpacity: 0.5

        Rectangle {
            width: 16
            height: 48
            color: "seagreen"
            antialiasing: true
            opacity: sliderToggler.buttonOpacity
            anchors.top: parent.top
            anchors.left: sliderToggler.checked ?  parent.left : parent.horizontalCenter
            transform: Matrix4x4 {
                property real d : sliderToggler.checked ? 1.0 : -1.0
                matrix:    Qt.matrix4x4(1.0,  d * sliderToggler.shear,    0.0,    0.0,
                                        0.0,    1.0,    0.0,    0.0,
                                        0.0,    0.0,    1.0,    0.0,
                                        0.0,    0.0,    0.0,    1.0)
            }
        }

        Rectangle {
            width: 16
            height: 48
            color: "seagreen"
            antialiasing: true
            opacity: sliderToggler.buttonOpacity
            anchors.top: parent.verticalCenter
            anchors.right: sliderToggler.checked ?  parent.right : parent.horizontalCenter
            transform: Matrix4x4 {
                property real d : sliderToggler.checked ? -1.0 : 1.0
                matrix:    Qt.matrix4x4(1.0,  d * sliderToggler.shear,    0.0,    0.0,
                                        0.0,    1.0,    0.0,    0.0,
                                        0.0,    0.0,    1.0,    0.0,
                                        0.0,    0.0,    0.0,    1.0)
            }
        }
    }

    Rectangle {
        id: sliderContainer
        height: parent.height
        width: sliderRow.width + 20
        visible: sliderToggler.checked
        color: Qt.rgba( 0, 191 / 255.0, 255 / 255.0, 0.1)
        //border.color: "blue"
        property var labelBorderColor: "transparent"
        property var slidersHeight : sliderContainer.height
                                     - rowSliderValues.height
                                     - rowSliderLabels.height
                                     - sliderColumn.spacing * 2
                                     - sliderColumn.topPadding
                                     - sliderColumn.bottomPadding

        Column {
            id: sliderColumn
            spacing: 16
            topPadding: 16
            bottomPadding: 16
            anchors.centerIn: parent

            // the sliders value labels
            Row {
                id: rowSliderValues
                spacing: sliderRow.spacing
                width: sliderRow.width
                property real entryWidth: zoomSlider.width
                property real entryHeight: 32 // Doesn't matter probably

                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelZoomValue
                        text: zoomSlider.value.toFixed(3)
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelBearingValue
                        text: bearingSlider.value.toFixed(2)
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelTiltValue
                        text: tiltSlider.value.toFixed(2)
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelFovValue
                        text: fovSlider.value.toFixed(2)
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
            } // rowSliderValues

            // The sliders row
            Row {
                spacing: 20
                id: sliderRow
                height: sliderContainer.slidersHeight

                Slider {
                    id: zoomSlider;
                    height: parent.height
                    orientation : Qt.Vertical
                    onValueChanged: {
                            containerRow.map.zoomLevel = value
                    }
                    Component.onCompleted: {
                        minimumValue = Qt.binding(function() { return containerRow.map.minimumZoomLevel; })
                        maximumValue = Qt.binding(function() { return containerRow.map.maximumZoomLevel; })
                        value = Qt.binding(function() { return containerRow.map.zoomLevel; })
                    }
                }
                Slider {
                    id: bearingSlider;
                    height: parent.height
                    minimumValue: 0;
                    maximumValue: 360;
                    orientation : Qt.Vertical
                    value: containerRow.map.bearing
                    onValueChanged: {
                        containerRow.map.bearing = value;
                    }
                }
                Slider {
                    id: tiltSlider;
                    height: parent.height
                    orientation : Qt.Vertical
                    onValueChanged: {
                        containerRow.map.tilt = value;
                    }
                    Component.onCompleted: {
                        minimumValue = Qt.binding(function() { return containerRow.map.minimumTilt; })
                        maximumValue = Qt.binding(function() { return containerRow.map.maximumTilt; })
                        value = Qt.binding(function() { return containerRow.map.tilt; })
                    }
                }
                Slider {
                    id: fovSlider;
                    height: parent.height
                    orientation : Qt.Vertical
                    onValueChanged: {
                        containerRow.map.fieldOfView = value;
                    }
                    Component.onCompleted: {
                        minimumValue = Qt.binding(function() { return containerRow.map.minimumFieldOfView; })
                        maximumValue = Qt.binding(function() { return containerRow.map.maximumFieldOfView; })
                        value = Qt.binding(function() { return containerRow.map.fieldOfView; })
                    }
                }
            } // Row sliders

            // The labels row
            Row {
                id: rowSliderLabels
                spacing: sliderRow.spacing
                width: sliderRow.width
                property real entryWidth: zoomSlider.width
                property real entryHeight: 64 // Doesn't matter probably

                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelZoom
                        text: "Zoom"
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }

                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelBearing
                        text: "Bearing"
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelTilt
                        text: "Tilt"
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    color: labelBackground
                    height: parent.entryHeight
                    width: parent.entryWidth
                    border.color: sliderContainer.labelBorderColor
                    Label {
                        id: labelFov
                        text: "FoV"
                        font.pixelSize: fontSize
                        rotation: -90
                        anchors.centerIn: parent
                    }
                }
            } // rowSliderLabels
        } // Column
    } // sliderContainer
} // containerRow
