/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Adaptation of http://stackoverflow.com/questions/16408691/get-home-and-or-username-in-qml/21267162#21267162
** Copyright (C) user nocnockneo
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

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
