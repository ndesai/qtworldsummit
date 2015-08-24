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

    Rectangle {
        anchors.fill: parent
    }

    TabView {
        anchors.fill: parent

        style: TabViewStyle {
            tab: Rectangle {
                color: styleData.selected ? "#dedede" : "#ffffff"

                implicitWidth: Math.round(root.width / 3)
                implicitHeight: text.height + (Theme.spacing * 2)
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
                    text: styleData.title

                }
            }
        }

        Repeater {
            model: root.model

            delegate: Tab {
                title: modelData.title

                /// TODO: add ScrollView

                Item {
                    anchors.fill: parent

                    Rectangle {
                        anchors.fill: parent
                    }

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
    }
}
