import QtQuick 2.0

Rectangle{
    width: 60; height: 60

    color: "red"
    border.width: 1
    border.color: "black"

    property int number: 0

    Image {
        id: img1

        source: "qrc:/Image/icons8---60.png"
        visible: number == 1 
        
        }
        
    Image {
        id: img2

        source: "qrc:/Image/icons8---60.png"
        visible: number == 2
    }
    Image {
        id: img3

        source: "qrc:/Image/icons8---60 (2).png"
        visible: number == 3
    }
    Image {
        id: img4

        source: "qrc:/Image/icons8---60 (1).png"
        visible: number == 4
    }
    
}
