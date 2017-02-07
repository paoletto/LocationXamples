import QtQuick 2.6
import QtQuick.Controls 1.4

Rectangle {
    id: containerRow
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    width: sliderContainer.width

    property var map
    property var fontSize : 14
    property var labelBackground : "transparent"

    Rectangle {
        id: sliderContainer
        height: parent.height
        width: sliderRow.width + 40
        //visible: sliderToggler.checked
        color: Qt.rgba( 0, 191 / 255.0, 255 / 255.0, 0.1)
        border.color: "blue"
        property var slidersHeight : sliderContainer.height
                                     - rowSliderValues.height
                                     - rowSliderLabels.height
                                     - sliderColumn.spacing * 2
                                     - sliderColumn.topPadding
                                     - sliderColumn.bottomPadding

        Rectangle {
            color: "yellow"
            anchors.fill: sliderColumn
        }

        Column {
            id: sliderColumn
            spacing: 16
            topPadding: 16
            bottomPadding: 16
            anchors.centerIn: parent

            // the sliders value labels
//            Rectangle {
//                id: rowSlidersValuesContainer
//                height: 50
//                width: sliderRow.width
//                color: "transparent"

                Row {
                    id: rowSliderValues
                    spacing: sliderRow.spacing
                    width: sliderRow.width
//                    property int itemCount: 4
//                    property real totalSpacing: (itemCount - 1) * spacing
//                    property real availableWidth: rowSliderValues.width - totalSpacing
//                    property var entryWidth : availableWidth / itemCount
                    property real entryWidth: zoomSlider.width
                    property real entryHeight: 32 // Doesn't matter probably

                    Rectangle{
                        color: labelBackground
                        height: parent.entryHeight
                        width: parent.entryWidth
                        border.color: "red"
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
                        border.color: "red"
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
                        border.color: "red"
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
                        border.color: "red"
                        Label {
                            id: labelFovValue
                            text: fovSlider.value.toFixed(2)
                            font.pixelSize: fontSize
                            rotation: -90
                            anchors.centerIn: parent
                        }
                    }
                } // rowSliderValues
//            } // rowSlidersValuesContainer

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
//            Rectangle {
//                id: rowSliderLabelsContainer
//                height: 50
//                width: parent.width
//                color: "transparent"

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
                        border.color: "red"
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
                        border.color: "red"
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
                        border.color: "red"
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
                        border.color: "red"
                        Label {
                            id: labelFov
                            text: "FoV"
                            font.pixelSize: fontSize
                            rotation: -90
                            anchors.centerIn: parent
                        }
                    }

                }
//            } // rowSliderLabelsContainer

        } // Column
    } // sliderContainer
} // containerRow
