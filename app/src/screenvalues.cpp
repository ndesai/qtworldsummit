#include "screenvalues.h"

#include <QScreen>
#include <QGuiApplication>
#include <QDebug>

#ifdef Q_OS_ANDROID

static void receivedSponsorNotification(JNIEnv *env, jobject thiz, jstring title, jstring message, jstring url, jlong qtObject)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)
    reinterpret_cast<ScreenValues*>(qtObject)->emitSponsorNotification(ScreenValues::jstringToQString(title).simplified(), ScreenValues::jstringToQString(message).simplified(), ScreenValues::jstringToQString(url).simplified());
}

QString ScreenValues::jstringToQString(jstring string)
{
    QAndroidJniEnvironment env;
    jboolean jfalse = false;
    return QString(env->GetStringUTFChars(string, &jfalse));
}
#endif


void ScreenValues::emitSponsorNotification(const QString &title, const QString &message, const QString &url)
{
    qDebug() << "Calling emit sponsor notification " << title << " message " << message << " url " << url;
    emit sponsorNotification(title, message, url);
}


ScreenValues::ScreenValues(QObject *parent) :
    QObject(parent),
    m_dpi(0),
    m_isTablet(false),
    m_notificationsEnabled(false)
{
    m_notificationsEnabled = getNotificationsEnabled();

    m_dpi = retrieveDpi();

    m_isTablet = retrieveIsTablet();

    m_dp = (float) m_dpi / 160;

    registerNative();
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

void ScreenValues::setStatusBarColor(const int r, const int g, const int b)
{
#ifdef Q_OS_ANDROID
    QAndroidJniObject::callStaticMethod<void>("com/iktwo/qtworldsummit/QtWorldSummit",
                                              "setStatusBarColor",
                                              "(III)V", r, g, b);
#endif
}

bool ScreenValues::notificationsEnabled() const
{
    return m_notificationsEnabled;
}

void ScreenValues::setNotificationsEnabled(bool notificationsEnabled)
{
    if (m_notificationsEnabled == notificationsEnabled)
        return;

    m_notificationsEnabled = notificationsEnabled;

#ifdef Q_OS_ANDROID
    QAndroidJniObject::callStaticMethod<void>("com/iktwo/qtworldsummit/QtWorldSummit",
                                              "setNotificationsEnabled", "(Z)V",
                                              m_notificationsEnabled);
#endif

    emit notificationsEnabledChanged();
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

bool ScreenValues::getNotificationsEnabled()
{
#ifdef Q_OS_ANDROID
    return QAndroidJniObject::callStaticMethod<jboolean>("com/iktwo/qtworldsummit/QtWorldSummit",
                                                         "getNotificationsEnabled", "()Z");
#else
    return false;
#endif
}


void ScreenValues::registerNative()
{
    qDebug() << Q_FUNC_INFO;

#ifdef Q_OS_ANDROID
    QAndroidJniEnvironment env;

    QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative",
                                                                           "activity",
                                                                           "()Landroid/app/Activity;");

    QAndroidJniObject::callStaticMethod<void>("com/iktwo/qtworldsummit/QtWorldSummit",
                                              "setQtObject", "(J)V",
                                              "(J)V", reinterpret_cast<long>(this));

    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();

        qCritical() << "Exception in registerNative";

        return;
    }

    jclass clazz = env->GetObjectClass(activity.object<jobject>());

    if (!clazz) {
        qDebug() << "Can't find class";

        if (env->ExceptionOccurred()) {
            env->ExceptionDescribe();
            env->ExceptionClear();
            qCritical() << "Exception in registerNative";
        }
    } else {
        JNINativeMethod methods[] {{"jreceivedSponsorNotification", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V", reinterpret_cast<void *>(receivedSponsorNotification)}};

        if (env->ExceptionCheck())
            env->ExceptionClear();

        if (env->ExceptionCheck())
            env->ExceptionClear();

        env->RegisterNatives(clazz,
                             methods,
                             sizeof(methods) / sizeof(methods[0]));

        env->DeleteLocalRef(clazz);
    }
#endif
}

void ScreenValues::checkIfPendingNotification()
{
#ifdef Q_OS_ANDROID
    QAndroidJniEnvironment env;

    QAndroidJniObject::callStaticMethod<void>("com/iktwo/qtworldsummit/QtWorldSummit",
                                              "checkIfPendingNotification", "()V",
                                              "()V");

    if (env->ExceptionOccurred()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
        qCritical() << "Exception in checkIfPendingNotification";
    }
#endif
}
