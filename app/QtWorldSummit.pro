TEMPLATE = app

QT += qml quick widgets svg xml

android {
    QT += androidextras
}

SOURCES += src/main.cpp \
    src/screenvalues.cpp

HEADERS += \
    src/screenvalues.h

RESOURCES += resources.qrc

include(deployment.pri)

QML_IMPORT_PATH = $$PWD/qml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

DISTFILES += \
    android/AndroidManifest.xml \
    android/res/values-v21/styles.xml \
    android/res/values/libs.xml \
    android/src/org/qtproject/qt5/android/bindings/QtActivity.java \
    android/src/com/iktwo/qtworldsummit/*.java \
    qml/*.qml \
    qml/controls/*.qml \
    qml/ui/*.qml \
    qml/utils/*.qml \
    qml/utils/+android/*.qml \
    qml/utils/+ios/*.qml \
    qml/utils/+windows/*.qml
