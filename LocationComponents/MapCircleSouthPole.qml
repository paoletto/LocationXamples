import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

MapCircle {
    id: northPoleCircle
    color: 'crimson'
    border.width: 7
    opacity: 0.4
    center: QtPositioning.coordinate(-22,-179)
    radius: 8800 * 1000
    antialiasing: true
}

