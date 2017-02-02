#ifndef LOCATIONCOMPONENTS_H
#define LOCATIONCOMPONENTS_H

#include "qmlenvironmentvariable.h"
#include <QDebug>

#define registerLocationComponents(engine, s) \
    { \
        qDebug() << s; \
        engine.addImportPath(s); \
        qmlRegisterSingletonType<QmlEnvironmentVariable>("LocationComponents", 1, 0, \
                "EnvironmentVariable", qmlenvironmentvariable_singletontype_provider); \
    }

#endif
