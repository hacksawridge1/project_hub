import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

Button {
    id: button
    Layout.preferredWidth: 232
    Layout.preferredHeight: 48
    Layout.column: 1
    Layout.row: 1
    background: Rectangle {
        border.width: 1
    }

    property Text name: user_name
    property Text ip: user_ip

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        Image {
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            source: "icons\\user.svg"
        }

        Rectangle {
            Layout.preferredWidth: 176
            Layout.preferredHeight: 32
            ColumnLayout {
                anchors.fill: parent
                Layout.preferredWidth: 176
                Layout.preferredHeight: 32
                spacing: 4

                Rectangle {
                    Layout.preferredWidth: 172
                    Layout.preferredHeight: 14
                    clip: true
                    Text {
                        id: user_name
                        anchors.fill: parent
                        text: "TED"
                        font.family: "Inter"
                        font.pointSize: 10
                    }
                }
                
                Rectangle {
                    Layout.preferredWidth: 172
                    Layout.preferredHeight: 14
                    clip: true
                    Text {
                        id: user_ip
                        anchors.fill: parent
                        text: "IP: 192.168.3.152"
                        font.family: "Inter"
                        font.pointSize: 8
                        color: "#808080"
                    }
                }
            }
        }
    }
}