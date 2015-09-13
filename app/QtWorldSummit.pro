TEMPLATE = app

QT += qml quick widgets svg

android {
    QT += androidextras
}

SOURCES += src/main.cpp \
    src/screenvalues.cpp

HEADERS += \
    src/screenvalues.h

RESOURCES += resources.qrc


ios {
#CONFIG += qtquickcompiler
    QMAKE_INFO_PLIST = $$PWD/ios/Info.plist
}

include(deployment.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
