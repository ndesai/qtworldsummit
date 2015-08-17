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
        rectangleDividerHeight: UI.Theme.dividerHeight

        buttons: Item {
            anchors.fill: parent

            Item {
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                }

                width: parent.width * 0.25

                Image {
                    anchors.centerIn: parent

                    height: parent.height * 0.34
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/images/next_white.svg"

                    sourceSize.width: parent.height * 0.34
                    sourceSize.height: parent.height * 0.34
                    opacity: 0.65
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: introView.incrementCurrentIndex()
                }
            }
        }

        delegate: Item {
            id: itemDelegate

            clip: true

            property var dataModel: model

            height: introView.view.height
            width: introView.view.width

            Label {
                id: labelTitle

                anchors {
                    top: parent.top; topMargin: UI.Theme.tutorialTitleMargins
                    left: parent.left; leftMargin: UI.Theme.tutorialTitleMargins
                    right: parent.right; rightMargin: UI.Theme.tutorialTitleMargins
                }

                font.pixelSize: UI.Theme.tutorialTitleFontSize

                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 0.85
                color: model.textColor
                text: model.title
            }

            Item {
                anchors {
                    top: labelTitle.bottom
                    bottom: labelDescription.top
                    left: parent.left
                    right: parent.right
                    margins: UI.Theme.tutorialContentMargin
                }

                clip: true

                Repeater {
                    model: itemDelegate.dataModel.images

                    delegate: Image {
                        property point center: Qt.point(((parent.width / 2) - (width / 2)), ((parent.height / 2) - (height / 2)))

                        source: model.source
                        fillMode: Image.PreserveAspectFit
                        width: parent.width * model.width

                        sourceSize.width: width

                        x: (model.x * parent.width) + ((introView.view.contentX - itemDelegate.x) * model.multiplier) - (width / 2)
                        y: model.y * parent.height
                    }
                }
            }

            Label {
                id: labelDescription

                text: model.description

                anchors {
                    bottom: parent.bottom; bottomMargin: UI.Theme.tutorialTitleMargins
                    left: parent.left; leftMargin: UI.Theme.tutorialTitleMargins
                    right: parent.right; rightMargin: UI.Theme.tutorialTitleMargins
                }

                font {
                    pixelSize: UI.Theme.tutorialDescriptionFontSize
                    weight: Font.Light
                }

                wrapMode: Text.WordWrap

                lineHeight: 0.85
                color: model.textColor
            }
        }

        model: ListModel {
            ListElement {
                title: qsTr("Welcome to Qt World Summit 2015")
                backgroundColor: "#2c3e50"
                textColor: "#BFC4CA"
                description: "Experience the future of application development & device creation."
                images: [
                    ListElement { source: "qrc:/images/cloud_1.svg"; multiplier: 0.3; width: 0.4; y: 0.28; x: 0.26},
                    ListElement { source: "qrc:/images/cloud_2.svg"; multiplier: 0.2; width: 0.45; y: 0.22; x: 0.48 },
                    ListElement { source: "qrc:/images/berlin.svg"; multiplier: 0.1; width: 0.10; y: 0.35; x: 0.5 },
                    ListElement { source: "qrc:/images/cloud_3.svg"; multiplier: 0.05; width: 0.35; y: 0.28; x: 0.73 }
                ]
            }

            ListElement {
                title: qsTr("Keep track of your sessions.")
                backgroundColor: "#be5a38"
                textColor: "#EBCDC3"
                description: "Qt World Summit 2015 helps you to keep track of all those awesome talks."
                images: [
                    ListElement { source: "qrc:/images/cloud_1.svg"; multiplier: 0.3; width: 0.4; y: 0.28; x: 0.06},
                    ListElement { source: "qrc:/images/cloud_2.svg"; multiplier: 0.2; width: 0.45; y: 0.22; x: 0.18 },
                    ListElement { source: "qrc:/images/cloud_3.svg"; multiplier: 0.1; width: 0.5; y: 0.35; x: 0.25 },
                    ListElement { source: "qrc:/images/laptop.svg"; multiplier: 0.05; width: 0.35; y: 0.28; x: 0.53 }
                ]
            }


            ListElement {
                title: qsTr("Write your source code once, run it anywhere on any device.")
                backgroundColor: "#533747"
                textColor: "#CBC2C7"
                description: "Qt is the leading independent technology for cross-platform development."
                images: [
                    ListElement { source: "qrc:/images/qt_logo.svg"; multiplier: 0.25; width: 0.45; y: 0.28; x: 0.5 }
                ]
            }

            ListElement {
                backgroundColor: "#4F7CAC"
                title: qsTr("We are open source")
                textColor: "#CAD7E6"
                /// TODO: support hyperlink
                description: "Go to http://github.com/ndesai/qtworldsummit to get the source code, submit your pull request to contribute!"
                images: [
                    ListElement { source: "qrc:/images/cloud_1.svg"; multiplier: 0.3; width: 0.4; y: 0.3; x: 0.3},
                    ListElement { source: "qrc:/images/cloud_2.svg"; multiplier: 0.2; width: 0.3; y: 0.25; x: 0.4 },
                    ListElement { source: "qrc:/images/cloud_3.svg"; multiplier: 0.1; width: 0.5; y: 0.4; x: 0.5 },
                    ListElement { source: "qrc:/images/cloud_3.svg"; multiplier: 0.05; width: 0.25; y: 0.28; x: 0.35 }
                ]
            }
        }
    }
}
