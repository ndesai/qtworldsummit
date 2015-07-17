import QtQuick 2.4
import QtQuick.Controls.Styles 1.3 as CS
import "qrc:/qml/qml/ui" 1.5 as UI

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
