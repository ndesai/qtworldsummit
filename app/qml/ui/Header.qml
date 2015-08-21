import QtQuick 2.5
import utils 1.5 as Utils
import ui 1.5 as UI

Rectangle {
    id: root

    default property alias __content : _itemContainer.data

    property alias leftContent : _itemContainerLeft.data
    property alias rightContent : _itemContainerRight.data

    property bool enableLeftAndRightContainers : false

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    height: UI.Theme.heightHeader

    color: UI.Theme.colorLightGrey
    clip: true

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        height: 2
        color: UI.Theme.colorLightGreyAccent
    }

    Item {
        id: _itemContainer

        anchors {
            top: parent.top; topMargin: UI.Theme.marginTop
            bottom: parent.bottom
            left: enableLeftAndRightContainers ? _itemContainerLeft.right : parent.left; leftMargin: 10
            right: enableLeftAndRightContainers ? _itemContainerRight.left : parent.right; rightMargin: anchors.leftMargin
        }

        Utils.Fill { }
    }

    Item {
        id: _itemContainerLeft

        anchors {
            top: parent.top; topMargin: 40
            left: parent.left
            bottom: parent.bottom
        }

        width: UI.Theme.dp(110)

        Utils.Fill { color: "yellow" }
    }

    Item {
        id: _itemContainerRight

        anchors {
            top: parent.top; topMargin: 40
            right: parent.right
            bottom: parent.bottom
        }

        width: UI.Theme.dp(110)

        Utils.Fill { color: "red" }
    }
}
