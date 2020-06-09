import QtQuick 2.0

Rectangle{

    id:brick
    width: 80; height: 80

    color: "#fcec5b"

//    property string l: "green"
//    color: l

    function colorit(){
        if (light == 2) color = "green"
        if (light == 1) color = "gray"
    }
    property int previousX
    property int previousY
    property int light: 0



    border.width: 1
    border.color: "black"

    property int number: 0


    Image {
        id: img1

        width: 37
        height: 37

        anchors.centerIn: parent
        source: "qrc:/Image/icons8---60.png"
        visible: number == 2

        }

    Image {
        id: img2

        width: 40
        height: 40

        anchors.centerIn: parent
        source: "qrc:/Image/icons8--60.png"
        visible:number == 1

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
        visible: number >= 1

    }

    MouseArea{
        hoverEnabled: true
        anchors.fill: brick

//        onEntered: {

//            //Запоминаем позиции
//            previousX = brick.x
//            previousY = brick.y

//            console.log(previousX)
//            console.log(previousY)
//            brick.color = "#baa804"

//        }
        onClicked: {
            if (light == 1) {
                colorNull()
            }
            else if (light == 2){
                light = 3
            }
            else if (number > 1){
                colorNull()
                light = 1
            }
            else {
                colorNull()
            }

            colorit()
            neighbor()

        }

//        onExited: brick.color = "#fcec5b"

//       onPressed: brick.color = "Yellow"
//       onReleased: brick.color = "#fcec5b"

    }
}
