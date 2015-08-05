import QtQuick 2.4
import "utils"
import "controls"
import "ui"

Rectangle {

    Item {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: _tabBarController.top

        Schedule {
            id: _schedule
            controller: _tabBarController
        }

        // TODO: ND - Location.qml
        Location {
            id: _location
            controller: _tabBarController
        }

        // TODO: ND - Information.qml
        BaseTabBarPage {
            id: _information
            controller: _tabBarController

            Rectangle {
                anchors.fill: parent
                color: "blue"
            }
        }
    }

    TabBar {
        id: _tabBarController

        onHideAllPages: {
            // close all sheets
        }
    }
}


