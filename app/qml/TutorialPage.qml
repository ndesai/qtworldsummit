import QtQuick 2.5
import "qrc:/qml/qml/ui" 1.5 as UI

Rectangle {
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

        color: "#000000"
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        lineHeight: 0.85
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

        orientation: ListView.Horizontal

        snapMode: ListView.SnapToItem

        highlightRangeMode: ListView.StrictlyEnforceRange

        model: ListModel {
            ListElement { description: "This schedule view allows you to quickly glance at all available sessions.\nSwipe left and right to navigate between days." }
            ListElement { description: "This schedule view allows you to quickly glance at all available sessions.\nSwipe left and right to navigate between days." }
            ListElement { description: "This schedule view allows you to quickly glance at all available sessions.\nSwipe left and right to navigate between days." }
            ListElement { description: "This schedule view allows you to quickly glance at all available sessions.\nSwipe left and right to navigate between days." }
        }

        delegate: Text {
            width: ListView.view.width
            text: model.description
            wrapMode: Text.Wrap
        }
    }

    PaginationDots {
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        view: listViewTutorial
    }
}
