import QtQuick 2.5
import QtQuick.Window 2.2

import "ui"
import "utils" as Utils

Viewport {
    id: root

    property Theme __theme: Theme { id: theme }
    property Api __api: Api { }
    property DateTimeController __dateTimeController: DateTimeController { }

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
            anchors.leftMargin: __theme.dp(16)
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: __theme.logoVerticalCenterOffset
            width: __theme.dp(285)

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
                    __dateTimeController.showToday();
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

            Image {
                id: _imageLoadingIcon
                anchors.centerIn: parent
                visible: !_loaderMainContent.active
                source: "img/loading-icon.png"
                width: __theme.dp(120)

                fillMode: Image.PreserveAspectFit

                RotationAnimator {
                    target: _imageLoadingIcon;
                    duration: 1000
                    from: 0
                    to: 360
                    running: visible
                    loops: Animation.Infinite
                }
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
