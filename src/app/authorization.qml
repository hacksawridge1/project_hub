import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: authorization
    visible: true
    width: 600
    height: 500
    title: "Авторизация"
    TextField {
        id: inputname
        width: 400
        height: 60
        placeholderText: "Введите имя пользователя"
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignLeft
        font.pointSize: 20
        opacity: 0
        OpacityAnimator {
            target: inputname
            from: 0
            to: 1
            duration: 2000
            running: true
        }
        YAnimator {
            target: inputname
            easing.type: Easing.InOutQuad
            from: authorization.height + 50
            to: authorization.height / 2 - inputname.height / 2
            duration: 2000
            running: true
        }
    }
    Text {
        id: label
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Добро пожаловать в HUB!"
        font.pixelSize: 32
        opacity: 0
        OpacityAnimator {
            target: label
            from: 0
            to: 1
            duration: 1500
            running: true
        }
        YAnimator {
            target: label
            easing.type: Easing.InOutQuad
            from: -50
            to: 100
            duration: 1500
            running: true
        }
    }
    Button {
        id: login
        anchors.horizontalCenter: parent.horizontalCenter
        y: authorization.height + 50
        width: 200
        height: 75
        text: "Войти"
        SequentialAnimation {
            running: true
            PauseAnimation {
                duration: 500
            }
            YAnimator {
                target: login
                easing.type: Easing.InOutQuad
                from: authorization.height + 50
                to: authorization.height / 2 - login.height / 2 + 100
                duration: 1500
                running: true
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                authorization.close()
            }
        }
    }
}