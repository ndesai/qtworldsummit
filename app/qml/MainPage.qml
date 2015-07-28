import QtQuick 2.5
import QtQuick.Controls 1.4 as QC
import QtQuick.Layouts 1.1 as LA
import QtWorldSummit 1.5
import "qrc:/qml/qml/ui" 1.5 as UI

FocusScope {
    ToolBar {
        anchors {
            left: parent.left
            right: parent.right
        }
    }

    LA.RowLayout {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        height: UI.Theme.tabHeight
        spacing: 0

        QC.Button {
            LA.Layout.fillWidth: true
            LA.Layout.fillHeight: true

            checkable: true
            checked: true
            exclusiveGroup: group

            style: TabButtonStyle {
                imageSource: "qrc:/images/home" + (control.checked ? "_active" : "") + ".svg"
            }
        }

        QC.Button {
            LA.Layout.fillWidth: true
            LA.Layout.fillHeight: true

            checkable: true
            exclusiveGroup: group

            style: TabButtonStyle {
                imageSource: "qrc:/images/location" + (control.checked ? "_active" : "") + ".svg"
            }
        }

        QC.Button {
            LA.Layout.fillWidth: true
            LA.Layout.fillHeight: true

            checkable: true
            exclusiveGroup: group

            style: TabButtonStyle {
                imageSource: "qrc:/images/info" + (control.checked ? "_active" : "") + ".svg"
            }
        }
    }

    QC.ExclusiveGroup {
        id: group
    }
}
