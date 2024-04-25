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
    property var user
    property ListModel messages_list

    // Верхняя панель
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 80
        Layout.leftMargin: -1
        Layout.rightMargin: -1
        color: "#D9D9D9"
        visible: (chat.connected) ? true : false
        border.width: 1

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 12 + 1
            anchors.rightMargin: 12 + 1

            Rectangle {
                Layout.preferredWidth: 300
                Layout.preferredHeight: 56
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                color: "white"
                border.width: 1
                radius: 8
                visible: (typeof chat.user == "undefined") ? false : true

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    anchors.topMargin: 10
                    anchors.bottomMargin: 12
                    spacing: 4

                    Text {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: (typeof chat.user == "undefined") ? "" : chat.user.name
                        font.family: "Inter"
                        font.pixelSize: 16
                    }
                    
                    Text {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: (typeof chat.user == "undefined") ? "" : "был в сети " + (chat.user.last_time > 59 ? Math.round(chat.user.last_time / 60) + " часов назад" : chat.user.last_time + " минут назад")
                        font.family: "Inter"
                        font.pixelSize: 12
                        color: "#808080"
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
                visible: (typeof chat.user == "undefined") ? true : false
            }

            RowLayout {
                Layout.preferredWidth: 144
                Layout.preferredHeight: 56
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                visible: (typeof chat.user == "undefined") ? false : true
                spacing: 12

                Rectangle {
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 56
                    border.width: 1
                    color: "white"
                    radius: 8

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/phone.svg"
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 56
                    border.width: 1
                    color: "white"
                    radius: 8

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/search.svg"
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 44
                    Layout.preferredHeight: 56
                    border.width: 1
                    color: "white"
                    radius: 8

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

        ListView {
            id: messages_view
        }
    }
    
    // Блок отправки сообщений
    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 88

        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 10
            visible: (chat.connected) ? true : false

            // Кнопка прикрепления файлов
            Rectangle {
                id: attach_file
                Layout.preferredWidth: 44
                Layout.preferredHeight: 56
                border.width: 1
                color: "#D9D9D9"
                radius: 8

                Image {
                    anchors.centerIn: parent
                    width: 32
                    height: 32
                    source: "icons/attach-file-add.svg"
                }
            }

            // Поле ввода сообщения
            Rectangle {
                id: message_field
                Layout.fillWidth: true
                Layout.preferredHeight: 56
                border.width: 1
                color: "#D9D9D9"
                radius: 8
                clip: true

                TextInput {
                    id: message_input
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    font.pixelSize: 24
                    color: "black"
                    property string placeholderText: "Введите ваше сообщение..."
                    Text {
                        text: parent.placeholderText
                        font.family: "Inter"
                        font.pixelSize: parent.font.pixelSize
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        color: "#aaa"
                        visible: !parent.text
                    }
                }
            }

            Button {
                Layout.preferredWidth: 143
                Layout.preferredHeight: 56
                background: Rectangle {
                    border.width: 1
                    color: "#D9D9D9"
                    radius: 8
                }
                text: "Отправить"
                font.family: "Inter"
                font.pixelSize: 24
            }
        }
    }
}