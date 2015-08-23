import QtQuick 2.4
import utils 1.5 as Utils
import ui 1.5 as UI

Rectangle {
    id: root

    default property alias content: itemContainer.data

    property alias leftContent: itemContainerLeft.data
    property alias rightContent: itemContainerRight.data

    property bool enableLeftAndRightContainers: false

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
        id: itemContainer

        anchors {
            top: parent.top; topMargin: UI.Theme.marginTop
            bottom: parent.bottom
            left: enableLeftAndRightContainers ? itemContainerLeft.right : parent.left; leftMargin: 10
            right: enableLeftAndRightContainers ? itemContainerRight.left : parent.right; rightMargin: anchors.leftMargin
        }
    }

    Item {
        id: itemContainerLeft

        anchors {
            top: parent.top; topMargin: UI.Theme.marginTop
            left: parent.left
            bottom: parent.bottom
        }

        width: UI.Theme.dp(110)
    }

    Item {
        id: itemContainerRight

        anchors {
            top: parent.top; topMargin: UI.Theme.marginTop
            right: parent.right
            bottom: parent.bottom
        }

        width: UI.Theme.dp(110)
    }
}
