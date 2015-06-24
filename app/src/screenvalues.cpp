#include "screenvalues.h"

#include <QScreen>
#include <QGuiApplication>

#ifdef Q_OS_ANDROID
#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#endif

ScreenValues::ScreenValues(QObject *parent) :
    QObject(parent),
    m_dpi(0),
    m_isTablet(false)
{
    m_dpi = retrieveDpi();

    m_isTablet = retrieveIsTablet();

    m_dp = (float) m_dpi / 160;
}

int ScreenValues::dpi() const
{
    return m_dpi;
}

void ScreenValues::setDpi(int dpi)
{
    if (m_dpi == dpi)
        return;

    m_dpi = dpi;
    emit dpiChanged();

    setDp((float) m_dpi / 160);
}

float ScreenValues::dp() const
{
    return m_dp;
}

void ScreenValues::setDp(float dp)
{
    if (m_dp == dp)
        return;

    m_dp = dp;
    emit dpChanged();
}

bool ScreenValues::isTablet() const
{
    return m_isTablet;
}

void ScreenValues::setIsTablet(bool isTablet)
{
    if (m_isTablet == isTablet)
        return;

    m_isTablet = isTablet;
    emit isTabletChanged();
}

int ScreenValues::retrieveDpi()
{
#ifdef Q_OS_ANDROID
    QAndroidJniEnvironment env;
    env->PushLocalFrame(9);

    QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative",
                                                                           "activity",
                                                                           "()Landroid/app/Activity;");

    QAndroidJniObject resources = activity.callObjectMethod("getResources",
                                                            "()Landroid/content/res/Resources;");

    QAndroidJniObject displayMetrics = resources.callObjectMethod("getDisplayMetrics",
                                                                  "()Landroid/util/DisplayMetrics;");

    jint densityDpi = displayMetrics.getField<jint>("densityDpi");

    int result = (int)densityDpi;

    return result;
#else
    return QGuiApplication::primaryScreen()->physicalDotsPerInch();
#endif
}

bool ScreenValues::retrieveIsTablet()
{
#ifdef Q_OS_ANDROID
    QAndroidJniEnvironment env;
    env->PushLocalFrame(9);

    QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative",
                                                                           "activity",
                                                                           "()Landroid/app/Activity;");

    QAndroidJniObject resources = activity.callObjectMethod("getResources",
                                                            "()Landroid/content/res/Resources;");

    QAndroidJniObject configuration = resources.callObjectMethod("getConfiguration",
                                                                 "()Landroid/content/res/Configuration;");

    jint smallestScreenWidthDp = configuration.getField<jint>("smallestScreenWidthDp");

    return smallestScreenWidthDp >= 600;
#else
    return false;
#endif
}
