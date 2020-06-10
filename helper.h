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
#include <QPair>


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
        void disconnected();
        void sendToQml(QVector <QVector<int> > brickss);
        void whoPlayer(int player);
        void empty();
        void statusGame(int status);

    public slots:
        QVector<int> findGame();
        void updateGame(int fromX, int fromY, int toX, int toY);
//        QVector<bool> light(QVector<int> bricks);
        void sockReady();
        void sockDisc();
//        void update();
//        void replyFinished(QNetworkReply *pReply);

    private:
//        QNetworkAccessManager *manager;
};


#endif // HELPER_H
