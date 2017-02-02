import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

MapCircle {
    id: northPoleCircle
    color: 'crimson'
    border.width: 7
    //center: QtPositioning.coordinate(-15,70)
    center: QtPositioning.coordinate(12,-179)
    radius: 9200 * 1000
    antialiasing: true
}


