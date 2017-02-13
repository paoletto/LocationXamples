#ifndef LOCATIONCOMPONENTS_H
#define LOCATIONCOMPONENTS_H

#include "qmlsystemenvironment.h"
#include <QDebug>

#define str(x) #x
#define xstr(x) str(x)

#define registerLocationComponents(engine) \
    { \
        qDebug() << xstr(LOCATION_COMPONENTS_PWD); \
        const QByteArray additionalLibraryPaths = qgetenv("QTLOCATION_EXTRA_LIBRARY_PATH"); \
        for (const QByteArray &p : additionalLibraryPaths.split(':')) \
            QCoreApplication::addLibraryPath(QString(p)); \
        QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling); \
        engine.addImportPath(xstr(LOCATION_COMPONENTS_PWD)); \
        qmlRegisterSingletonType<QmlSystemEnvironment>("LocationComponents", 1, 0, \
                "SystemEnvironment", qmlsystemenvironment_singletontype_provider); \
    }

#endif
