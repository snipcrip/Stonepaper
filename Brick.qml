import QtQuick 2.0

Rectangle{
    width: 60; height: 60

    color: "red"
    border.width: 1
    border.color: "black"


    Image {
        id: img1

        source: "qrc:/Image/icons8---60.png"
        visible: true
    }
}
