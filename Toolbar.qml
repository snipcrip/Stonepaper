import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

RowLayout {
    id: rl
    signal findGame()
    signal quitApp()

    Button {
        id: newGameButton

        text: "New Game"
        onClicked: {
            findGame()
        }
    }

    Button {
        id: quitButton

        text: "Quit"
        onClicked: quitApp()
    }
}
