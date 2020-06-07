import QtQuick 2.0
import QtQuick.Layouts 1.12

GridLayout {
    id:gl

//    signal updateGame()

    width: 360
    height: 360

    columns: 6
    rows: 6

    columnSpacing: 0
    rowSpacing: 0


    function findGame() {
        helper.findGame()
    }

    function updateGame() {
        console.log("upppppdate!");
    }

    Repeater{

        id:bricks
        model:36

        Brick {

        }

    }

}
