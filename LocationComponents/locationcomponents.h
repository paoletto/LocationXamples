#ifndef LOCATIONCOMPONENTS_H
#define LOCATIONCOMPONENTS_H

#include "qmlenvironmentvariable.h"
#include <QDebug>

#define FOO "/media/paolo/qdata/home/paolo/Qt/Location/playground/LocationXamples"

#define registerLocationComponents(engine) \
    { \
        qDebug() << LOCATION_COMPONENTS_PWD; \
        engine.addImportPath(LOCATION_COMPONENTS_PWD); \
        qmlRegisterSingletonType<QmlEnvironmentVariable>("LocationComponents", 1, 0, \
                "EnvironmentVariable", qmlenvironmentvariable_singletontype_provider); \
    }

#endif
