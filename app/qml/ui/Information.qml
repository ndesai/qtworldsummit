import QtQuick 2.0
import "../controls"
import "../utils" as Utils

BaseTabBarPage {
    id: root

    Flickable {
        id: _Flickable
        anchors.fill: parent
        contentHeight: _column.height + 40
        contentWidth: width

        Column {
            id: _column
            anchors.left: parent.left
            anchors.leftMargin: __theme.dp(40)
            anchors.rightMargin: anchors.leftMargin
            anchors.right: parent.right

            Utils.VerticalSpacer {
                height: __theme.dp(40)
            }

            Item {
                width: parent.width
                height: __theme.dp(240)
                clip: true
                // parallax effect while scrolling
                Image {
                    id: _Image_Venue
                    width: parent.width
                    height: parent.height
                    clip: true
                    fillMode: Image.PreserveAspectCrop
                    source:  "../img/qws2015-hero.jpg"
                    y: Math.min((sourceSize.height - 240) / 2, 0.07*_Flickable.contentY)
                }


                Column {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    Label {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        font.pixelSize: __theme.dp(42)
                        color: __theme.colorPageBackground
                        horizontalAlignment: Text.AlignHCenter
                        font.weight: Font.DemiBold

                        text: qsTr("Qt World Summit 2015")
                    }

                    Label {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        font.pixelSize: __theme.dp(36)
                        color: __theme.colorPageBackground
                        horizontalAlignment: Text.AlignHCenter
                        font.weight: Font.DemiBold

                        text: qsTr("October 5 - 7, Berlin")
                    }
                }
            }

            Utils.VerticalSpacer { height: __theme.dp(30) }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: __theme.dp(32)
                font.weight: Font.DemiBold

                text: qsTr("About this Event")
            }

            Utils.VerticalSpacer { height: __theme.dp(20) }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: __theme.dp(28)
                wrapMode: Text.WordWrap

                text: "Over the last year, the Qt open source community and its commercial partners have been reunited under one roof, qt.io, making Qt stronger than ever.

With that being said, it’s time to kick-off this new era with a transformation of Qt Developer Days. Say hello to the Qt World Summit for technology business managers and developers alike.

You can expect the same greatness you’ve experienced in our past events, but now with a more unified and integrated approach covering business strategy and the code behind it.

You will learn first-hand how Qt supports your entire technology strategy and can be quickly adapted to future application development and device creation trends.

This is the place to be to get hands-on training from Qt experts, see amazing projects that others are building and deploying with Qt, have your dev questions answered, and network with The Qt Company team as well as other community members.

Get the scoop on the Qt product roadmap and a sneak peek at upcoming releases
Listen to inspiring keynotes by industry leaders and get advice for your technology strategy and of course hands-on training from Qt experts
Ask the creators of Qt, at the Qt Support Desk, for help on your most challenging development issues
Experience the Network Lounge where you can see awesome demos and discuss Qt solutions with our broad network of Qt partners and event sponsors
Network with The Qt Company team, developers and industry experts from across the world"
            }

            Utils.ColumnDivider {
                topSpacer: __theme.dp(30)
            }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: __theme.dp(32)
                font.weight: Font.DemiBold

                text: qsTr("About this App")
            }

            Utils.VerticalSpacer { height: __theme.dp(20) }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: __theme.dp(28)
                wrapMode: Text.WordWrap

                text: qsTr("This application is built entirely in Qt and QML. It has also been fully open-sourced. \n\nSee more information: http://app.st/qws15\n\nQt® is a registered trademark of The Qt Company and/or its subsidiaries. AppStreet is in no way affiliated with the The Qt Company, QtProject, Digia, ICS, or KDAB.")
            }

            Utils.VerticalSpacer { height: __theme.dp(120) }

            Image {
                id: _imageLogo
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../img/logo-appstreet.png"
                width: __theme.dp(200)
                fillMode: Image.PreserveAspectFit
                smooth: true

                SequentialAnimation {
                    id: _animation
                    NumberAnimation {
                        target: _imageLogo
                        property: "scale"
                        from: 1.0
                        to: 1.05

                        duration: 450
                        easing.type: Easing.OutBack
                    }
                }

                MouseArea {
                    property int count: 0
                    anchors.fill: parent
                    onClicked: {
                        count++
                        _timerResetCount.restart();

                        if (count >= 6) {
                            _animation.restart();
                            count = 0;
                        }
                    }
                    Timer {
                        id: _timerResetCount
                        interval: 5000
                        onTriggered: parent.count = 0;
                    }
                }
            }

            Utils.VerticalSpacer { height: __theme.dp(14) }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: __theme.dp(28)
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter

                text: qsTr("Need an app? Contact us at mail@app.st")
            }
        }
    }
}
