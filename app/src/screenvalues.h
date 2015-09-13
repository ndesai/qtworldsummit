#ifndef SCREENVALUES_H
#define SCREENVALUES_H

#include <QObject>

class ScreenValues : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int dpi READ dpi WRITE setDpi NOTIFY dpiChanged)
    Q_PROPERTY(float dp READ dp WRITE setDp NOTIFY dpChanged)
    Q_PROPERTY(bool isTablet READ isTablet NOTIFY isTabletChanged)
    Q_PROPERTY(bool notificationsEnabled READ notificationsEnabled WRITE setNotificationsEnabled NOTIFY notificationsEnabledChanged)

public:
    explicit ScreenValues(QObject *parent = 0);

    float dp() const;
    void setDp(float dp);

    int dpi() const;
    void setDpi(int dpi);

    bool isTablet() const;
    void setIsTablet(bool isTablet);

    Q_INVOKABLE void setStatusBarColor(const int r, const int g, const int b);

    bool notificationsEnabled() const;

public slots:
    void setNotificationsEnabled(bool notificationsEnabled);

signals:
    void dpChanged();
    void dpiChanged();
    void isTabletChanged();
    void notificationsEnabledChanged();

private:
    float m_dp;
    int m_dpi;
    bool m_isTablet;
    bool m_notificationsEnabled;

    int retrieveDpi();
    bool retrieveIsTablet();
    bool getNotificationsEnabled();
};

#endif // SCREENVALUES_H
