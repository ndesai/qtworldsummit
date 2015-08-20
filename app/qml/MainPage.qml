import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtWorldSummit 1.5
import "qrc:/qml/qml/ui" 1.5 as UI
import "."

FocusScope {
    ToolBar {
        id: toolbar

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
    }

    StackView {
        anchors {
            left: parent.left
            right: parent.right
            top: toolbar.bottom
            bottom: rowTabs.top
        }
    }

    RowLayout {
        id: rowTabs

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        height: UI.Theme.tabHeight
        spacing: 0

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true

            checkable: true
            checked: true
            exclusiveGroup: group

            style: TabButtonStyle {
                imageSource: "qrc:/images/home" + (control.checked ? "_active" : "") + ".svg"
            }
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true

            checkable: true
            exclusiveGroup: group

            style: TabButtonStyle {
                imageSource: "qrc:/images/location" + (control.checked ? "_active" : "") + ".svg"
            }
        }

        Button {
            Layout.fillWidth: true
            Layout.fillHeight: true

            checkable: true
            exclusiveGroup: group

            style: TabButtonStyle {
                imageSource: "qrc:/images/info" + (control.checked ? "_active" : "") + ".svg"
            }
        }
    }

    ExclusiveGroup {
        id: group
    }
}
