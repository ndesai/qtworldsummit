import QtQuick 2.4
import QtQuick.Window 2.2

import "ui"
import "utils" as Utils

Viewport {
    id: root

    property Theme __theme: Theme { id: theme }
    property Api __api: Api { }

    width: 1080
    height: 1920
    color: "#000000"

    // TODO: Platform dependent status bar height
    topMargin: __theme.marginTop

    Header {
        id: _header
        z: 2

        Image {
            id: _imageLogo

            anchors.left: parent.left
            anchors.leftMargin: __theme.dp(20)
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: __theme.dp(-4)
            width: __theme.dp(156)

            fillMode: Image.PreserveAspectFit
            smooth: true
            source: "img/logo-qws.png"
        }

        RightNowIcon {
            id: _RightNowIcon

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: __theme.dp(24)

            Utils.ClickGuard {
                anchors.fill: parent
                anchors.margins: __theme.dp(-10)
                Utils.Fill { color: "blue" }
                onClicked: {
                    // TODO: ND - Show today's schedule
                }
            }
        }
    }

    Item {
        id: _itemPageContainer
        anchors.top: _header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        clip: true

        Rectangle {
            anchors.fill: parent
            color: __theme.colorPageBackground

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
                source: "img/icon-qtloading.gif"
            }
        }
    }
}
