import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

ApplicationWindow {
    id: main_window
    visible: true
    visibility: Window.Maximized
    width: 1920
    height: 1080
    title: "HUB"

    GridLayout {
        id: main_grid
        anchors.fill: parent
        columns: 2
        rows: 1
        SideBar {
            id: sidebar
        }
    }
}