import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

RowLayout {
    id: rl
    signal findGame()
    signal quitApp()

    Button {
        id: newGameButton
        Layout.fillHeight: true
        Layout.fillWidth: true

       contentItem: Text {

           font.pointSize: 15
           text: "New Game"
           color: newGameButton.pressed ? "#646b63" : "#ffe15c"
       }

       background: Rectangle {
           color: newGameButton.pressed ? "#ffe15c" : "#646b63"
           border.color: newGameButton.pressed ? "#646b63" : "black"
           border.width: 2
           radius: 0

       }

        onClicked: {
            findGame()
        }
    }

    Button {
        id: quitButton

        Layout.fillHeight: true
        Layout.fillWidth: true

        contentItem: Text {

            font.pointSize: 15
            text: "Quit"
            color: quitButton.pressed ? "#646b63" : "#ffe15c"
        }

        background: Rectangle {

            color: quitButton.pressed ? "#ffe15c" : "#646b63"
            border.color: quitButton.pressed ? "#646b63" : "black"
            border.width: 2
            radius: 0
        }

        onClicked: quitApp()
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
