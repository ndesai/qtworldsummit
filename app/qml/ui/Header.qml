import QtQuick 2.4
import "../utils" as Utils

Rectangle {
    id: root

    default property alias __content : _itemContainer.data

    property alias leftContent : _itemContainerLeft.data
    property alias rightContent : _itemContainerRight.data

    property bool enableLeftAndRightContainers : false

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: __theme.heightHeader

    color: __theme.colorLightGrey
    clip: true

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: __theme.dp(2)
        color: __theme.colorLightGreyAccent
    }

    Item {
        id: _itemContainer
        anchors.top: parent.top
        anchors.topMargin: __theme.marginTop
        anchors.bottom: parent.bottom
        anchors.left: enableLeftAndRightContainers ? _itemContainerLeft.right : parent.left
        anchors.right: enableLeftAndRightContainers ? _itemContainerRight.left : parent.right
        anchors.leftMargin: __theme.dp(10)
        anchors.rightMargin: anchors.leftMargin

        Utils.Fill { }
    }

    Item {
        id: _itemContainerLeft
        anchors.top: parent.top
        anchors.topMargin: __theme.marginTop
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: __theme.dp(110)

        Utils.Fill { color: "yellow" }
    }

    Item {
        id: _itemContainerRight
        anchors.top: parent.top
        anchors.topMargin: __theme.marginTop
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: __theme.dp(110)

        Utils.Fill { color: "red" }
    }
}
