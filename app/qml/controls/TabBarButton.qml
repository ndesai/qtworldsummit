import QtQuick 2.2
import "../utils"

Rectangle {
    id: _root

    signal clicked
    property alias icon : _BaseIcon.source
    property alias iconWidth : _BaseIcon.width
    property alias iconObject : _BaseIcon
    readonly property bool isActive : root.activeButton === this

    property variant theme : root.theme

    width: __theme.dp(120)
    height: __theme.dp(100)
    color: !isActive ? (!_MouseArea.pressed ?
                            theme.backgroundDefaultColor :
                            theme.backgroundPressedColor) : theme.backgroundActiveColor

    BaseIcon {
        id: _BaseIcon
        anchors.centerIn: parent
        width: __theme.dp(54)
        color: !isActive ? (!_MouseArea.pressed ?
                                theme.iconDefaultColor :
                                theme.iconPressedColor) : theme.iconActiveColor
        transformOrigin: Item.Center
    }

    MouseArea {
        id: _MouseArea
        anchors.fill: parent
        onClicked: _root.clicked()
    }
}
