import QtQuick 2.4
import QtQuick.Window 2.2
import "ui"
import "utils" as Utils

Viewport {
    id: root

    property Theme __theme: Theme { }

    width: 1080
    height: 1920
    color: "#000000"

    // TODO: Platform dependent status bar height
    topMargin: __theme.dp(40)

    children: [
        Image {
            id: _imageBackground
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop

            source: "qrc:/images/bg.jpg"
        }
    ]


    Row {
        id: _rowHeader
        anchors.horizontalCenter: parent.horizontalCenter
        height: __theme.dp(50)
        Label {
            id: _labelTitle
            anchors.verticalCenter: parent.verticalCenter
            color: "#ffffff"

            text: qsTr("QtWorldSummit")
        }

        Utils.HorizontalSpacer {
            width: __theme.dp(22)
        }

        Image {
            source: "qrc:/images/arrow-down.png"
            anchors.verticalCenter: _labelTitle.verticalCenter

            transformOrigin: Item.Center
            rotation: _imageCard.level > 1 ? 180 : 0

            Behavior on rotation {
                NumberAnimation { duration: 120 }
            }
        }
    }


    MouseArea {
        anchors.fill: _rowHeader
        anchors.margins: __theme.dp(-30)
        onClicked: {
            _imageCard.level = _imageCard.level === 1 ? 2 : 1
        }
    }


    Row {
        anchors.top: _rowHeader.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            model: 4
            delegate: Item {
                width: 160
                height: width

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        _rectangleCircular.state = "large";
                        _imageCard.levelChangeDelayed(1);
                    }
                }

                Rectangle {
                    id: _rectangleCircular

                    Timer {
                        id: _timerResetState
                        interval: 100
                        onTriggered: {
                            _rectangleCircular.state = "hidden"
                        }
                    }

                    anchors.centerIn: parent
                    width: 140
                    height: width
                    radius: width / 2
                    transformOrigin: Item.Center

                    color: Qt.darker(__theme.colorQtGreen)

                    opacity: 0.25

                    state: "hidden"
                    states: [
                        State {
                            name: "hidden"
                            PropertyChanges {
                                target: _rectangleCircular
                                scale: 0
                                opacity: 0
                            }
                        },
                        State {
                            name: "large"
                            PropertyChanges {
                                target: _rectangleCircular
                                scale: 1.0
                                opacity: 0
                            }
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "hidden"
                            to: "large"
                            SequentialAnimation {
                                ParallelAnimation {
                                    NumberAnimation {
                                        target: _rectangleCircular
                                        property: "scale"
                                        duration: 1000
                                        from: 0.25; to: 1.0
                                        easing.type: Easing.OutBack
                                    }
                                    SequentialAnimation {
                                        NumberAnimation {
                                            target: _rectangleCircular
                                            property: "opacity"
                                            duration: 400
                                            from: 0; to: 0.15
                                            easing.type: Easing.OutBack
                                        }
                                        NumberAnimation {
                                            target: _rectangleCircular
                                            property: "opacity"
                                            duration: 600
                                            from: 0.15; to: 0
                                            easing.type: Easing.OutBack
                                        }
                                    }
                                }
                                ScriptAction {
                                    script: _timerResetState.restart()
                                }
                            }

                        }
                    ]
                }

                Image {
                    anchors.centerIn: parent
                    width: 72
                    fillMode: Image.PreserveAspectFit
                    smooth: true

                    source: "qrc:/images/icon-calendar.png"
                }
            }
        }
    }

    BorderImage {
        id: _imageCard

        property int level: 1

        function levelChangeDelayed(level) {
            _timerLevelChangeDelayed.tempLevel = level;
            _timerLevelChangeDelayed.restart();
        }

        Timer {
            id: _timerLevelChangeDelayed
            property int tempLevel: 1
            interval: 350
            onTriggered: parent.level = tempLevel
        }

        anchors.top: parent.top
        anchors.topMargin: 30 + level*100
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: __theme.dp(12)
        anchors.rightMargin: anchors.leftMargin
        anchors.bottom: parent.bottom

        Behavior on anchors.topMargin {
            SequentialAnimation {
                NumberAnimation { easing.type: Easing.OutBack }
            }
        }


        source: "qrc:/images/card.png"

        border {
            left: __theme.dp(20)
            right: __theme.dp(20)
            top: __theme.dp(20)
            bottom: __theme.dp(20)
        }
    }
}
