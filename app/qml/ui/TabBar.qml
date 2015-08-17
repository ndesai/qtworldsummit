import QtQuick 2.3
import "../controls"
import "qrc:/qml/qml/ui" 1.5 as UI

TabBarController {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: UI.Theme.dp(100)

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
        height: UI.Theme.dp(1)
        color: "#d2d2d1"
        z: 2
    }
}
