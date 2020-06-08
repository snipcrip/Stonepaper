#include "helper.h"

Helper::Helper(QObject *parent) : QObject(parent)
{

    socket = new QTcpSocket(this);
    connect(socket, SIGNAL(readyRead()), this, SLOT(sockReady()));
    connect(socket, SIGNAL(disconnected()), this, SLOT(sockDisk()));
    connect(socket, SIGNAL(updateGame()), this, SLOT(update()));
}


QVector <int> Helper::findGame()
{

    socket->connectToHost("127.0.0.1", 5555);
    if (socket->waitForConnected(1000))
        qDebug("Connected!");
    socket->write("{\"type\":\"find game\"}");

    QVector <int> bricks;

    qDebug() << "find!";
//    socket->write("bricks");
    return bricks;
}


void Helper::sockDisc() {
    socket->deleteLater();
}

void Helper::update() {
    qDebug() << " update )))))";

}

void Helper::sockReady() {
    if (socket->waitForConnected(500)) {
        socket->waitForConnected(500);
        Data = socket->readAll();
//        qDebug() << Data;

        doc = QJsonDocument::fromJson(Data, &docError);

        if (docError.errorString().toInt() == QJsonParseError::NoError) {
//            qDebug() << doc.object().value("type").toString();
            if (doc.object().value("type").toString() == "connect") {
                qDebug() << "connect";
            }
            else if (doc.object().value("type").toString() == "find game") {
                QJsonArray docAr = doc.object().value("field").toArray();

                qDebug() << "find";
            }
            else if (doc.object().value("type").toString() == "start game") {
                QJsonArray docAr = doc.object().value("field").toArray();
                QVector < QVector <int> > brickss;

                for (int i = 0; i < 6; i++) {
                    QVector <int> _;
                    brickss.append(_);
                    for (int j = 0; j < 6; j++) {
                        brickss[i].append(docAr[i].toArray()[j].toInt());
                    }
                }

                qDebug() << brickss;

                emit sendToQml(brickss);
                qDebug() << "find";
            }
            else if (doc.object().value("type").toString() == "game") {
                qDebug() << "game";
                QJsonArray docAr = doc.object().value("fields").toArray();
                qDebug() << docAr;

            }

        }
        else {
            qDebug() << "ошибка" << docError.errorString();
        }


    }
}
