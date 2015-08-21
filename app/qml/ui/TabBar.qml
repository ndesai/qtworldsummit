import QtQuick 2.3
import "../controls"
import ui 1.5 as UI

TabBarController {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: UI.Theme.dp(100)

    tabBarModel: [
        {
            icon : "qrc:/images/icon-home.png",
            sourceComponent: _schedule
        },
        {
            icon : "qrc:/images/icon-location.png",
            sourceComponent: _location
        },
        {
            icon : "qrc:/images/icon-information.png",
            sourceComponent: _information
        }
    ]

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: UI.Theme.dp(1)
        color: "#d2d2d1"
        z: 2
    }
}
