#ifndef HELPER_H
#define HELPER_H

#include <QObject>
#include <QVector>
#include <QtNetwork>
#include <QUrl>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QTcpSocket>
#include <QJsonDocument>
#include <QJsonParseError>
#include <QJsonArray>


class Helper : public QObject
{
    Q_OBJECT
    public:
        explicit Helper(QObject *parent = nullptr);

        QTcpSocket* socket;
        QByteArray Data;

        QJsonDocument doc;
        QJsonParseError docError;


    signals:
        void finished(QNetworkReply *);
        void updateGame();
        void sendToQml(QVector <QVector<int> > brickss);

    public slots:
        QVector<int> findGame();
//        QVector<bool> light(QVector<int> bricks);
        void sockReady();
        void sockDisc();
        void update();
//        void replyFinished(QNetworkReply *pReply);

    private:
//        QNetworkAccessManager *manager;
};


#endif // HELPER_H
