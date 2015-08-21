import QtQuick 2.4
import utils 1.5
import controls 1.5
import ui 1.5

Rectangle {
    Item {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: _tabBarController.top
        }

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


