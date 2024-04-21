import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Window 2.15
import QtQuick.Controls.Universal
//import MyModule 1.0

ApplicationWindow {
    id: authorization

    visible: true
    width: 600
    height: 400
    title: "Authorization"
    color: "#D9D9D9"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 24

        Rectangle {
            Layout.preferredWidth: 552
            Layout.preferredHeight: 78
            Layout.alignment: Qt.AlignHCenter
            color: "#D9D9D9"
            Text {
                id: welcome
                anchors.centerIn: parent
                horizontalAlignment: Qt.AlignHCenter
                text: "В HUB тебе понадобится только\nимя."
                font.weight: Font.Bold
                font.family: "Inter"
                font.pointSize: 22
            }
        }

        Rectangle {
            Layout.preferredWidth: 552
            Layout.preferredHeight: 236
            Layout.alignment: Qt.AlignHCenter
            color: "#D9D9D9"
            ColumnLayout {
                spacing: 12
                anchors.fill: parent
                anchors.topMargin: 24
                anchors.bottomMargin: 24

                Rectangle {
                    Layout.preferredWidth: 400
                    Layout.preferredHeight: 44
                    color: "#D9D9D9"
                    Text {
                        text: "Укажите ваше имя, по которому пользователи\nHUB могут вас определить."
                        font.family: "Inter"
                        font.pointSize: 13
                    }
                }
                Rectangle {
                    Layout.preferredWidth: 291
                    Layout.preferredHeight: 27
                    border.width: 1
                    clip: true
                    TextInput {
                        id: input
                        anchors.fill: parent
                        anchors.margins: 4
                        font.pixelSize: 15
                        color: "black"
                        property string placeholderText: "Введите ваше имя..."
                        Text {
                            text: input.placeholderText
                            font.family: "Inter"
                            font.pixelSize: 16
                            color: "#aaa"
                            visible: !input.text
                        }
                    }
                }

                Button {
                    id: login
                    Layout.preferredWidth: 140
                    Layout.preferredHeight: 42
                    background: Rectangle {
                        border.width: 1
                    }
                    text: "Войти"
                    font.family: "Inter"
                    font.pointSize: 17
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            authorization.close()
                            var component = Qt.createComponent("MainWindow.qml")
                            MainWindow.main_window = component.createObject()
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100
                    color: "#D9D9D9"
                }
            }
        }
        

        RowLayout {
            Layout.preferredWidth: 56
            Layout.preferredHeight: 14
            Layout.alignment: Qt.AlignHCenter

            Image {
                source: "icons\\HUB 2024.svg"
            }

            Image {
                source: "icons\\©.svg"
            }
        }
    }

    Rectangle {
        id: rect_authors
        width: 1348
        height: 77
        rotation: -49
        x: 167
        y: -160
        color: "#D9D9D9"
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            horizontalAlignment: Qt.AlignHCenter
            text: "S/B.I.A/M.N.N/K.I.R/L.A.V/P.M.Y/B.D.A/P.M.S/B.I.A/M.N.N"
            font.weight: Font.Bold
            font.family: "Inter"
            font.pointSize: 42
            PathAnimation {
                target: rect_authors
                path: Path {
                    startX: 127; startY: -120
                    PathLine {x: -720; y: 855}
                }
                running: true
                duration: 5500
                loops: Animation.Infinite
            }
        }
    }
}