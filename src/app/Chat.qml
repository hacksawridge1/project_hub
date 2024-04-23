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
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: models.count == 0 ? "#D9D9D9" : "white"
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