#include "helper.h"

Helper::Helper(QObject *parent) : QObject(parent)
{

    socket = new QTcpSocket(this);
    connect(socket, SIGNAL(readyRead()), this, SLOT(sockReady()));
    connect(socket, SIGNAL(disconnected()), this, SLOT(sockDisk()));
//    connect(socket, SIGNAL(updateGame()), this, SLOT(update()));
}


QVector <int> Helper::findGame()
{

    socket->connectToHost("109.234.39.222", 6022);
    if (socket->waitForConnected(1000))
        qDebug("Connected!");

    QJsonObject textObject;
    textObject["type"] = "find game";

    socket->write(QJsonDocument(textObject).toJson(QJsonDocument::Indented));

    QVector <int> bricks;

    qDebug() << "find!";
    return bricks;
}


void Helper::sockDisc() {
    qDebug() << "diskk";
    QJsonObject textObject;
    textObject["type"] = "disconnect";
    socket->write(QJsonDocument(textObject).toJson(QJsonDocument::Indented));
    socket->waitForBytesWritten(10000);
    emit empty();

//    socket->deleteLater();
//    socket->close();
}

void Helper::updateGame(int fromX, int fromY, int toX, int toY) {
    QJsonObject textObject;

    QJsonArray textsArray;
    textsArray.append(fromX);
    textsArray.append(fromY);
    textObject["move from"] = textsArray;

    textsArray[0] = toX;
    textsArray[1] = toY;
    textObject["move to"] = textsArray;

    textObject["type"] = "game";

    qDebug() << " update )))))";
    if (socket->isOpen())
        socket->write(QJsonDocument(textObject).toJson(QJsonDocument::Indented));
    else {
        qDebug() << "warning disc";
        emit empty();
    }

}

void Helper::sockReady() {
    if (socket->waitForConnected(500)) {
        socket->waitForConnected(500);
        Data = socket->readAll();
//        qDebug() << Data;

        doc = QJsonDocument::fromJson(Data, &docError);

        if (docError.errorString().toInt() == QJsonParseError::NoError) {
//            qDebug() << doc.object().value("type").toString();
//            if (doc.object().value("type").toString() == "connect") {
//                qDebug() << "connect";
//            }
//            else if (doc.object().value("type").toString() == "find game") {
//                QJsonArray docAr = doc.object().value("field").toArray();

////                qDebug() << "find";
//            }
            if (doc.object().value("type").toString() == "game") {
                QJsonArray docAr = doc.object().value("field").toArray();
                QVector < QVector <int> > brickss;

                for (int i = 0; i < 6; i++) {
                    QVector <int> _;
                    brickss.append(_);
                    for (int j = 0; j < 6; j++) {
                        brickss[i].append(docAr[i].toArray()[j].toInt());
                    }
                }


                emit whoPlayer(doc.object().value("move_player").toInt());
                emit sendToQml(brickss);

                int status = doc.object().value("status_game").toInt(); //status game 0 - идет игра 1 - ничья 2 - проигрыш 3 - выйгрыш
//                qDebug() << status;
                emit statusGame(status);



            }
            else if (doc.object().value("type").toString() == "disconnect") {

                emit empty();
                socket->close();
//                socket->deleteLater();
            }

        }
        else {
            qDebug() << "ошибка" << docError.errorString();
        }


    }
}
