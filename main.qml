import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    id:w

    visible: true
    minimumWidth: 360
    maximumWidth: 360

    minimumHeight: cl.height
    maximumHeight: cl.height

    title: qsTr("Stonepaper")

    ColumnLayout{
        id: cl

        anchors.centerIn: w.contentItem
        spacing: 2

        Gameplay{
            id:gameplay

        }
        Toolbar{
            id:toolbar

            onFindGame: gameplay.findGame()
            onQuitApp: Qt.quit()
        }
    }
}
