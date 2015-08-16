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
                    source: "qrc:/images/next_white"

                    sourceSize.width: parent.height * 0.34
                    sourceSize.height: parent.height * 0.34
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

                font {
                    pixelSize: UI.Theme.tutorialTitleFontSize
                    weight: Font.Light
                }

                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 0.85
                color: model.titleColor
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

                        x: (model.x * parent.width) + ((introView.view.contentX - itemDelegate.x) * model.multiplier)
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
                titleColor: "#ecf0f1"
                backgroundColor: "#2c3e50"
                textColor: "#cacaca"
                description: "Experience the future of application development & device creation."
                images: [
                    ListElement { source: "qrc:/images/tutorial_1"; multiplier: 0.3; width: 0.4; y: 0.28; x: 0.06},
                    ListElement { source: "qrc:/images/tutorial_2"; multiplier: 0.2; width: 0.45; y: 0.22; x: 0.18 },
                    ListElement { source: "qrc:/images/tutorial_4"; multiplier: 0.1; width: 0.5; y: 0.35; x: 0.25 },
                    ListElement { source: "qrc:/images/tutorial_3"; multiplier: 0.05; width: 0.35; y: 0.28; x: 0.53 }
                ]
            }

            ListElement {
                title: qsTr("Welcome to Qt DevDays '15")
                backgroundColor: "#c0392b"
                titleColor: "#ecf0f1"
                textColor: "#cacaca"
                description: "The session detail page can be accessed by clicking the session in the schedule view. This page describes the session in more detail. \n You can also bookmark this session using the ribbon on the top right of the page."
                images: [
                    ListElement { source: "qrc:/images/phone_1"; multiplier: 0.3; width: 0.4; y: 0.28; x: 0.06},
                    ListElement { source: "qrc:/images/phone_2"; multiplier: 0.2; width: 0.4; y: 0.22; x: 0.18 },
                    ListElement { source: "qrc:/images/phone_3"; multiplier: 0.1; width: 0.4; y: 0.35; x: 0.25 },
                    ListElement { source: "qrc:/images/laptop"; multiplier: 0.05; width: 0.45; y: 0.28; x: 0.53 }
                ]
            }

            ListElement {
                title: qsTr("Welcome to Qt DevDays '15")
                backgroundColor: "#f39c12"
                titleColor: "#2d2d2d"
                textColor: "#050505"
                description: "The session detail page can also present a short biography of each presenter - including their accomplishments and contributions to the Qt community."
                images: [
                    ListElement { source: "qrc:/images/phone_1"; multiplier: 0.3; width: 0.4; y: 0.28; x: 0.06},
                    ListElement { source: "qrc:/images/phone_2"; multiplier: 0.2; width: 0.45; y: 0.22; x: 0.18 },
                    ListElement { source: "qrc:/images/phone_3"; multiplier: 0.1; width: 0.5; y: 0.35; x: 0.25 },
                    ListElement { source: "qrc:/images/laptop"; multiplier: 0.05; width: 0.35; y: 0.28; x: 0.53 }
                ]
            }

            ListElement {
                backgroundColor: "#ecf0f1"
                titleColor: "#2d2d2d"
                title: qsTr("We are open source")
                textColor: "#050505"
                /// TODO: support hyperlink
                description: "Go to http://github.com/ndesai/qtworldsummit to get the source code, submit your pull request to contribute!"
                images: [
                    ListElement { source: "qrc:/images/tutorial_1"; multiplier: 0.3; width: 0.4; y: 0.3; x: 0.3},
                    ListElement { source: "qrc:/images/tutorial_2"; multiplier: 0.2; width: 0.3; y: 0.25; x: 0.4 },
                    ListElement { source: "qrc:/images/tutorial_4"; multiplier: 0.1; width: 0.5; y: 0.4; x: 0.5 },
                    ListElement { source: "qrc:/images/tutorial_3"; multiplier: 0.05; width: 0.25; y: 0.28; x: 0.35 }
                ]
            }
        }
    }
}
