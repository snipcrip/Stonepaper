import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    id:w

    visible: true
    minimumWidth: 480
    maximumWidth: 480

    minimumHeight: cl.height
    maximumHeight: cl.height

    title: qsTr("Stonepaper")

    ColumnLayout{
        id: cl

        anchors.centerIn: w.contentItem
        spacing: 0.5

        Gameplay{
            id:gameplay
            onEnable: toolbar.enable()
        }
        Toolbar{
            id:toolbar
            onSockDisk: gameplay.sockDisk()
            onFindGame: gameplay.findGame()
            onQuitApp: Qt.quit()
        }
    }


    Dialog {
        id: start

        width: 380
        height: 450
        modal: true
        anchors.centerIn: parent

        closePolicy: "CloseOnEscape" | "CloseOnPressOutside"

        standardButtons: Dialog.Ok

        contentItem: Rectangle{
        id:rect
        width: start.width
        height: start.height
        color: "#f7f7f7"

         Text{
            id: textStart

            horizontalAlignment: Text.AlignHCenter

            height: parent.height/1.5
            width: parent.width
            wrapMode: Text.WordWrap

            text: qsTr("Здравствуй, дружок! Пока мы подбираем тебе соперника, мы предлагаем тебе ознакомиться с правилами игры ")
            font.pointSize: 13

            color: "#464531"
            anchors.centerIn: rect
             }
        Button {
            x: start.width/3.5
            y: start.height/2

            id:pamyatka

            contentItem: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.pointSize: 15
                text: "Read the rules"
                color: pamyatka.pressed ? "#646b63" : "#ffe15c"
            }
            background: Rectangle {

                color: pamyatka.pressed ? "#343834" : "#646b63"
                border.color: pamyatka.pressed ? "#646b63" : "black"
                border.width: 1
                radius: 5
            }

            onClicked: {
                reminder.visible = true
                reminder.open()
                }
             }
         }
    }

    Dialog {
        id:reminder

        width: 380
        height: 450
        modal: true
        anchors.centerIn: parent

        closePolicy: "CloseOnEscape" | "CloseOnPressOutside"

        standardButtons: Dialog.Ok

        contentItem: Rectangle{
            id:rect1
            width: reminder.width
            height: reminder.height
            color: "#f7f7f7"

            Text {
                id: textLabel

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                height: parent.height
                width: parent.width
                wrapMode: Text.WordWrap

                text: qsTr("Правила игры: <br/> в игре участвуют 2 игрока. На доске выстраиваются фигурки: с одной стороны Ваши, с противоположной - противника. Ходят игроки по очереди. За один ход можно переместить своего персонажа на одну из свободных в любом из горизонтальных и вертикальных направлений. <br/> <br/>При этом: <br/> Персонажи не могут передвигаться по диагонали.<br/> Игроки не могут пропускать свои ходы. <br/>  Побеждает тот, кому удача улыбнулась больше раз, чего мы Вам и желаем!!!")
                font.pointSize: 12

                color: "#464531"
            }
        }
    }

    Dialog {
        id:dialogLose


        width:200
        modal:true
        height:150
        visible:false
        closePolicy: "CloseOnEscape" | "CloseOnPressOutside"

        anchors.centerIn:w.contentItem

        standardButtons: Dialog.Ok

        Text {
            anchors.centerIn:dialogLose.contentItem
            text: qsTr("You lose...")
            font.pointSize: 15
            color: "red"
        }

        onAccepted: {
            console.log("clicked")
            dialogLose.close()
        }
    }

    Dialog {
        id:dialogWin


        width:200
        modal: true
        height:150
        visible:false
        closePolicy: "CloseOnEscape" | "CloseOnPressOutside"

        anchors.centerIn:w.contentItem

        standardButtons: Dialog.Ok

        Text {
            anchors.centerIn:dialogWin.contentItem
            text: qsTr("You won!!!")
            font.pointSize: 15
            color: "green"
        }

        onAccepted: {
            console.log("clicked")
            dialogWin.close()
        }
    }

    Dialog {
        id:dialogDraw


        width:200
        modal: true
        height:150
        visible:false
        closePolicy: "CloseOnEscape" | "CloseOnPressOutside"

        anchors.centerIn:w.contentItem

        standardButtons: Dialog.Ok

        Text {
            anchors.centerIn:dialogDraw.contentItem
            text: qsTr("Draw!!")
            font.pointSize: 15
            color: "red"
        }

        onAccepted: {
            console.log("clicked")
            draw.close()
        }
    }
}
