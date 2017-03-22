/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
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

#include "locationcomponents.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqml.h>
#include "qmlcube.h"
#include <QtGui/qopenglcontext.h>

bool OGLSupports(int major, int minor, bool gles = false, QSurfaceFormat::OpenGLContextProfile profile = QSurfaceFormat::NoProfile)
{
    QOpenGLContext ctx;
    QSurfaceFormat fmt;
    fmt.setVersion(major, minor);
    if (gles) {
        fmt.setRenderableType(QSurfaceFormat::OpenGLES);
    } else {
        fmt.setRenderableType(QSurfaceFormat::OpenGL);
        fmt.setProfile(profile);
    }

    ctx.setFormat(fmt);
    ctx.create();
    if (!ctx.isValid())
        return false;
    int ctxMajor = ctx.format().majorVersion();
    int ctxMinor = ctx.format().minorVersion();
    bool isGles = (ctx.format().renderableType() == QSurfaceFormat::OpenGLES);

    if (isGles != gles) return false;
    if (ctxMajor < major) return false;
    if (ctxMajor == major && ctxMinor < minor)
        return false;
    if (!gles && ctx.format().profile() != profile)
        return false;
    return true;
}

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QSurfaceFormat fmt;
    fmt.setDepthBufferSize(24);

    if (OGLSupports(3,3,false,QSurfaceFormat::CompatibilityProfile)) {
        qDebug("Requesting 3.3 core context");
        fmt.setVersion(3, 3);
        fmt.setRenderableType(QSurfaceFormat::OpenGL);
        fmt.setProfile(QSurfaceFormat::CompatibilityProfile);
    }
    else {
        qWarning("Error: OpenGL support is too old. Exiting.");
        return -1;
    }
    QSurfaceFormat::setDefaultFormat(fmt);

    QQmlApplicationEngine engine;
    registerLocationComponents(engine);
    qmlRegisterType<QmlCube>("LocationComponents", 1, 0, \
            "Cube");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
