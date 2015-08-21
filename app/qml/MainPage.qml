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

    Header {
        id: _header
        z: 2

        Image {
            id: _imageLogo

            anchors {
                left: parent.left; leftMargin: UI.Theme.dp(20)
                verticalCenter: parent.verticalCenter; verticalCenterOffset: UI.Theme.dp(-4)
            }

            width: UI.Theme.dp(156)

            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "img/logo-qws.png"
        }
    }

    StackView {
        id: stackView

        property string currentView: "schedule"

        anchors {
            left: parent.left
            right: parent.right
            top: toolbar.bottom
            bottom: rowTabs.top
        }

        initialItem: schedule
    }

    Component {
        id: schedule

        Schedule { }
    }


    Component {
        id: map

        Rectangle { color: "#3498db" }
    }

    Component {
        id: information

        Rectangle { color: "#34db98" }
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

            onClicked: {
                if (stackView.currentView !== "schedule") {
                    stackView.currentView = "schedule"
                    stackView.replace(schedule)
                }
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

            onClicked: {
                if (stackView.currentView !== "map") {
                    stackView.currentView = "map"
                    stackView.replace(map)
                }
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

            onClicked: {
                if (stackView.currentView !== "information") {
                    stackView.currentView = "information"
                    stackView.replace(information)
                }
            }
        }
    }

    ExclusiveGroup {
        id: group
    }

    TrackDetailSheet {
        id: _trackDetailSheet
        z: 3
    }
}
