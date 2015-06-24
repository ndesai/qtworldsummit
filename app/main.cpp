#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QScreen>

#ifdef Q_OS_ANDROID
#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#endif

#define QML_DEVELOPMENT "qrc:/qml/dev.qml"
#define SIM false

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QString mainQml = QStringLiteral(QML_DEVELOPMENT);

    float dpi = QGuiApplication::primaryScreen()->physicalDotsPerInch();

#ifdef Q_OS_IOS
    mainQml = "qrc:/qml/main_ios.qml";
#elif defined(Q_OS_ANDROID)

    // Retrieve the screen density
    QAndroidJniObject qtActivity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    QAndroidJniObject resources = qtActivity.callObjectMethod("getResources", "()Landroid/content/res/Resources;");
    QAndroidJniObject displayMetrics = resources.callObjectMethod("getDisplayMetrics", "()Landroid/util/DisplayMetrics;");
    dpi = displayMetrics.getField<float>("density");

    mainQml = "qrc:/qml/main_android.qml";
#elif SIM
    QCursor cursor(QPixmap(":/qml/img/sim/cursor-default.png"));
    app.setOverrideCursor(cursor);
    mainQml = "qrc:/qml/simfinger.qml";
#endif

    engine.rootContext()->setContextProperty("$", QVariant::fromValue(dpi));
    engine.load(QUrl(mainQml));

    return app.exec();
}
