// Copyrights nocnockneo -- http://stackoverflow.com/questions/16408691/get-home-and-or-username-in-qml/21267162#21267162

#ifndef QMLSYSTEMENVIRONMENT_H
#define QMLSYSTEMENVIRONMENT_H

#include <QObject>

class QQmlEngine;
class QJSEngine;

class QmlSystemEnvironment : public QObject
{
   Q_OBJECT
public:
   Q_INVOKABLE static QString variable(const QString &name);
   Q_INVOKABLE static void setVariable(const QString &name, const QString &variable);
   Q_INVOKABLE static void unsetVariable(const QString &name);
};

// Define the singleton type provider function (callback).
QObject *qmlsystemenvironment_singletontype_provider(QQmlEngine *, QJSEngine *);

#endif // QMLSYSTEMENVIRONMENT_H
