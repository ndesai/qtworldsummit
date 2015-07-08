import QtQuick 2.0
import "../utils" as Utils

Rectangle {
    id: root

    property bool skeleton : false
    property alias rowWidth : _row.width
    property color baseColor : __theme.colorQtMediumGreen

    anchors.verticalCenter: parent.verticalCenter
    width: _row.width
    height: 52
    radius: 10

    color: !skeleton ? baseColor : "transparent"
    border {
        width: !root.skeleton ? 0 : 2
        color: root.baseColor
    }

    transformOrigin: Item.Center
    // There is a painting delay if we hide this icon
    // when not in use. It stutters the animation
    // visible: opacity>0
    clip: true
    layer.enabled: true
    layer.smooth: true

    Row {
        id: _row
        height: parent.height

        Utils.HorizontalSpacer {
            width: __theme.dp(12)
        }

        Utils.BaseIcon {
            anchors.centerIn: undefined
            anchors.verticalCenter: parent.verticalCenter
            source: "../img/icon-clock-filled.png"
            color: _labelNow.color
            width: __theme.dp(24)

            Utils.Fill { }
        }

        Utils.HorizontalSpacer {
            width: __theme.dp(12)
        }

        Label {
            id: _labelNow
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 1
            font.pixelSize: __theme.dp(24)
            color: !skeleton ? "#ffffff" : root.baseColor
            text: qsTr("NOW")
            style: Text.Raised
            styleColor: !root.skeleton ? "transparent" : root.baseColor

            Utils.Fill { }
        }

        Utils.HorizontalSpacer {
            width: __theme.dp(24)
        }
    }
}
