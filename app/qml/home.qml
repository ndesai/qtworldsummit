import QtQuick 2.4
import QtQuick.Window 2.2

import "ui"

Viewport {
    id: root

    property Theme __theme: Theme { }

    width: 1080
    height: 1920
    color: "#000000"

    // TODO: Platform dependent status bar height
    topMargin: __theme.dp(40)

    children: [
        Image {
            id: _imageBackground
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop

            source: "img/bg.jpg"
        }
    ]

    Label {
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter

        color: "#ffffff"

        text: qsTr("QtWorldSummit")
    }

    BorderImage {
        id: _imageCard

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: __theme.dp(12)

        y: parent.height - height

        height: __theme.dp(1050)

        source: "img/card.png"

        border {
            left: __theme.dp(20)
            right: __theme.dp(20)
            top: __theme.dp(20)
            bottom: __theme.dp(20)
        }

        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.YAxis
        }
    }
}
