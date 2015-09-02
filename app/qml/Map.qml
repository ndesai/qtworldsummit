import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import ui 1.5

Item {
    id: root

    property var model: [
        { "title" : "Level A", "source" : "qrc:/images/level_a.svg", "width" : 809, "height" : 1024 },
        { "title" : "Level B", "source" : "qrc:/images/level_b.svg", "width" : 838, "height" : 1024 },
        { "title" : "Level C", "source" : "qrc:/images/level_c.svg", "width" : 1024, "height" : 1024 }
    ]

    clip: true

    Rectangle {
        anchors.fill: parent
    }

    Row {
        id: rowTabs

        anchors {
            left: parent.left
            right: parent.right
        }

        Repeater {
            model: root.model

            delegate: Rectangle {
                color: listView.currentIndex === index ? "#00000000" : "#dedede"

                width: parent.width / 3
                height: text.height + (Theme.spacing * 2)

                Label {
                    id: text

                    anchors.fill: parent

                    font {
                        pixelSize: Theme.fontSizeLarge
                        weight: Font.Light
                    }

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#000000"
                    text: modelData.title
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: listView.positionViewAtIndex(index, ListView.Contain)
                }
            }
        }
    }

    ListView {
        id: listView

        anchors {
            top: rowTabs.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        orientation: ListView.Horizontal
        highlightRangeMode: ListView.StrictlyEnforceRange
        snapMode: ListView.SnapOneItem

        model: root.model

        delegate: Item {
            height: ListView.view.height
            width: ListView.view.width

            Image {
                id: image

                anchors {
                    fill: parent
                    margins: Theme.spacing
                }

                source: modelData.source
                smooth: true
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
