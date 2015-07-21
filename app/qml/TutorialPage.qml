import QtQuick 2.5
import "qrc:/qml/qml/ui" 1.5 as UI

Rectangle {
    Label {
        anchors {
            top: parent.top; topMargin: 100
            left: parent.left; leftMargin: 100
            right: parent.right; rightMargin: 100
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
}
