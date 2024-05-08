#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <goboard.h>

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    GoBoard board;

    // Контекст QML для возможности обращения к объекту доски
    engine.rootContext()->setContextProperty("goBoard", &board);

    // Подгружаем ссылку на основной файл QML
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::AutoConnection);

    engine.load(url);
    return app.exec();
}
