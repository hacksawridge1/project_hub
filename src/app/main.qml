import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
  id: win
  visible: true
  width: 600
  height: 500
  title: "HelloApp"

  // Text {
  //     anchors.centerIn: parent
  //     text: "Hi, Bitch"
  //     color: 
  //     font.pixelSize: 24
  // }

  Button {
    id: button1
    text: "Jmi"
    anchors.centerIn: parent
    onClicked: {
      win.color = Qt.rgba(Math.random(), Math.random(), Math.random())
    }
  }

  Item {
    id: user_card
    width: 230
    height: 48


    Rectangle {
      id: user_card__bg
      anchors.fill: parent
      color: "#ffffff"
    }

    Rectangle {
      id: user_card__img
      width: 32
      height: 32
      color: "blue"
      anchors.left: parent
      anchors.margins: 12
    }

    Rectangle {
      anchors.left: user_card__img.right
      anchors.leftMargin: 12
      Text {
        id: user_card__title
        text: "TED"
        color: "#000000"
        anchors.top: parent
      }
      Text {
        id: user_card__subtitle
        text: "IP: 192.168.3.121"
        color: "#808080"
        anchors.bottom: parent
      }
    }

    MouseArea {
      id: mouseArea
    }
  }
}
