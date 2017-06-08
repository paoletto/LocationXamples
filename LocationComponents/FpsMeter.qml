import QtQuick 2.0

Rectangle {
    id: meter

    property int measuringInterval: 500

    clip: true
    width: parent.width
    height: 14
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    color: Qt.hsla(0, 0, 1, 0.8);
    property real fps: 0

    Rectangle {
        id: swapTest
        anchors.right: parent.right
        width: parent.height
        height: parent.height
        property real t;
        NumberAnimation on t { from: 0; to: 1; duration: 1000; loops: Animation.Infinite }
        property bool inv;
        onTChanged: {
            ++fpsTimer.tick;
            inv = !inv;
        }
        color: inv ? "red" : "blue"
    }

    Timer {
        id: fpsTimer
        running: true;
        repeat: true
        interval: parent.measuringInterval
        property var lastFrameTime: new Date();
        property int tick;

        onTriggered: {
            var now = new Date();
            var dt = now.getTime() - lastFrameTime.getTime();
            lastFrameTime = now;
            var fps = (tick * 1000) / dt;
            meter.fps = Math.round(fps * 10) / 10;
            tick = 0;

            label.updateSelf();
        }
    }

    Text {
        id: label
        anchors.centerIn: parent
        font.pixelSize: 10

        function updateSelf() {
            text = "FPS=" + meter.fps;
        }
    }


}
