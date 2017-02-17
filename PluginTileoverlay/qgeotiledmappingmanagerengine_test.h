/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the test suite of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL-EXCEPT$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QGEOTILEDMAPPINGMANAGERENGINE_TEST_H
#define QGEOTILEDMAPPINGMANAGERENGINE_TEST_H

#include <QtCore/QLocale>
#include <QtLocation/QGeoServiceProvider>
#include <QtLocation/private/qgeotiledmappingmanagerengine_p.h>
#include <QtLocation/private/qgeotiledmapreply_p.h>
#include <QtLocation/private/qgeomaptype_p.h>
#include <QtLocation/private/qgeocameracapabilities_p.h>
#include <QtLocation/private/qgeofiletilecache_p.h>

#include "qgeotiledmap_test.h"
#include "qgeotilefetcher_test.h"

QT_BEGIN_NAMESPACE

class QGeoTiledMappingManagerEngineTest: public QGeoTiledMappingManagerEngine
{
Q_OBJECT
public:
    QGeoTiledMappingManagerEngineTest(const QVariantMap &parameters,
        QGeoServiceProvider::Error *error, QString *errorString) :
        QGeoTiledMappingManagerEngine()
    {
        Q_UNUSED(error)
        Q_UNUSED(errorString)

        setLocale(QLocale (QLocale::German, QLocale::Germany));
        QGeoCameraCapabilities capabilities;
        capabilities.setMinimumZoomLevel(0.0);
        capabilities.setMaximumZoomLevel(20.0);
        capabilities.setSupportsBearing(true);
        capabilities.setSupportsTilting(true);
        capabilities.setMinimumTilt(0);
        capabilities.setMaximumTilt(60);
        setTileSize(QSize(256, 256));

        QList<QGeoMapType> mapTypes;
        mapTypes << QGeoMapType(QGeoMapType::StreetMap, tr("StreetMap"), tr("StreetMap"), false, false, 1);
        mapTypes << QGeoMapType(QGeoMapType::SatelliteMapDay, tr("SatelliteMapDay"), tr("SatelliteMapDay"), false, false, 2);
        mapTypes << QGeoMapType(QGeoMapType::CycleMap, tr("CycleMap"), tr("CycleMap"), false, false, 3);
        setSupportedMapTypes(mapTypes);

        QGeoTileFetcherTest *fetcher = new QGeoTileFetcherTest(this);
        if (parameters.contains(QStringLiteral("tileoverlay.tileSize"))) {
            int tileSize = parameters.value(QStringLiteral("tileoverlay.tileSize")).toInt();
            setTileSize(QSize(tileSize, tileSize));
        }
        if (parameters.contains(QStringLiteral("tileoverlay.maxZoomLevel"))) {
            double maxZoomLevel = parameters.value(QStringLiteral("tileoverlay.maxZoomLevel")).toDouble();
            capabilities.setMaximumZoomLevel(maxZoomLevel);
        }
        if (parameters.contains(QStringLiteral("tileoverlay.backgroundColor"))) {
            qDebug() << "setting backgroundColor";
            QColor bgColor = QColor( parameters.value(QStringLiteral("tileoverlay.backgroundColor")).toString() );
            fetcher->setBackgroundColor(bgColor);
        }
        if (parameters.contains(QStringLiteral("tileoverlay.textColor"))) {
            qDebug() << "setting textColor";
            QColor textColor = QColor( parameters.value(QStringLiteral("tileoverlay.textColor")).toString() );
            fetcher->setTextColor(textColor);
        }

        setCameraCapabilities(capabilities);
        fetcher->setTileSize(tileSize());
        setTileFetcher(fetcher);

        QGeoFileTileCache *tileCache = new QGeoFileTileCache("");
        tileCache->setMaxDiskUsage(0);
        tileCache->setMaxMemoryUsage(100 * 1024 * 1024);
        setTileCache(tileCache);
    }

    QGeoMap *createMap()
    {
        return new QGeoTiledMapTest(this);
    }

};

QT_END_NAMESPACE

#endif
