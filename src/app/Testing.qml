import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Controls.Universal

ApplicationWindow {
    width: 500
    height: 500
    visible: true
    Rectangle {
        width: 360
        height: 240

        ListModel {
            id: dataModel

            ListElement {
                color: "orange"
                texts: [
                    ListElement { text: "one" },
                    ListElement { text: "two" }
                ]
            }
            ListElement {
                color: "skyblue"
                texts: [
                    ListElement { text: "three" },
                    ListElement { text: "four" }
                ]
            }
        }
        ColumnLayout {
            anchors.fill: parent
            ListView {
                id: view
                Layout.fillWidth: true
                Layout.fillHeight: true
                //anchors.margins: 10
                spacing: 10
                model: dataModel

                delegate: Rectangle {
                    width: view.width
                    height: 100
                    color: model.color

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 10

                        Repeater {
                            model: texts
                            delegate: Text {
                                verticalAlignment: Text.AlignVCenter
                                renderType: Text.NativeRendering
                                text: model.text
                            }
                        }
                    }
                }
            }
        }
        
    }
}
