import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window 
import QtQuick.Controls.Universal
import MainController
import Controller

// Окно авторизации
ApplicationWindow {
    id: auth
    width: 600
    height: 400
    minimumWidth: main_layout.implicitWidth + 20
    minimumHeight: main_layout.implicitHeight + 20
    title: "Authorization"
    color: get_theme("auth")
    visible: true
    function get_theme(name, theme = Control.theme) {
        var theme_name = {"auth": 0, "object": 1, "object(hovered)": 2, "object(pressed)": 3, "object_border": 4, 
        "text": 5, "placeholder": 6}
        var light_theme = ["#D9D9D9", "white", "#929292", "#585858", "black", "black", "#AAAAAA"]
        var dark_theme = ["#262626", "#464646", "#929292", "#E2E2E2", "transparent", "white", "#D1D1D1"]
        if (theme) {
            return dark_theme[theme_name[name]]
        } else {
            return light_theme[theme_name[name]]
        }
        return "transparent"
    }

    // Сетка окна
    ColumnLayout {
        id: main_layout
        anchors.centerIn: parent
        spacing: 24
        clip: false

        // Верхний текст окна
        Text {
            id: welcome
            horizontalAlignment: Qt.AlignHCenter
            text: "В HUB тебе понадобится только\nимя."
            font.bold: true
            font.family: "Inter"
            font.pixelSize: 32
            color: auth.get_theme("text")
            Layout.alignment: Qt.AlignHCenter
        }

        // Нижняя части авторизации
        Item {
            Layout.preferredWidth: 554
            Layout.preferredHeight: 236
            Layout.alignment: Qt.AlignHCenter

            ColumnLayout {
                spacing: 12
                anchors.fill: parent
                anchors.topMargin: 24
                anchors.bottomMargin: 24
                anchors.leftMargin: 1
                anchors.rightMargin: 1

                Text {
                    Layout.bottomMargin: 2
                    text: "Укажите ваше имя, по которому пользователи\nHUB могут вас определить."
                    font.family: "Inter"
                    font.pixelSize: 16
                    color: auth.get_theme("text")
                }

                // Строка ввода имени
                Rectangle {
                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 35
                    border.width: 2
                    border.color: auth.get_theme("object_border")
                    color: auth.get_theme("object")
                    radius: 8
                    clip: true

                    TextInput {
                        id: input
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 16
                        color: auth.get_theme("text")
                        property string placeholderText: "Введите ваше имя..."
                        Text {
                            text: parent.placeholderText
                            font.family: "Inter"
                            anchors.fill: parent
                            font.pixelSize: parent.font.pixelSize
                            verticalAlignment: Text.AlignVCenter
                            color: auth.get_theme("placeholder")
                            visible: !parent.text
                        }
                    }

                    Behavior on scale {
                        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        z: -1

                        onEntered: {
                            parent.scale = 1.04
                        }

                        onExited: {
                            parent.scale = 1.0
                        }
                    }
                }

                Rectangle {
                    id: login
                    Layout.preferredWidth: 140
                    Layout.preferredHeight: 42
                    border.width: 2
                    border.color: auth.get_theme("object_border")
                    radius: 8
                    color: (login_area.pressed) ? auth.get_theme("object(pressed)") : (login_area.containsMouse) ? auth.get_theme("object(hovered)") : auth.get_theme("object")
                    Text {
                        anchors.centerIn: parent
                        text: "Войти"
                        color: (Control.theme) ? (login_area.pressed) ? auth.get_theme("text", false) : auth.get_theme("text") : (login_area.pressed || login_area.containsMouse) ? auth.get_theme("text", true) : auth.get_theme("text")
                        font.family: "Inter"
                        font.pixelSize: 20
                    }

                    Behavior on scale {
                        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                    }

                    MouseArea {
                        id: login_area
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            auth.close()
                            MainControl.main_window(input.text)
                        }

                        onPressed: {
                            parent.scale = 1.0
                        }

                        onReleased: {
                            parent.scale = 1.04
                        }

                        onEntered: {
                            parent.scale = 1.04
                        }

                        onExited: {
                            parent.scale = 1.0
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Item {
        id: authors
        width: 1348
        height: 77
        rotation: -49

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            horizontalAlignment: Qt.AlignHCenter
            text: "S/B.I.A/M.N.N/K.I.R/L.A.V/P.M.Y/B.D.A/P.M.S/B.I.A/M.N.N"
            font.bold: true
            font.family: "Inter"
            font.pixelSize: 64
            color: auth.get_theme("text")
            PathAnimation {
                target: authors
                path: Path {
                    startX: auth.width - 473; startY: auth.height - 520
                    PathLine {x: auth.width - 1442; y: auth.height + 595}
                }
                running: true
                duration: 5500
                loops: Animation.Infinite
            }
        }
    }

    RowLayout {
        width: 56
        height: 14
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        spacing: 0

        Text {
            Layout.alignment: Qt.AlignBottom
            text: "HUB"
            font.bold: true
            font.italic: true
            font.family: "Inter"
            font.pixelSize: 10
            color: auth.get_theme("text")
        }
        Text {
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: 1
            text: "2024"
            font.bold: true
            font.italic: true
            font.family: "Inter"
            font.pixelSize: 7
            color: auth.get_theme("text")
        }
        Text {
            Layout.alignment: Qt.AlignBottom
            text: "©"
            font.bold: true
            font.family: "Inter"
            font.pixelSize: 10
            color: auth.get_theme("text")
        }
    }
}