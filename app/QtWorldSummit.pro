TEMPLATE = app

QT += qml quick widgets

android {
    QT += androidextras
}

SOURCES += src/main.cpp

RESOURCES += resources.qrc

include(deployment.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

