import QtQuick 2.5
import utils 1.5
import ui 1.5 as UI

Rectangle {
    id: _root

    property alias icon : _BaseIcon.source
    property alias iconWidth : _BaseIcon.width
    property alias iconObject : _BaseIcon
    readonly property bool isActive : root.activeButton === this

    signal clicked

    width: UI.Theme.dp(120)
    height: UI.Theme.dp(100)
    color: !isActive ? (!_MouseArea.pressed ?
                            root.theme.backgroundDefaultColor :
                            root.theme.backgroundPressedColor) : root.theme.backgroundActiveColor

    BaseIcon {
        id: _BaseIcon
        anchors.centerIn: parent
        width: UI.Theme.dp(54)
        color: !isActive ? (!_MouseArea.pressed ?
                                root.theme.iconDefaultColor :
                                root.theme.iconPressedColor) : root.theme.iconActiveColor
        transformOrigin: Item.Center
    }

    MouseArea {
        id: _MouseArea
        anchors.fill: parent
        onClicked: _root.clicked()
    }
}
