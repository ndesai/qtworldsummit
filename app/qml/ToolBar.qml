import QtQuick 2.5
import "qrc:/qml/qml/ui" 1.5 as UI

Rectangle {
    color: UI.Theme.toolBarColor

    height: UI.Theme.toolBarHeight

    Image {
        anchors {
            right: parent.right; rightMargin: 4
            verticalCenter: parent.verticalCenter
        }

        height: parent.height * 0.52
        width: parent.height * 0.52

        sourceSize.height: parent.height * 0.52
        sourceSize.width: parent.height * 0.52

        source: "qrc:/images/favorite.svg"
    }
}
