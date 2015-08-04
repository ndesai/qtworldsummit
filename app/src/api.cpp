#include "api.h"
#include <QDebug>
#include <QtConcurrent>

#define DEBUG if(1) qDebug() << __PRETTY_FUNCTION__

QT_BEGIN_NAMESPACE

Api::Api(QObject *parent) : QObject(parent),
    m_networkManager(0)
{
    m_networkManager = new QNetworkAccessManager(this);
    connect(m_networkManager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(replyFinished(QNetworkReply*)));
}

Api::~Api()
{
    m_future.cancel();
    m_networkManager->deleteLater();
}

void Api::post(QString url, QVariantMap parameters)
{
    DEBUG << Q_FUNC_INFO;
    m_future.cancel();
    QUrlQuery postData;
    QStringList keys = parameters.keys();
    for(int i = 0; i < keys.count(); i++)
    {
        QString key = keys.at(i);
        QString value = QVariant(parameters.value(key)).toString();

        postData.addQueryItem(key, value);
    }

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/x-www-form-urlencoded");

    m_networkManager->post(request, postData.toString(QUrl::FullyEncoded).toUtf8());
}

void Api::get(QString url)
{
    DEBUG << Q_FUNC_INFO;
    m_future.cancel();
    this->get(url, QVariantMap());
}

void Api::get(QString url, QVariantMap parameters)
{
    DEBUG << Q_FUNC_INFO;
    m_future.cancel();
    QString urlCombined = url;
    QStringList keys =  parameters.keys();
    for(int i = 0; i < keys.length(); i++)
    {
        urlCombined += (i == 0 ? "?" : "&")
                + keys.value(i)
                + "="
                + parameters.value(keys.value(i)).toString();
    }

    DEBUG << urlCombined;
    QNetworkRequest request(urlCombined);

    m_networkManager->get(request);
}

void Api::replyFinished(QNetworkReply *reply)
{
    qDebug() << Q_FUNC_INFO;
    qDebug() << reply->errorString();

    m_future = QtConcurrent::run(parseJson, reply->readAll());

    QJsonObject jsonObject = m_future.result();

    emit Api::reply(reply->url().toString(), jsonObject);
}

QJsonObject Api::parseJson(QByteArray response)
{
    QJsonDocument jsonDocument = QJsonDocument::fromJson(response);
    QJsonObject jsonObject;
    jsonObject.insert("length", response.length());
    if (jsonDocument.isEmpty() || jsonDocument.isNull()) {
        jsonObject.insert("data", QJsonObject());
    } else {
        QJsonValue value;
        if (jsonDocument.isObject()) {
            value = QJsonValue(jsonDocument.object());
        } else {
            value = QJsonValue(jsonDocument.array());
        }
        jsonObject.insert("content", value);
    }
    return jsonObject;
}

QT_END_NAMESPACE
