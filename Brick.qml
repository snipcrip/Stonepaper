<<<<<<< HEAD
import QtQuick 2.0

Rectangle{

    id:brick
    width: 80; height: 80

    color: "#fcec5b"

    property int previousX
    property int previousY


    border.width: 1
    border.color: "black"

    property int number: 1
    property int name: 5

    Image {
        id: img1

        width: 37
        height: 37

        anchors.centerIn: parent
        source: "qrc:/Image/icons8---60.png"
        visible: number == 1 

        }

    Image {
        id: img2

        width: 40
        height: 40

        anchors.centerIn: parent
        source: "qrc:/Image/icons8--60.png"
        visible:number == 2

        }

    Image {
        id: img3

        width: 40
        height: 40

        anchors.centerIn: parent
        source: "qrc:/Image/icons8---60 (2).png"
        visible: number == 3
    }

    Image {
        id: img4

        width: 40
        height: 40
        anchors.centerIn: parent
        source: "qrc:/Image/icons8---60 (1).png"
        visible: number == 4
    }

    Image {
        id: img5

        width: 55
        height: 55

        anchors.centerIn: parent
        source: "qrc:/Image/icons8--60.png"
        visible: name == 5

        }

    MouseArea{
        hoverEnabled: true
        anchors.fill: brick

        onEntered: {
            //Запоминаем позиции
            previousX = brick.x
            previousY = brick.y

            console.log(previousX)
            console.log(previousY)
            brick.color = "#baa804"
        }
       onExited: brick.color = "#fcec5b"

       onPressed: brick.color = "Yellow"
       onReleased: brick.color = "#fcec5b"

    }
}

=======
import QtQuick 2.0

Rectangle{

    width: 60; height: 60

    color: "darkgrey"
    border.width: 1
    border.color: "black"

    property int number: 0
    property bool light: false

    function backlight() {
        light = true
    }

    Image {
        id: img1

        source: "qrc:/Image/icons8---60.png"
        visible: number == 1 

    }

    Image {
        id: img2

        source: "qrc:/Image/icons8---60.png"
        visible: number == 2
    }
    Image {
        id: img3

        source: "qrc:/Image/icons8---60 (2).png"
        visible: number == 3
    }
    Image {
        id: img4

        source: "qrc:/Image/icons8---60 (1).png"
        visible: number == 4
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            backlight()
            light()
        }
    }
}

>>>>>>> eba918136a7e19c63ed040644759634513ada47c
