import QtQuick 2.4

Rectangle {
    id: root

    default property alias content: _itemContainer.data
    property int topMargin: 0

    color: "#000000"

    Item {
        id: _itemContainer
        anchors.fill: parent
        anchors.topMargin: root.topMargin

        z: 1
    }
}
