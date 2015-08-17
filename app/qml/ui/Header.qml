import QtQuick 2.4
import "../utils" as Utils
import "qrc:/qml/qml/ui" 1.5 as UI

Rectangle {
    id: root

    default property alias __content : _itemContainer.data

    property alias leftContent : _itemContainerLeft.data
    property alias rightContent : _itemContainerRight.data

    property bool enableLeftAndRightContainers : false

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: UI.Theme.heightHeader

    color: UI.Theme.colorLightGrey
    clip: true

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 2
        color: UI.Theme.colorLightGreyAccent
    }

    Item {
        id: _itemContainer
        anchors.top: parent.top
        anchors.topMargin: UI.Theme.marginTop
        anchors.bottom: parent.bottom
        anchors.left: enableLeftAndRightContainers ? _itemContainerLeft.right : parent.left
        anchors.right: enableLeftAndRightContainers ? _itemContainerRight.left : parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: anchors.leftMargin

        Utils.Fill { }
    }

    Item {
        id: _itemContainerLeft
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: UI.Theme.dp(110)

        Utils.Fill { color: "yellow" }
    }

    Item {
        id: _itemContainerRight
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: UI.Theme.dp(110)

        Utils.Fill { color: "red" }
    }
}
