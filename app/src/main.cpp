#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QQmlFileSelector>

#include "screenvalues.h"

static QObject *screen_values_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return new ScreenValues();
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQmlFileSelector* selector = new QQmlFileSelector(&engine);

    QStringList extraSelectors;

    bool devel = false;

    if (devel)
        extraSelectors << "devel";

#ifdef Q_OS_ANDROID
    ScreenValues *sv = new ScreenValues();

    if (sv->isTablet())
        extraSelectors << "android_tablet";

    delete sv;
#endif

    if (!extraSelectors.isEmpty())
        selector->setExtraSelectors(extraSelectors);

    engine.addImportPath("qrc:/");

    qmlRegisterSingletonType<ScreenValues>("QtWorldSummit", 1, 5, "ScreenValues", screen_values_provider);

    engine.load(QUrl("qrc:/qml/qml/main.qml"));

    return app.exec();
}
