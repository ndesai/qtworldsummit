import QtQuick 2.4

Rectangle {
    id: root

    function randomColor() {
        // http://www.paulirish.com/2009/random-hex-color-code-snippets/
        return '#'+Math.floor(Math.random()*16777215).toString(16);
    }

    anchors.fill: parent
    color: "#00FEAA"
    opacity: 0.5
    visible: superRoot.showFills
    border {
        width: this === superRoot.activeObject ? 4 : 0
        color: "#ffffff"
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 4
        color: "transparent"
        border {
            width: root.border.width
            color: "#000000"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: superRoot.activeObject = root
    }
}
