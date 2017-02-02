// Copyrights nocnockneo -- http://stackoverflow.com/questions/16408691/get-home-and-or-username-in-qml/21267162#21267162

#include "qmlsystemenvironment.h"
#include <stdlib.h>

#ifdef _WIN32
static int setenv(const char *name, const char *value, int /*overwrite*/)
{
    return _putenv_s(name, value);
}
static int unsetenv(const char *name)
{
    return setenv(name, "", 1);
}
#endif

QString QmlSystemEnvironment::variable(const QString& name)
{
   return getenv(name.toStdString().c_str());
}

void QmlSystemEnvironment::setVariable(const QString& name, const QString &value)
{
   setenv(name.toStdString().c_str(), value.toStdString().c_str(), 1);
}

void QmlSystemEnvironment::unsetVariable(const QString& name)
{
   unsetenv(name.toStdString().c_str());
}

QObject *qmlsystemenvironment_singletontype_provider(QQmlEngine *, QJSEngine *)
{
   return new QmlSystemEnvironment;
}
