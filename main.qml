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

        }
        Toolbar{
            id:toolbar

            onFindGame: gameplay.findGame()
            onQuitApp: Qt.quit()
        }
    }

    Dialog {
        id:dialogLose


        width:200
        modal: true
        height:150
        visible:false
        closePolicy: "CloseOnEscape" | "CloseOnPressOutside"

        anchors.centerIn:w.contentItem

        standardButtons: Dialog.Ok

        Text {
            anchors.centerIn:dialogLose.contentItem
            text: qsTr("YOU LOSE!!!")
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
            text: qsTr("YOU WON !!! Uhuuuu")
            font.pointSize: 15
            color: "red"
        }

        onAccepted: {
            console.log("clicked")
            dialogWin.close()
        }
    }

    Dialog {
        id:draw


        width:200
        modal: true
        height:150
        visible:false
        closePolicy: "CloseOnEscape" | "CloseOnPressOutside"

        anchors.centerIn:w.contentItem

        standardButtons: Dialog.Ok

        Text {
            anchors.centerIn:draw.contentItem
            text: qsTr("Nobody won, it was a draw")
            font.pointSize: 15
            color: "red"
        }

        onAccepted: {
            console.log("clicked")
            draw.close()
        }
    }

}
