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

#include "qmlcube.h"
#include <QtQuick/qsgrendernode.h>
#include <QtGui/qopenglshaderprogram.h>
#include <QtGui/qopenglcontext.h>
#include <QtGui/qopenglextrafunctions.h>
#include <QtGui/QOpenGLVertexArrayObject>
#include <QDebug>

class QmlCubeRenderNode : public QSGRenderNode
{
public:
    QmlCubeRenderNode(QmlCube *cube);
    ~QmlCubeRenderNode();

    void render(const RenderState *state) Q_DECL_OVERRIDE;
    void releaseResources() Q_DECL_OVERRIDE;
    StateFlags changedStates() const Q_DECL_OVERRIDE;
    RenderingFlags flags() const Q_DECL_OVERRIDE;
    QRectF rect() const Q_DECL_OVERRIDE;

private:
    QmlCube *m_cube;
    QOpenGLVertexArrayObject *m_vao;
    QOpenGLShaderProgram *m_shader;
    QOpenGLShaderProgram *m_shaderBlending;
};

QmlCubeRenderNode::QmlCubeRenderNode(QmlCube *cube): m_cube(cube), m_shader(0), m_vao(0)
{

}

QmlCubeRenderNode::~QmlCubeRenderNode()
{

}

static QByteArray versionedShaderCode(const char *src)
{
    QByteArray versionedSrc;
    versionedSrc.append(QByteArrayLiteral("#version 330\n"));
    versionedSrc.append(src);
    return versionedSrc;
}

void QmlCubeRenderNode::render(const QSGRenderNode::RenderState *state)
{
    QMatrix4x4 matScale;
    matScale.scale(m_cube->width(), m_cube->height(), m_cube->width());
    QMatrix4x4 transformation = *state->projectionMatrix() * *matrix() * matScale;

    // Do the GL rendering

    if (!m_vao) {
        m_vao = new QOpenGLVertexArrayObject;
        m_vao->create();
    }

    if (!m_shader) {
        // Create shaders
        static const char *vertexShaderSource =
            "const int ids[36] = int[36] (\n"
            "2,3,1,2,1,0, // back face\n"
            "6,2,4,4,2,0, // top face\n"
            "5,1,7,7,1,3, // bottom face\n"
            "4,0,5,5,0,1, // left face\n"
            "7,3,6,6,3,2, // right face\n"
            "4,5,6,6,5,7 // front face\n"
            ");\n"
            "const vec4 vertices[9] = vec4[9] ( // Triangle strip order \n"
            "        vec4( 0.0,   0.0, 0.0, 1.0),\n"
            "        vec4( 0.0,   1.0, 0.0, 1.0),\n"
            "        vec4( 1.0,   0.0, 0.0, 1.0),\n"
            "        vec4( 1.0,   1.0, 0.0, 1.0),\n"
            "        vec4( 0.0,   0.0, 1.0, 1.0),\n"
            "        vec4( 0.0,   1.0, 1.0, 1.0),\n"
            "        vec4( 1.0,   0.0, 1.0, 1.0),\n"
            "        vec4( 1.0,   1.0, 1.0, 1.0),\n"
            "        vec4( 0.0,   0.0, 0.0, 0.0)\n"
            ");\n"
            "const vec3 texCoords[9] = vec3[9] (\n"
            "        vec3( 0.0,  0.0,  0.0),\n"
            "        vec3( 0.0,  1.0,  0.0),\n"
            "        vec3( 1.0,  0.0,  0.0),\n"
            "        vec3( 1.0,  1.0,  0.0),\n"
            "        vec3( 0.0,  0.0,  1.0),\n"
            "        vec3( 0.0,  1.0,  1.0),\n"
            "        vec3( 1.0,  0.0,  1.0),\n"
            "        vec3( 1.0,  1.0,  1.0),\n"
            "        vec3( 0.0,  0.0,  0.0)\n"
            ");\n"
            "out highp vec3 texCoord;\n"
            "uniform highp mat4 projection;\n"
            "void main() {\n"
            "   texCoord = texCoords[ids[gl_VertexID]];\n"
            "   gl_Position = projection * vertices[ids[gl_VertexID]];\n"
            "}\n";
        static const char *fragmentShaderSource =
            "in highp vec3 texCoord;\n"
            "layout(location = 0) out lowp vec4 color;\n"
            "void main() {\n"
            "   color = vec4(texCoord.rgb - vec3(2,2,2), 0.0);\n"
            "}\n";

        static const char *fragmentShaderSourceBlending =
            "in highp vec3 texCoord;\n"
            "layout(location = 0) out lowp vec4 color;\n"
            "void main() {\n"
            "   color = vec4(texCoord.rgb, 0.5);\n"
            "   //gl_FragDepth = 0.0;\n"
            "}\n";

        m_shader = new QOpenGLShaderProgram;
        m_shader->addShaderFromSourceCode(QOpenGLShader::Vertex, versionedShaderCode(vertexShaderSource));
        m_shader->addShaderFromSourceCode(QOpenGLShader::Fragment, versionedShaderCode(fragmentShaderSource));
        m_shader->link();

        m_shaderBlending = new QOpenGLShaderProgram;
        m_shaderBlending->addShaderFromSourceCode(QOpenGLShader::Vertex, versionedShaderCode(vertexShaderSource));
        m_shaderBlending->addShaderFromSourceCode(QOpenGLShader::Fragment, versionedShaderCode(fragmentShaderSourceBlending));
        m_shaderBlending->link();
    }

   QOpenGLExtraFunctions *f = QOpenGLContext::currentContext()->extraFunctions();


//   f->glClearDepthf(1.0f);
//   f->glClear(GL_DEPTH_BUFFER_BIT);

   // To do proper surface-only semitransparency, 2 pass rendering
   // Pass 1: write only the depth buffer, not the color buffer
   // Pass 2: depth function LE, write color too


    f->glEnable(GL_DEPTH_TEST);
    f->glDepthFunc(GL_LESS);
    f->glDepthMask(true);
    f->glColorMask(false,false,false,false);

    m_shader->bind();
    m_shader->setUniformValue("projection", transformation);
    f->glDrawArrays(GL_TRIANGLES, 0, 36);
    m_shader->release();

    f->glDepthFunc(GL_LEQUAL);
    f->glDepthMask(false);
    f->glColorMask(true,true,true,true);
    f->glEnable(GL_BLEND);
    f->glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

    m_shaderBlending->bind();
    m_shaderBlending->setUniformValue("projection", transformation);
    m_vao->bind();
    f->glDrawArrays(GL_TRIANGLES, 0, 36);
    m_vao->release();
    m_shaderBlending->release();
    f->glDisable(GL_DEPTH_TEST);
    f->glDisable(GL_BLEND);

}

