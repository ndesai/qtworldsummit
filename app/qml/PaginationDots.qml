import QtQuick 2.5

Row {
    id: root

    property ListView view
    property color color: "#34db98"

    Repeater {
        model: root.view.count

        delegate: Item {
            height: 30
            width: 30

            Rectangle {
                id: rectangleIndicator

                anchors.centerIn: parent

                height: 8
                width: height
                radius: height

                color: root.color

                state: index === root.view.currentIndex ? "active" : ""

                states: [
                    State {
                        name: "active"
                        PropertyChanges {
                            target: rectangleIndicator
                            height: 20
                        }
                    }
                ]

                transitions: Transition {
                    NumberAnimation { target: rectangleIndicator; properties: "width,height"; easing.type: Easing.OutInQuad; duration: 250 }
                }
            }
        }
    }
}
