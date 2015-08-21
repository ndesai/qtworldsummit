import QtQuick 2.4
import QtQuick.Window 2.2
import ui 1.5 as UI
import utils 1.5 as Utils
import ui 1.5

Viewport {
    id: root

    property Api __api: Api { }

    width: 1080
    height: 1920
    color: "#000000"

    // TODO: Platform dependent status bar height
    topMargin: UI.Theme.marginTop

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
            source: "qrc:/images/logo-qws.png"
        }

        RightNowIcon {
            id: _RightNowIcon

            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right; rightMargin: UI.Theme.dp(24)
            }

            Utils.ClickGuard {
                anchors {
                    fill: parent
                    margins: UI.Theme.dp(-10)
                }

                Utils.Fill { color: "blue" }
                onClicked: {
                    // TODO: ND - Show today's schedule
                }
            }
        }
    }

    Item {
        id: _itemPageContainer

        anchors {
            top: _header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        clip: true

        Rectangle {
            anchors.fill: parent
            color: UI.Theme.colorPageBackground

            Loader {
                id: _loaderMainContent
                anchors.fill: parent
                active: __api.status === Loader.Ready
                sourceComponent: Component {
                    Content { }
                }
            }

            AnimatedImage {
                anchors.centerIn: parent
                playing: visible
                visible: !_loaderMainContent.active
                source: "qrc:/images/icon-qtloading.gif"
            }
        }
    }

    Rectangle {
        id: _rectangleDarkener
        anchors.fill: parent
        color: "#000000"
        opacity: 0.65 - (_trackDetailSheet.x / width)
        z: _trackDetailSheet.z
    }

    TrackDetailSheet {
        id: _trackDetailSheet
        z: 3
    }
}
