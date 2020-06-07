import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

RowLayout {

    id: rl
    signal newGame()
    signal quitApp()

    Button{
        id:quitButton
        text: "Quit"
        onClicked: quitApp()

        x:300
        y:300
    }

    Button{
        id:newButton
        text: "New Game"
        onClicked: newGame()
    }
}
