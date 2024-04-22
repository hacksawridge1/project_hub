import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

ApplicationWindow {
    id: main_window
    visible: true
    width: 500
    height: 500
    title: "HUB"
    
    Rectangle {
        id: red
        color: "red"
        z: 2
        width: 300
        height: 300
        x: 0
        y: 0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.z = 100
                console.log("blue z now: " + blue.z)
                console.log("red z now: " + red.z)
            }
        }
    }

    Rectangle {
        id: blue
        color: "blue"
        z: 2
        width: 300
        height: 300
        x: 100
        y: 0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.z = 100
                console.log("blue z now: " + blue.z)
                console.log("red z now: " + red.z)
            }
        }
    }
}