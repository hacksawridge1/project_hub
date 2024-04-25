import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

// Сетка чата
ColumnLayout {
    id: chat
    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: 0
    property bool connected
    property var item

    // Блок пользователя
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 80
        color: "#D9D9D9"
        visible: (chat.connected) ? true : false

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12

            Rectangle {
                id: user
                Layout.preferredWidth: 232
                Layout.preferredHeight: 48
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                color: "#D9D9D9"
                visible: (typeof chat.item == "undefined") ? false : true

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 4

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: user.color
                        clip: true
                        Text {
                            anchors.fill: parent
                            text: (typeof chat.item == "undefined") ? "" : chat.item.name
                            font.family: "Inter"
                            font.pixelSize: 13
                        }
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: user.color
                        clip: true
                        Text {
                            anchors.fill: parent
                            text: (typeof chat.item == "undefined") ? "" : "был в сети " + (chat.item.last_time > 59 ? Math.round(chat.item.last_time / 60) + " часов назад" : chat.item.last_time + " минут назад")
                            font.family: "Inter"
                            font.pixelSize: 11
                            color: "#808080"
                        }
                    }
                }
            }

            Text {
                Layout.preferredWidth: 220
                Layout.preferredHeight: 48
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: "Общий чат"
                font.weight: Font.Bold
                font.family: "Inter"
                font.pixelSize: 38
                color: "#545353"
                visible: (typeof chat.item == "undefined") ? true : false
            }

            RowLayout {
                Layout.preferredWidth: 144
                Layout.preferredHeight: 56
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                visible: (typeof chat.item == "undefined") ? false : true
                spacing: 12

                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 48
                    border.width: 1
                    color: "white"

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/phone.svg"
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 48
                    border.width: 1
                    color: "white"

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/search.svg"
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 48
                    border.width: 1
                    color: "white"

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/more.svg"
                    }
                }
            }
        }
    }

    // Блок чата
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: (chat.connected) ? "white" : "#D9D9D9"
        Text {
            anchors.centerIn: parent
            text: "Добро пожаловать в HUB."
            font.weight: Font.Bold
            font.family: "Inter"
            font.pixelSize: 64
            color: "#545353"
            visible: (chat.connected) ? false : true
        }
    }
    
    // Блок отправки сообщений
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 80
        color: "white"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 10
            visible: (chat.connected) ? true : false

            // Поле ввода сообщения
            Rectangle {
                id: message_field
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                border.width: 1
                color: "#D9D9D9"

                RowLayout {
                    anchors.fill: parent
                    anchors.topMargin: 8
                    anchors.bottomMargin: 8
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 10

                    Button {
                        Layout.preferredWidth: 32
                        Layout.preferredHeight: 32
                        Layout.alignment: Qt.AlignVCenter
                        background: Rectangle {
                            color: message_field.color
                        }

                        Image {
                            width: 32
                            height: 32
                            source: "icons/attach-file-add.svg"
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.topMargin: 2
                        Layout.bottomMargin: 2
                        color: message_field.color
                        clip: true

                        TextInput {
                            id: message_input
                            anchors.fill: parent
                            anchors.margins: 2
                            font.pixelSize: 20
                            color: "black"
                            property string placeholderText: "Введите ваше сообщение..."
                            Text {
                                text: parent.placeholderText
                                font.family: "Inter"
                                font.pixelSize: parent.font.pixelSize
                                color: "#aaa"
                                visible: !parent.text
                            }
                        }
                    }
                }
            }

            Button {
                Layout.preferredWidth: 143
                Layout.preferredHeight: 48
                background: Rectangle {
                    border.width: 1
                    color: "#D9D9D9"
                }
                text: "Отправить"
                font.family: "Inter"
                font.pixelSize: 24
            }
        }
    }
}