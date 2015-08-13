import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import "qrc:/qml/qml/ui" 1.5 as UI

Rectangle {
    id: root

    signal skipTutorial

    IntroView {
        id: introView

        anchors.fill: parent

        buttonsContainerHeight: UI.Theme.paginationDotContainerHeight
        rectangleDividerHeight: UI.Theme

        delegate: Item {
            height: introView.view.height
            width: introView.view.width

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
                color: model.titleColor
                text: model.title
            }
        }

        model: ListModel {
            ListElement { backgroundColor: "#2c3e50"; titleColor: "#ecf0f1"; title: qsTr("Welcome to Qt DevDays '15"); description: "This schedule view allows you to quickly glance at all available sessions.\nSwipe left and right to navigate between days." }
            ListElement { backgroundColor: "#e74c3c"; titleColor: "#ecf0f1"; title: qsTr("Welcome to Qt DevDays '15"); description: "The session detail page can be accessed by clicking the session in the schedule view. This page describes the session in more detail. \n You can also bookmark this session using the ribbon on the top right of the page." }
            ListElement { backgroundColor: "#f1c40f"; titleColor: "#2d2d2d"; title: qsTr("Welcome to Qt DevDays '15"); description: "The session detail page can also present a short biography of each presenter - including their accomplishments and contributions to the Qt community." }
            ListElement { backgroundColor: "#ecf0f1"; titleColor: "#2d2d2d"; title: qsTr("We are open source"); description: "go to http://github.com/ndesai/qtworldsummit to get the source code, submit your pull request to contribute!" }
        }
    }
}