void QmlCubeRenderNode::releaseResources()
{
    if (m_shader)
        delete m_shader;
    m_shader = 0;

    if (m_shaderBlending)
        delete m_shaderBlending;
    m_shaderBlending = 0;

    if (m_vao)
        delete m_vao;
    m_vao = 0;
}

QSGRenderNode::StateFlags QmlCubeRenderNode::changedStates() const
{
    return BlendState
          | DepthState
          | StencilState
          | ScissorState
          | ColorState
          | CullState
          | ViewportState
          | RenderTargetState;
}

QSGRenderNode::RenderingFlags QmlCubeRenderNode::flags() const
{
    return
//            BoundedRectRendering
            DepthAwareRendering
//            | OpaqueRendering
            ;
}

QRectF QmlCubeRenderNode::rect() const
{
    return QRectF(0, 0, m_cube->width() , m_cube->height());
}



QmlCube::QmlCube()
{
    setFlag(ItemHasContents);
}

bool QmlCube::contains(const QPointF &point) const
{
    qDebug() << "QmlCube contains called";
    return QQuickItem::contains(point);
}

QSGNode *QmlCube::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *data)
{
    Q_UNUSED(data);

    if (width() <= 0 || height() <= 0) {
        delete oldNode;
        oldNode = 0;
        return 0;
    }

    QmlCubeRenderNode *cubeNode = static_cast<QmlCubeRenderNode *>(oldNode);
    if (!cubeNode)
        cubeNode = new QmlCubeRenderNode(this);

    return cubeNode;
}
