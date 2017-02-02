
function addMeridians(map, color, thickness) {
    var longi = -180.0
    for (var i=0; i<36; i++) {
        var meridianColor = color
        if (longi == -180.0)
            meridianColor = "red"
        var line = Qt.createQmlObject ("import QtQuick 2.5;"
                                      +"import QtLocation 5.6;"
                                      +"MapPolyline {"
                                      +"line.width: "+ thickness +";"
                                      +"line.color: '"+meridianColor+"'"
                                      +"}", map)
        line.addCoordinate(QtPositioning.coordinate(90,longi))
        line.addCoordinate(QtPositioning.coordinate(-90,longi))
        line.opacity = 0.4
        map.addMapItem(line)
        longi = longi + 10.0
    }
}
