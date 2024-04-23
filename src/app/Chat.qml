import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

ColumnLayout {
    id: chat
    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: 0

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 80
        color: "#D9D9D9"
        visible: chat.models.count == 0 ? false : true

        RowLayout {
            anchors.fill: parent
            anchors.margins: 12

            Rectangle {
                id: user
                Layout.preferredWidth: 232
                Layout.preferredHeight: 48
                Layout.alignment: Qt.AlignLeft
                color: "#D9D9D9"
                visible: (typeof item == "undefined") ? false : true

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 8

                    Image {
                        Layout.preferredWidth: 32
                        Layout.preferredHeight: 32
                        source: "icons/user.svg"
                    }

                    Rectangle {
                        Layout.preferredWidth: 176
                        Layout.preferredHeight: 32
                        color: user.color

                        ColumnLayout {
                            anchors.fill: parent
                            Layout.preferredWidth: 176
                            Layout.preferredHeight: 32
                            spacing: 4

                            Rectangle {
                                Layout.preferredWidth: 172
                                Layout.preferredHeight: 14
                                color: user.color
                                clip: true
                                Text {
                                    anchors.fill: parent
                                    text: (typeof item == "undefined") ? "" : item.name
                                    font.family: "Inter"
                                    font.pointSize: 10
                                }
                            }
                            
                            Rectangle {
                                Layout.preferredWidth: 172
                                Layout.preferredHeight: 14
                                color: user.color
                                clip: true
                                Text {
                                    anchors.fill: parent
                                    text: (typeof item == "undefined") ? "" : "был в сети " + (item.last_time > 59 ? Math.round(item.last_time / 60) + " часов назад" : item.last_time + " минут назад")
                                    font.family: "Inter"
                                    font.pointSize: 8
                                    color: "#808080"
                                }
                            }
                        }
                    }
                }
            }

            Text {
                Layout.preferredWidth: 220
                Layout.preferredHeight: 48
                Layout.alignment: Qt.AlignHCenter
                text: "Общий чат"
                font.weight: Font.Bold
                font.family: "Inter"
                font.pointSize: 28
                visible: (typeof item == "undefined") ? true : false
            }

            RowLayout {
                Layout.preferredWidth: 150
                Layout.preferredHeight: 56
                Layout.alignment: Qt.AlignRight
                visible: (typeof item == "undefined") ? false : true
                spacing: 12

                Rectangle {
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    Layout.alignment: Qt.AlignRight
                    color: "#D9D9D9"
                    Image {
                        anchors.centerIn: parent
                        width: 24
                        height: 24
                        source: "icons/phone.svg"
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    Layout.alignment: Qt.AlignRight
                    color: "#D9D9D9"
                    Image {
                        anchors.centerIn: parent
                        width: 24
                        height: 24
                        source: "icons/search.svg"
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 32
                    Layout.preferredHeight: 32
                    Layout.alignment: Qt.AlignRight
                    color: "#D9D9D9"
                    Image {
                        anchors.centerIn: parent
                        width: 8
                        height: 24
                        source: "icons/more_horiz.svg"
                    }
                }
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: models.count == 0 ? "#D9D9D9" : "white"
        Text {
            anchors.centerIn: parent
            text: "Добро пожаловать в HUB."
            font.weight: Font.Bold
            font.family: "Inter"
            font.pointSize: 46
            color: "#545353"
            visible: models.count == 0 ? true : false
        }
    }
        
    RowLayout {
        id: row
        Layout.fillWidth: true
        Layout.preferredHeight: 80
        spacing: 0
        visible: models.count == 0 ? false : true

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 48
            Layout.margins: 16
            border.width: 1
            color: "#D9D9D9"
        }
    }
}