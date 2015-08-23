import QtQuick 2.5
import QtQuick.Controls 1.4
import ui 1.5

ScrollView {
    flickableItem.focus: true
    flickableItem.interactive: true

    Flickable {
        anchors.fill: parent

        contentHeight: columnContainer.height

        Column {
            id: columnContainer

            anchors {
                left: parent.left; leftMargin: parent.width * 0.05
                right: parent.right; rightMargin: parent.width * 0.05
            }

            Item { height: Theme.spacing; width: 1 }

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                text: qsTr("Qt World Summit 2015")
                font.pixelSize: Theme.fontSizeLarge
                wrapMode: Text.Wrap
            }

            Item { height: Theme.spacing; width: 1 }

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                text: qsTr("October 5-7")

                font {
                    pixelSize: Theme.fontSizeRegular
                    weight: Font.Light
                }

                wrapMode: Text.Wrap
            }

            Item { height: Theme.spacing * 2; width: 1 }

            Image {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                source: "qrc:/images/qws2015-hero.jpg"
                fillMode: Image.PreserveAspectFit
            }

            Item { height: Theme.spacing * 2; width: 1 }

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                text: qsTr("Berlin Congress Center")

                font {
                    pixelSize: Theme.fontSizeLarge
                    weight: Font.Light
                }

                wrapMode: Text.Wrap
            }

            Item { height: Theme.spacing * 2; width: 1 }

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                text: qsTr("Qt World Summit, hosted by The Qt Company, is the global event for all things Qt. Whether you are a technology director, business decision maker, tech strategist, product manager, engineer or developer there is something here for you.")

                font {
                    pixelSize: Theme.fontSizeRegular
                    weight: Font.Light
                }

                wrapMode: Text.Wrap
            }
        }
    }
}
