import QtQuick 2.0
import QtQuick.Layouts 1.12

GridLayout {
    id:gl

    width: 360
    height: 360

    columns: 10
    rows: 10

    columnSpacing: 0
    rowSpacing: 0

    function newGame(){

    }

    Repeater{

        id:bricks
        model:60

        Brick {

        }

    }

}
