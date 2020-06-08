import QtQuick 2.0
import QtQuick.Layouts 1.12

GridLayout {
    id:gl

//    signal updateGame()
//    void sendToQml(QVector <int> bricks);
    width: 480
    height: 480
    columnSpacing: 0
    rowSpacing: 0

    property int light
    columns: 6
    rows: 6

    Connections {
        target: helper // Указываем целевой объект для соединения
        /* Объявляем и реализуем функцию, как параметр
         * объекта и с имененем похожим на название сигнала
         * Разница в том, что добавляем в начале on и далее пишем
         * с заглавной буквы
         * */
        onSendToQml: {
            console.log("brickssss");
            console.log(brickss);
            gl.updateGame(brickss)
        }
    }

    function findGame() {

        helper.findGame()
        console.log("fiiind!");
    }

//    function light() {
//        var brickConfigs = []

//        for (var i = 0; i < bricks.count; i++) {
//            brickConfigs.push(bricks.itemAt(i).config)
//        }

//        var brickLights = helper.light(brickConfigs)
//        for (var i = 0; i < brickLights.length - 1; i++) {
//            bricks.itemAt(i).light = brickLights[i];
//        }
//    }

    function updateGame(brickss) {
        for (var i = 0; i < bricks.count; i++) {
//            console.log(bricks.count)
//            console.log(bricks.itemAt(i).count)
            for (var j = 0; j < bricks.itemAt(i).count; j++) {
                bricks.itemAt(i).itemAt(j).number = brickss[5 - i][j]
            }
        }
//        console.log(bricks.itemAt(4).itemAt(4).number = 2)
        console.log("upppppdate!")
    }

    function neighbor (){
        var x, y
        var flag, xx, yy
        for (var i = 0; i < bricks.count; i++) {
            for (var j = 0; j < bricks.itemAt(i).count; j++) {
                if (bricks.itemAt(i).itemAt(j).light == 3){
                    flag = 1; xx = i; yy =j
                }

                else if (bricks.itemAt(i).itemAt(j).light == 1){
                    x = i; y = j
                }

            }
        }

        if (flag == 1){
            helper.update()
        }

        if ((x - 1 >= 0) && (x - 1 < bricks.count) && ( y >= 0) && ( y < bricks.count)){

            var k = bricks.itemAt(x-1).itemAt(y)
            if (!((k >= 2) && (k <= 4)))
            bricks.itemAt(x-1).itemAt(y).light = 2
        }


        if ((x + 1 >= 0) && (x + 1 < bricks.count) && ( y >= 0) && ( y < bricks.count)){
           var k = bricks.itemAt(x+1).itemAt(y)
           if ( !((k >= 2) && (k <= 4)))
           bricks.itemAt(x+1).itemAt(y).light = 2
        }
        if (!((k >= 2) && (k <= 4)) && (x  >= 0) && (x  < bricks.count) && ( y - 1 >= 0) && ( y - 1 < bricks.count)){

            var k = bricks.itemAt(x).itemAt(y-1)
            if ( !((k >= 2) && (k <= 4)))
            bricks.itemAt(x).itemAt(y-1).light = 2

        }
        if (!((k >= 2) && (k <= 4)) && (x  >= 0) && (x  < bricks.count) && ( y + 1 >= 0) && ( y + 1 < bricks.count)){

            var k = bricks.itemAt(x).itemAt(y+1)
            if ( !((k >= 2) && (k <= 4)))
            bricks.itemAt(x).itemAt(y+1).light = 2
        }
    }

    Repeater {
        id:bricks

        model:6
        Repeater {
            model:6
            Brick {

            }
        }
    }
}
