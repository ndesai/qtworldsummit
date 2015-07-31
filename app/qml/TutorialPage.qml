import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import "qrc:/qml/qml/ui" 1.5 as UI

Rectangle {
    id: root

    signal skipTutorial

    Label {
        id: labelTitle

        anchors {
            top: parent.top; topMargin: UI.Theme.tutorialTitleMargins
            left: parent.left; leftMargin: UI.Theme.tutorialTitleMargins
            right: parent.right; rightMargin: UI.Theme.tutorialTitleMargins
        }

        font {
            pixelSize: UI.Theme.tutorialTitleFontSize
            weight: Font.Light
        }

        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        lineHeight: 0.85
        color: "#2d2d2d"
        text: qsTr("Welcome to Qt DevDays '15")
    }

    ListView {
        id: listViewTutorial

        anchors {
            top: labelTitle.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        clip: true
        orientation: ListView.Horizontal

        snapMode: ListView.SnapToItem

        highlightRangeMode: ListView.StrictlyEnforceRange

        model: ListModel {
            ListElement { description: "This schedule view allows you to quickly glance at all available sessions.\nSwipe left and right to navigate between days." }
            ListElement { description: "The session detail page can be accessed by clicking the session in the schedule view. This page describes the session in more detail. \n You can also bookmark this session using the ribbon on the top right of the page." }
            ListElement { description: "The session detail page can also present a short biography of each presenter - including their accomplishments and contributions to the Qt community." }
            ListElement { description: "We are open source! go to http://github.com/ndesai/qtworldsummit to get the source code, submit your pull request to contribute!" }
        }

        delegate: Item {
            width: ListView.view.width
            height: ListView.view.height

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top

                    margins: UI.Theme.tutorialContentMargin
                }

                font.pixelSize: UI.Theme.fontSizeSmall
                text: model.description
                color: "#4c4c4c"
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        color: "#eef3f3f3"

        height: UI.Theme.paginationDotContainerHeight

        PaginationDots {
            id: paginationDots

            anchors.horizontalCenter: parent.horizontalCenter

            view: listViewTutorial
        }

        Button {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            text: "Skip"

            style: ButtonStyle {
                background: Rectangle {
                    color: "#34db98"
                }
            }

            onClicked: root.skipTutorial()
        }
    }
}
