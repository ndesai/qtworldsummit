import QtQuick 2.5
import "qrc:/qml/qml/ui" 1.5 as UI

Rectangle {
    id: root

    function randomColor() {
        /// http://www.paulirish.com/2009/random-hex-color-code-snippets/
        return '#' + Math.floor(Math.random() * 16777215).toString(16)
    }

    anchors.fill: parent

    color: "#00FEAA"
    opacity: 0.5
    visible: UI.Theme.showFills

    border {
        width: UI.Theme.activeObject === root ? 4 : 0
        color: "#ffffff"
    }

    Rectangle {
        anchors {
            fill: parent
            margins: 4
        }

        color: "transparent"

        border {
            width: root.border.width
            color: "#000000"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: UI.Theme = root
    }
}
