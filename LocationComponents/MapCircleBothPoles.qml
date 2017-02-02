import QtQuick 2.4
import QtPositioning 5.6
import QtLocation 5.9

MapCircle {
    id: twoPolesCircle
    color: 'blue'
    border.color: 'blue'
    border.width: 4
    opacity: 1.0
    radius: 11500 * 1000
    center: QtPositioning.coordinate(7, 10)

//    Component.onCompleted: {
//        var northIn = centerCircle.center.atDistanceAndAzimuth(centerCircle.radius - 10, 0)
//        var northOut = centerCircle.center.atDistanceAndAzimuth(centerCircle.radius + 10, 0)
//        var southIn = centerCircle.center.atDistanceAndAzimuth(centerCircle.radius - 10, 180)
//        var southOut = centerCircle.center.atDistanceAndAzimuth(centerCircle.radius + 10, 180)
//        console.log(northIn.latitude + " " + northIn.longitude)
//        console.log(northOut.latitude + " " + northOut.longitude)
//        console.log(southIn.latitude + " " + southIn.longitude)
//        console.log(southOut.latitude + " " + southOut.longitude)
//    }
}


