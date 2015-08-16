#ifndef SCREENVALUES_H
#define SCREENVALUES_H

#include <QObject>

class ScreenValues : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int dpi READ dpi WRITE setDpi NOTIFY dpiChanged)
    Q_PROPERTY(float dp READ dp WRITE setDp NOTIFY dpChanged)
    Q_PROPERTY(bool isTablet READ isTablet NOTIFY isTabletChanged)

public:
    explicit ScreenValues(QObject *parent = 0);

    float dp() const;
    void setDp(float dp);

    int dpi() const;
    void setDpi(int dpi);

    bool isTablet() const;
    void setIsTablet(bool isTablet);

    Q_INVOKABLE void setStatusBarColor(const int r, const int g, const int b);

signals:
    void dpChanged();
    void dpiChanged();
    void isTabletChanged();

private:
    float m_dp;
    int m_dpi;
    bool m_isTablet;

    int retrieveDpi();
    bool retrieveIsTablet();
};

#endif // SCREENVALUES_H
