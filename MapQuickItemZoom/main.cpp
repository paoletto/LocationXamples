#include "locationcomponents.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //engine.addImportPath("/media/paolo/qdata/home/paolo/Qt/Location/playground/LocationXamples");
    registerLocationComponents(engine);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
