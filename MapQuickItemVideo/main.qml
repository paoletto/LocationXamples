/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** This file is licensed under the GNU GPL V3+ license
**
****************************************************************************/

import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtPositioning 5.6
import QtLocation 5.9
import LocationComponents 1.0
import QtMultimedia 5.8

Window {
    id: win
    visible: true
    width: 640
    height: 640
    property var copyVisible : false

    GeoservicePlugins {
        id: plugins
    }

    MapWithSliders {
        id: map
        anchors.fill: parent
        opacity: 1.0
        color: 'transparent'
        plugin: plugins.mapboxgl
        zoomLevel: 17
        activeMapType: map.supportedMapTypes[3]
        fieldOfView: 90
        center: QtPositioning.coordinate(37.562984, -122.514426)

        MapPolygon {
            id: poly
            color: "transparent"
            border.color: "red"
            path: [
                { longitude: -122.51596391201019, latitude: 37.56238816766053},
                { longitude: -122.51467645168304, latitude: 37.56410183312965},
                { longitude: -122.51309394836426, latitude: 37.563391708549425},
                { longitude: -122.51423120498657, latitude: 37.56161849366671}
            ]
            z: markerTest.z + 1
        }

        onSupportedMapTypesChanged: {
            console.log("Plugin changed")
            markerTest.updateSize()
            //map.center = QtPositioning.coordinate(37.562984, -122.514426)
        }

        MapQuickItem {
            id: markerTest

            coordinate: QtPositioning.coordinate(37.56238816766053, -122.51596391201019)
            zoomLevel: 17

            function subP(a, b)
            {
                return Qt.point(a.x - b.x, a.y - b.y)
            }

            function updateSize() {
                map.zoomLevel = 17

                var tl = map.fromCoordinate(poly.path[0], false)
                var tr = map.fromCoordinate(poly.path[1], false)
                var br = map.fromCoordinate(poly.path[2], false)
                var bl = map.fromCoordinate(poly.path[3], false)

                var tlt = subP(tl, tl);
                var trt = subP(tr, tl);
                var brt = subP(br, tl);
                var blt = subP(bl, tl);


                console.log(tlt)
                console.log(trt)
                console.log(brt)
                console.log(blt)

                // The following isn't really necessary
//                var sizew = Math.sqrt(Math.pow((tr.x - tl.x), 2.0) + Math.pow((tr.y - tl.y), 2.0))
//                videoContainer.width = sizew
//                var sizeh = Math.sqrt(Math.pow((bl.x - tl.x), 2.0) + Math.pow((bl.y - tl.y), 2.0))
//                videoContainer.height = sizeh


                matTransform.updateMatrix(tlt, trt, brt, blt, videoContainer.width, videoContainer.height)


            }

            sourceItem: Rectangle {
                id: videoContainer
                color: "transparent"
                //border.color: "red"
                width: 256
                height: width
                opacity: 1.0

                transform: Matrix4x4 {
                    id: matTransform
                    matrix: Qt.matrix4x4();

                    function updateMatrix(tl, tr, br, bl, w, h)
                    {
                        // Poor man georeferencing using 4 points correspondence and a projective transformation.
                        // (C) The GIMP
                        var     scalex;
                        var     scaley;

                        scalex = scaley = 1.0;
                        scalex = 1.0 / w;
                        scaley = 1.0 / h;

                        var matScale = Qt.matrix4x4();
                        matScale.scale(scalex, scaley, 1.0);

                        var t_x1=tl.x
                        var t_y1=tl.y
                        var t_x2=tr.x
                        var t_y2=tr.y
                        var t_x4=br.x
                        var t_y4=br.y
                        var t_x3=bl.x
                        var t_y3=bl.y

                        var dx1, dx2, dx3, dy1, dy2, dy3;

                        dx1 = t_x2 - t_x4;
                        dx2 = t_x3 - t_x4;
                        dx3 = t_x1 - t_x2 + t_x4 - t_x3;

                        dy1 = t_y2 - t_y4;
                        dy2 = t_y3 - t_y4;
                        dy3 = t_y1 - t_y2 + t_y4 - t_y3;

                        var det1, det2;

                        det1 = dx3 * dy2 - dy3 * dx2;
                        det2 = dx1 * dy2 - dy1 * dx2;

                        var t20 = (det2 == 0.0) ? 1.0 : det1 / det2;

                        det1 = dx1 * dy3 - dy1 * dx3;

                        var t21 = (det2 == 0.0) ? 1.0 : det1 / det2;

                        var t00 = t_x2 - t_x1 + t20 * t_x2;
                        var t01 = t_x3 - t_x1 + t21 * t_x3;
                        var t02 = t_x1;

                        var t10 = t_y2 - t_y1 + t20 * t_y2;
                        var t11 = t_y3 - t_y1 + t21 * t_y3;
                        var t12 = t_y1;

                        var trafo = Qt.matrix4x4(t00, t01, t02, 0.0,
                                                 t10, t11, t12, 0.0,
                                                 0.0, 0.0, 0.0, 0.0,
                                                 t20, t21, 0.0, 1.0);

                        trafo.scale(scalex, scaley, 1.0);
                        matTransform.matrix = trafo;
                    }
                }

                // Hack to make the playback seem gapless. Not a great hack, though
                ShaderEffectSource {
                    anchors.fill: parent
                    id: shaEffectSource
                    width: 960
                    height: 540
                    sourceItem: video
                }

                Video {
                    id: video
                    anchors.fill: parent
                    autoLoad: true
                    autoPlay: true
                    visible: true
                    z: shaEffectSource.z + 1
                    fillMode: VideoOutput.Stretch
                    source: "https://www.mapbox.com/drone/video/drone.mp4"
                    onPlaybackStateChanged: {
                        if (video.playbackState == MediaPlayer.StoppedState) {
                            shaEffectSource.live = false;
                            video.play()
                        } else {
                            z = shaEffectSource.z + 1
                        }
                    }
                }
            }
        }
    }
}
