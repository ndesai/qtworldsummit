import QtQuick 2.5
import ui 1.5 as UI

Rectangle {
    color: UI.Theme.toolBarColor

    height: UI.Theme.toolBarHeight

    Row {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left; leftMargin: UI.Theme.headerMargin
        }

        spacing: UI.Theme.spacing

        Image {
            anchors.verticalCenter: parent.verticalCenter

            height: parent.height * 0.8

            sourceSize.height: parent.height * 0.8

            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/qt_logo.svg"
            mipmap: true
        }

        Label {
            anchors.verticalCenter: parent.verticalCenter

            color: "#000000"
            text: "WORLD\nSUMMIT"
        }
    }

    Image {
        anchors {
            right: parent.right; rightMargin: 4
            verticalCenter: parent.verticalCenter
        }

        height: parent.height * 0.52
        width: parent.height * 0.52

        sourceSize.height: parent.height * 0.52
        sourceSize.width: parent.height * 0.52

        source: "qrc:/images/favorite.svg"
        visible: false
    }
}
