import QtQuick 2.3
import "../controls"

TabBarController {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: __theme.tabBarHeight

    tabBarModel: [
        {
            icon : "../img/icon-home.png",
            sourceComponent: _schedule
        },
        {
            icon : "../img/icon-location.png",
            sourceComponent: _location
        },
        {
            icon : "../img/icon-information.png",
            sourceComponent: _information
        }
    ]

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: __theme.dp(1)
        color: "#d2d2d1"
        z: 2
    }
}
