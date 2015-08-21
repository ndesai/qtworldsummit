import QtQuick 2.5
import QtQuick.Controls.Styles 1.4 as CS
import ui 1.5 as UI

CS.ButtonStyle {
    id: root

    property url imageSource

    background: Rectangle {
        color: control.checked ? UI.Theme.activeTabColor : UI.Theme.unactiveTabColor

        Image {
            anchors.centerIn: parent

            sourceSize.height: root.control.height / 2
            sourceSize.width: root.control.height / 2

            source: root.imageSource
        }
    }
}
