#ifndef API_H
#define API_H

#include <QObject>
#include <QtNetwork>
#include <QJsonObject>

class Api : public QObject
{
    Q_OBJECT
public:
    explicit Api(QObject *parent = 0);
    ~Api();

    Q_INVOKABLE void post(QString url, QVariantMap parameters);
    Q_INVOKABLE void get(QString url);
    Q_INVOKABLE void get(QString url, QVariantMap parameters);

private:
    QFuture<QJsonObject> m_future;
    static QJsonObject parseJson(QByteArray response);

signals:
    void reply(QString url, QJsonObject data);

public slots:

private slots:
    void replyFinished(QNetworkReply *reply);

private:
    QNetworkAccessManager *m_networkManager;
};

#endif // API_H
