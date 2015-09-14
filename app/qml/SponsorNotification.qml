import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import ui 1.5
import QtWorldSummit 1.5

Rectangle {
    id: root

    property alias title: labelTitle.text
    property alias message: labelMessage.text
    property alias imageSource: image.source

    property bool isOpen: opacity === 1

    function close() {
        opacity = 0
    }

    function open() {
        opacity = 1
    }

    opacity: 0

    Behavior on opacity { NumberAnimation { easing.type: Easing.OutQuad } }

    ScrollView {
        anchors {
            fill: parent
            margins: Theme.spacing
        }

        enabled: root.isOpen

        Flickable {
            anchors.fill: parent

            contentHeight: column.height

            enabled: root.isOpen


            Column {
                id: column

                anchors {
                    left: parent.left
                    right: parent.right
                }

                Item {
                    height: 48 * ScreenValues.dp
                    width: parent.width

                    MouseArea {
                        anchors.right: parent.right

                        height: 48 * ScreenValues.dp
                        width: 48 * ScreenValues.dp

                        enabled: root.isOpen

                        onClicked: root.close()

                        Image {
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/images/close.png"
                        }
                    }
                }

                Item { height: Theme.spacing * 2; width: 1 }

                Label {
                    id: labelTitle

                    width: parent.width

                    font.pixelSize: Theme.fontSizeLarge
                    wrapMode: Text.Wrap
                    color: Theme.fontColor
                }

                Item { height: Theme.spacing * 2; width: 1 }

                Image {
                    id: image

                    mipmap: true
                    width: parent.width

                    fillMode: Image.PreserveAspectFit

                    sourceSize.width: parent.width
                }

                Item { height: Theme.spacing * 2; width: 1 }

                Label {
                    id: labelMessage

                    width: parent.width

                    font.pixelSize: Theme.fontSizeLarge
                    wrapMode: Text.Wrap
                    color: Theme.fontColor
                }
            }
        }
    }

    BusyIndicator {
        anchors.centerIn: parent

        running: image.status === Image.Loading

        style: BusyIndicatorStyle {
            indicator: Image {
                visible: control.running
                source: "qrc:/images/busyindicator.png"
                RotationAnimator on rotation {
                    running: control.running
                    loops: Animation.Infinite
                    duration: 2000
                    from: 0 ; to: 360
                }
            }
        }
    }
}
