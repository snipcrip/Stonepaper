import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

RowLayout {
    id: rl
    signal findGame()
    signal quitApp()
    signal sockDisk()

    spacing: 0

    property int who: 1

    Connections {
        target: helper // Указываем целевой объект для соединения
        /* Объявляем и реализуем функцию, как параметр
         * объекта и с имененем похожим на название сигнала
         * Разница в том, что добавляем в начале on и далее пишем
         * с заглавной буквы
         * */
        onWhoPlayer: {
            who = player;
        }
    }

    function enable() {
        newGameButton.enabled = true
    }

    Button {
        id: newGameButton
        Layout.fillHeight: true
        Layout.fillWidth: true

       contentItem:Text {

           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignVCenter
           font.pointSize: 15
           text: "Find Game"
           color: newGameButton.pressed ? "#646b63" : "#ffe15c"
       }

       background: Rectangle {
           color: newGameButton.pressed ? "#343834" : "#646b63"
           border.color: newGameButton.pressed ? "#646b63" : "black"
           border.width: 1.25
           radius: 0

       }

       onClicked: {
           newGameButton.enabled = false
           findGame()
           start.visible = true
           start.open()
       }
    }

    Button {
        id:exitButton
        Layout.fillHeight: true
        Layout.fillWidth: true

        contentItem: Text {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 15
            text: "Leave the game "
            color: exitButton.pressed ? "#646b63" : "#ffe15c"
        }
        background: Rectangle {

            color: exitButton.pressed ? "#343834" : "#646b63"
            border.color: exitButton.pressed ? "#646b63" : "black"
            border.width: 1.25
            radius: 0

        }

        onClicked:{
            sockDisk()
//            helper.sockDisc()
            newGameButton.enabled = true

       }
    }

    TextField {
        id:whoField

        horizontalAlignment: TextField.AlignHCenter
        verticalAlignment: TextField.AlignVCenter
        Layout.fillWidth: true
        enabled:false
        font.pointSize: 20
        text: who ? "Your turn" : "Opponent's move"
        color: "black"

        background: Rectangle {

            border.color: "black"
            border.width: 1.25
            radius: 0
        }
    }

    Button {
        id: quitButton

        Layout.fillHeight: true
        Layout.fillWidth: true

        contentItem: Text {

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 15
            text: "Quit"
            color: quitButton.pressed ? "#646b63" : "#ffe15c"
        }

        background: Rectangle {

            color: quitButton.pressed ? "#343834" : "#646b63"
            border.color: quitButton.pressed ? "#646b63" : "black"
            border.width: 1.25
            radius: 0
        }

        onClicked: {
            helper.sockDisc()
            quitApp()
        }
    }

    Shortcut{
        context: Qt.ApplicationShortcut
        sequences: ["Ctrl+N"]
        onActivated: findGame()
    }

    Shortcut{
        context: Qt.ApplicationShortcut
        sequences: [StandardKey.Close ,"Ctrl+Q"]
        onActivated: quitApp()
    }

}
