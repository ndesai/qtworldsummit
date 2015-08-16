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

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

DISTFILES += \
    android/AndroidManifest.xml \
    android/res/values-v21/styles.xml \
    android/res/values/libs.xml \
    android/src/org/qtproject/qt5/android/bindings/QtActivity.java \
    android/src/com/iktwo/qtworldsummit/QtWorldSummit.java
