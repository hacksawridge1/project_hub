pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import Qt5Compat.GraphicalEffects

// Сетка чата
ColumnLayout {
    id: chat
    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: 0
    property bool connected
    property var user
    property ListModel messages_list
    property string name
    property string ip

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
        clip: true

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
            anchors.fill: parent
            verticalLayoutDirection: ListView.BottomToTop
            model: chat.messages_list
            visible: (chat.connected) ? true : false
            delegate: Item {
                id: delegate
                width: messages_view.width
                implicitHeight: message.implicitHeight + 8
                required property var model
                RowLayout {
                    id: message
                    anchors.left: (chat.ip != delegate.model.ip) ? parent.left : undefined
                    anchors.right: (chat.ip == delegate.model.ip) ? parent.right : undefined
                    layoutDirection: (chat.ip == delegate.model.ip) ? Qt.RightToLeft : Qt.LeftToRight
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16
                    spacing: 8
                    
                    Rectangle {
                        id: userbox
                        Layout.preferredWidth: 42
                        Layout.preferredHeight: 42
                        Layout.alignment: Qt.AlignBottom
                        border.width: 1
                        color: "#D9D9D9"
                        radius: 8
                        opacity: (delegate.model.index != 0 && chat.messages_list.get(delegate.model.index - 1).ip == delegate.model.ip) ? 0 : 1

                        Image {
                            anchors.centerIn: parent
                            width: 32
                            height: 32
                            source: "icons/user.svg"
                        }

                        layer.enabled: true
                        layer.effect: DropShadow {
                            horizontalOffset: 3
                            verticalOffset: 3
                            radius: 4
                            color: "#C0C0C0"
                        }
                    }

                    Rectangle {
                        id: messagebox
                        implicitWidth: (messagebox_text.implicitWidth > 600) ? 600 : messagebox_text.implicitWidth
                        implicitHeight: messagebox_text.height
                        Layout.preferredWidth: implicitWidth + 32
                        Layout.preferredHeight: implicitHeight + 32
                        Layout.alignment: Qt.AlignBottom
                        border.width: 1
                        color: "#E9E9E9"
                        radius: 8
                        clip: true
                        Text {
                            id: messagebox_text
                            width: parent.implicitWidth
                            wrapMode: Text.WordWrap
                            anchors.centerIn: parent
                            anchors.margins: 16
                            text: delegate.model.message
                            font.family: "Inter"
                            font.pixelSize: 16
                        }

                        layer.enabled: true
                        layer.effect: DropShadow {
                            horizontalOffset: 3
                            verticalOffset: 3
                            radius: 4
                            color: "#C0C0C0"
                        }
                    }
                }
            }
            add: Transition {
                NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
                NumberAnimation { property: "x"; from: (messages_view.width) / 2; to: 0; duration: 400 }
            }
            displaced: Transition {
                NumberAnimation { property: "opacity"; to: 1; duration: 0}
                NumberAnimation { property: "scale"; to: 1; duration: 0}
                NumberAnimation { property: "y"; duration: 250 }
            }
            remove: Transition {
                NumberAnimation { property: "opacity"; from: 1.0; to: 0; duration: 400 }
                NumberAnimation { property: "scale"; from: 1.0; to: 0; duration: 400 }
            }
            ScrollBar.vertical: ScrollBar {
                active: true
                height: parent.height
                policy: ScrollBar.AlwaysOff
            }
        }

        LinearGradient {
            id: mask
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 0.98
                    color: "transparent"
                }
                GradientStop {
                    position: 1
                    color: "white"
                }
            }
            visible: (chat.connected) ? true : false
        }
    }
    
    // Блок отправки сообщений
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 78
        visible: (chat.connected) ? true : false

        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            anchors.topMargin: 6
            spacing: 10

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

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
                    id: attach_file_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.1
                    }

                    onEntered: {
                        parent.scale = 1.1
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
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

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
                    id: message_field_area
                    anchors.fill: parent
                    hoverEnabled: true
                    z: -1

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.01
                    }

                    onEntered: {
                        parent.scale = 1.01
                    }

                    onExited: {
                        parent.scale = 1.0
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

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    z: -1

                    onClicked: {
                        if(!!message_input.text && message_input.text.trim().length > 0) {
                            chat.messages_list.insert(0, {"ip": chat.ip, "message": message_input.text.trim()})
                            message_input.text = ""
                        }
                    }

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.06
                    }

                    onEntered: {
                        parent.scale = 1.06
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }
        }
    }
}