pragma ComponentBehavior: Bound
import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal
import Qt5Compat.GraphicalEffects
import QtQuick.Dialogs
import Controller

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
    property bool theme
    function get_theme(name, theme = chat.theme) {
        var theme_name = {"chat": 0, "object": 1, "object(hovered)": 2, "object(pressed)": 3, "object_border": 4, 
        "text": 5, "second_text": 6, "title": 7, "placeholder": 8, "message_shadow": 9}
        var light_theme = ["#D9D9D9", "white", "#929292", "#585858", "black", "black", "#808080", "#545454", "#AAAAAA", "#C0C0C0"]
        var dark_theme = ["#262626", "#464646", "#929292", "#E2E2E2", "transparent", "white", "#E0E0E0", "#AFAFAF", "#D1D1D1", "#101010"]
        if (theme) {
            return dark_theme[theme_name[name]]
        } else {
            return light_theme[theme_name[name]]
        }
        return "transparent"
    }

    function add_message(name, ip, message) {
        chat.messages_list.insert(0, {"name": name, "ip": ip, "message": message})
    }

    function costil() {
        chat.messages_list.clear()
        if (!user) {
            chat.messages_list.insert(0, {"name": "noname", "ip": "192.168.3.152", "type": "message", "size": "", "message": "Всем привет, не знаете где можно посидеть спокойно?", "time": "17:24"})
            chat.messages_list.insert(0, {"name": name, "ip": ip, "type": "message", "size": "", "message": "Привет, иди в библиотеку, там тихо достаточно", "time": "17:29"})
            chat.messages_list.insert(0, {"name": "noname2", "ip": "192.168.3.152", "type": "message", "size": "", "message": "Привет, да, библиотека лучшее место, где можно посидеть, ни на что не отвлекаясь", "time": "17:30"})
            chat.messages_list.insert(0, {"name": "noname", "ip": "192.168.3.152", "type": "message", "size": "", "message": "Хорошо, спасибо большое", "time": "17:32"})
            return
        }
        if (user.name == "Иван") {
            chat.messages_list.insert(0, {"name": "Иван", "ip": "192.168.3.152", "type": "message", "size": "", "message": "А почему я среди пользователей?", "time": "17:24"})
            chat.messages_list.insert(0, {"name": name, "ip": ip, "type": "message", "size": "", "message": "Ну не будешь же ты во время презентации мышкой елозить по столу...", "time": "17:29"})
            chat.messages_list.insert(0, {"name": "Иван", "ip": "192.168.3.152", "type": "message", "size": "", "message": "Хм, согласен, справедливо", "time": "17:30"})
            return
        }
        if (user.name == "Ильяз") {
            chat.messages_list.insert(0, {"name": "Ильяз", "ip": "192.168.3.152", "type": "message", "size": "", "message": "Привет, когда на созвон?", "time": "17:24"})
            chat.messages_list.insert(0, {"name": name, "ip": ip, "type": "message", "size": "", "message": "Привет, спасибо, что напомнил, часиков в 9 давай.", "time": "17:29"})
            chat.messages_list.insert(0, {"name": name, "ip": ip, "type": "message", "size": "", "message": "Можешь скинуть о чём мы сегодня договоаривались?", "time": "17:29"})
            chat.messages_list.insert(0, {"name": "Ильяз", "ip": "192.168.3.152", "type": "message", "size": "", "message": "Да, одну секунду", "time": "17:30"})
            chat.messages_list.insert(0, {"name": "Ильяз", "ip": "192.168.3.152", "type": "file", "size": "120 Kb", "message": "file_name.zip", "time": "17:31"})
            return
        }
    }

    // Верхняя панель
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 80
        color: chat.get_theme("chat")
        visible: (chat.connected) ? true : false

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12

            Rectangle {
                Layout.preferredWidth: 600
                Layout.preferredHeight: 64
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                color: (user_card_area.pressed) ? chat.get_theme("object(pressed)") : (user_card_area.containsMouse) ? chat.get_theme("object(hovered)") : chat.get_theme("object")
                border.width: 2
                border.color: chat.get_theme("object_border")
                radius: 8
                visible: (typeof chat.user == "undefined") ? false : true
                
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 8

                    ColumnLayout {
                        Layout.preferredWidth: 152
                        Layout.fillHeight: true
                        spacing: 3

                        Text {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            verticalAlignment: Text.AlignBottom
                            text: (typeof chat.user == "undefined") ? "" : chat.user.name
                            font.family: "Inter"
                            font.pixelSize: 14
                            color: (chat.theme) ? (user_card_area.pressed) ? chat.get_theme("text", false) : chat.get_theme("text") : (user_card_area.pressed || user_card_area.containsMouse) ? chat.get_theme("text", true) : chat.get_theme("text")
                        }
                        
                        Text {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            verticalAlignment: Text.AlignTop
                            text: (typeof chat.user == "undefined") ? "" : "был в сети " + (chat.user.last_time > 59 ? Math.round(chat.user.last_time / 60) + " часов назад" : chat.user.last_time + " минут назад")
                            font.family: "Inter"
                            font.pixelSize: 12
                            color: (chat.theme) ? (user_card_area.pressed) ? chat.get_theme("second_text", false) : chat.get_theme("second_text") : (user_card_area.pressed || user_card_area.containsMouse) ? chat.get_theme("second_text", true) : chat.get_theme("second_text")
                        }
                    }

                    Rectangle {
                        Layout.preferredWidth: 1
                        Layout.fillHeight: true
                        color: (chat.theme && user_card_area.pressed) ? "#545454" : "#D9D9D9"
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        verticalAlignment: Text.AlignTop
                        horizontalAlignment: Text.AlignLeft
                        wrapMode: Text.Wrap
                        elide: Text.ElideRight
                        text: "Добавьте описание пользователя..."
                        font.family: "Inter"
                        font.pixelSize: 16
                        color: (chat.theme) ? (user_card_area.pressed) ? chat.get_theme("second_text", false) : chat.get_theme("second_text") : (user_card_area.pressed || user_card_area.containsMouse) ? chat.get_theme("second_text", true) : chat.get_theme("second_text")
                    }
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
                    id: user_card_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed: {
                        parent.scale = 1.0
                    }

                    onReleased: {
                        parent.scale = 1.03
                    }

                    onEntered: {
                        parent.scale = 1.03
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }

            Text {
                Layout.preferredWidth: 220
                Layout.preferredHeight: 48
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: "Общий чат"
                font.bold: true
                font.family: "Inter"
                font.pixelSize: 38
                color: chat.get_theme("title")
                visible: (typeof chat.user == "undefined") ? true : false
            }

            RowLayout {
                Layout.preferredHeight: 56
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                visible: (typeof chat.user == "undefined") ? false : true
                spacing: 8

                Rectangle {
                    Layout.preferredWidth: 75
                    Layout.preferredHeight: 56
                    border.width: 2
                    border.color: chat.get_theme("object_border")
                    color: (phone_area.pressed) ? chat.get_theme("object(pressed)") : (phone_area.containsMouse) ? chat.get_theme("object(hovered)") : chat.get_theme("object")
                    radius: 8

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/phone.svg"

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: (chat.theme) ? (phone_area.pressed) ? "black" : "white" : (phone_area.pressed || phone_area.containsMouse) ? "white" : "black"
                        }
                    }

                    Behavior on scale {
                        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                    }

                    MouseArea {
                        id: phone_area
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

                Rectangle {
                    Layout.preferredWidth: 75
                    Layout.preferredHeight: 56
                    border.width: 2
                    border.color: chat.get_theme("object_border")
                    color: (search_area.pressed) ? chat.get_theme("object(pressed)") : (search_area.containsMouse) ? chat.get_theme("object(hovered)") : chat.get_theme("object")
                    radius: 8

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/search.svg"

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: (chat.theme) ? (search_area.pressed) ? "black" : "white" : (search_area.pressed || search_area.containsMouse) ? "white" : "black"
                        }
                    }

                    Behavior on scale {
                        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                    }

                    MouseArea {
                        id: search_area
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

                Rectangle {
                    Layout.preferredWidth: 75
                    Layout.preferredHeight: 56
                    border.width: 2
                    border.color: chat.get_theme("object_border")
                    color: (more_area.pressed) ? chat.get_theme("object(pressed)") : (more_area.containsMouse) ? chat.get_theme("object(hovered)") : chat.get_theme("object")
                    radius: 8

                    Image {
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        source: "icons/more.svg"

                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: (chat.theme) ? (more_area.pressed) ? "black" : "white" : (more_area.pressed || more_area.containsMouse) ? "white" : "black"
                        }
                    }

                    Behavior on scale {
                        NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                    }

                    MouseArea {
                        id: more_area
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
            }
        }
    }

    // Блок чата
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: chat.get_theme("chat")
        clip: true

        Text {
            anchors.centerIn: parent
            text: "Добро пожаловать в HUB."
            font.bold: true
            font.family: "Inter"
            font.pixelSize: 64
            color: chat.get_theme("title")
            visible: (chat.connected) ? false : true
        }

        ListView {
            id: messages_view
            anchors.fill: parent
            verticalLayoutDirection: ListView.BottomToTop
            model: chat.messages_list
            boundsBehavior: Flickable.StopAtBounds
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
                        border.width: 2
                        border.color: chat.get_theme("object_border")
                        color: chat.get_theme("object")
                        radius: 8
                        opacity: (chat.messages_list.get(delegate.model.index - 1) && chat.messages_list.get(delegate.model.index - 1).ip == delegate.model.ip) ? 0 : 1

                        Image {
                            anchors.centerIn: parent
                            width: 32
                            height: 32
                            source: "icons/user.svg"

                            ColorOverlay {
                                anchors.fill: parent
                                source: parent
                                color: (chat.theme) ? "white" : "#545353"
                            }
                        }

                        layer.enabled: true
                        layer.effect: DropShadow {
                            horizontalOffset: 3
                            verticalOffset: 3
                            radius: 4
                            color: chat.get_theme("message_shadow")
                        }
                    }

                    Rectangle {
                        id: messagebox
                        implicitWidth: (delegate.model.type && delegate.model.type == "file") ? null : (messagebox_text.implicitWidth > 600) ? 600 : messagebox_text.implicitWidth
                        implicitHeight: (delegate.model.type && delegate.model.type == "file") ? null : messagebox_text.height
                        Layout.preferredWidth: (delegate.model.type && delegate.model.type == "file") ? 155 : implicitWidth + 32
                        Layout.preferredHeight: (delegate.model.type && delegate.model.type == "file") ? 52 : implicitHeight + 32
                        Layout.alignment: Qt.AlignBottom
                        border.width: 2
                        border.color: chat.get_theme("object_border")
                        color: chat.get_theme("object")
                        radius: 8
                        clip: true

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            anchors.leftMargin: 12
                            anchors.rightMargin: 12

                            ColumnLayout {
                                id: message_layout
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                spacing: 3

                                Text {
                                    id: messagebox_text
                                    Layout.alignment: Qt.AlignTop
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    parent: (delegate.model.type && delegate.model.type == "file") ? message_layout : messagebox
                                    width: (delegate.model.type && delegate.model.type == "file") ? undefined : parent.implicitWidth
                                    wrapMode: Text.Wrap
                                    anchors.centerIn: (delegate.model.type && delegate.model.type == "file") ? undefined : parent
                                    anchors.margins: (delegate.model.type && delegate.model.type == "file") ? null : 16
                                    text: delegate.model.message
                                    font.family: "Inter"
                                    font.pixelSize: 16
                                    color: chat.get_theme("text")
                                }

                                Text {
                                    visible: (delegate.model.type && delegate.model.type == "file") ? true : false
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.alignment: Qt.AlignBottom
                                    text: (delegate.model.size) ? delegate.model.size : ""
                                    font.family: "Inter"
                                    font.pixelSize: 12
                                    color: chat.get_theme("second_text")
                                }
                            }

                            Rectangle {
                                color: chat.get_theme("object")
                                visible: (delegate.model.type && delegate.model.type == "file") ? true : false
                                Layout.preferredWidth: 24
                                Layout.preferredHeight: 24
                                Layout.alignment: Qt.AlignVCenter

                                Image {
                                    width: 16
                                    height: 16
                                    anchors.centerIn: parent
                                    source: "icons/download.svg"
                                    
                                    ColorOverlay {
                                        anchors.fill: parent
                                        source: parent
                                        color: (chat.theme) ? "#ABACAC" : "#545353"
                                    }
                                }
                            }
                        }

                        

                        layer.enabled: true
                        layer.effect: DropShadow {
                            horizontalOffset: 3
                            verticalOffset: 3
                            radius: 4
                            color: chat.get_theme("message_shadow")
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignBottom
                        text: (delegate.model.time) ? delegate.model.time : ""
                        font.family: "Inter"
                        font.pixelSize: 12
                        color: chat.get_theme("second_text")
                    }
                }
            }

            add: Transition {
                id: addTrans
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
                    position: 0.985
                    color: "transparent"
                }
                GradientStop {
                    position: 1
                    color: chat.get_theme("chat")
                }
            }
            visible: (chat.connected) ? true : false
        }
    }
    
    // Блок отправки сообщений
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 76
        visible: (chat.connected) ? true : false
        color: chat.get_theme("chat")

        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 10

            // Кнопка прикрепления файлов
            Rectangle {
                Layout.preferredWidth: 44
                Layout.preferredHeight: 44
                border.width: 2
                border.color: chat.get_theme("object_border")
                color: (file_attach_area.pressed) ? chat.get_theme("object(pressed)") : (file_attach_area.containsMouse) ? chat.get_theme("object(hovered)") : chat.get_theme("object")
                radius: 8

                Image {
                    anchors.centerIn: parent
                    width: 32
                    height: 32
                    source: "icons/attach-file-add.svg"

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: (chat.theme) ? (file_attach_area.pressed) ? "black" : "white" : (file_attach_area.pressed || file_attach_area.containsMouse) ? "white" : "black"
                    }
                }

                FileDialog {
                    id: file_attach_dialog
                    currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
                    id: file_attach_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        file_attach_dialog.open()
                        if (file_attach_dialog.selectedFile) {

                        }
                    }

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
                Layout.preferredHeight: 44
                border.width: 2
                border.color: chat.get_theme("object_border")
                color: chat.get_theme("object")
                radius: 8
                clip: true

                TextInput {
                    id: message_input
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    font.pixelSize: 24
                    color: chat.get_theme("text")
                    property string placeholderText: "Введите ваше сообщение..."
                    Text {
                        text: parent.placeholderText
                        font.family: "Inter"
                        font.pixelSize: parent.font.pixelSize
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        color: chat.get_theme("placeholder")
                        visible: !parent.text
                    }
                    Keys.onReturnPressed: {
                        if(!!message_input.text && message_input.text.trim().length > 0) {
                            chat.add_message(chat.name, chat.ip, message_input.text)
                            Control.send_message(user.name, user.ip, message_input.text)
                            message_input.text = ""
                        }
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
                        parent.scale = 1.01
                    }

                    onExited: {
                        parent.scale = 1.0
                    }
                }
            }

            // Кнопка отправки сообщения
            Rectangle {
                Layout.preferredWidth: 143
                Layout.preferredHeight: 44
                border.width: 2
                border.color: chat.get_theme("object_border")
                color: (send_area.pressed) ? chat.get_theme("object(pressed)") : (send_area.containsMouse) ? chat.get_theme("object(hovered)") : chat.get_theme("object")
                radius: 8
                Text {
                    anchors.centerIn: parent
                    text: "Отправить"
                    font.family: "Inter"
                    font.pixelSize: 24
                    color: (chat.theme) ? (send_area.pressed) ? chat.get_theme("text", false) : chat.get_theme("text") : (send_area.pressed || send_area.containsMouse) ? chat.get_theme("text", true) : chat.get_theme("text")
                }

                Behavior on scale {
                    NumberAnimation { easing.type: Easing.InOutQuad; duration: 100 }
                }

                MouseArea {
                    id: send_area
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        if(message_input.text && message_input.text.trim().length > 0) {
                            chat.add_message(chat.name, chat.ip, message_input.text)
                            Control.send_message(user.name, user.ip, message_input.text)
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