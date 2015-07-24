import QtQuick 2.5
import "qrc:/qml/qml/ui" 1.5 as UI

Row {
    id: root

    property ListView view
    property color color: "#34db98"

    Repeater {
        model: root.view.count

        delegate: Item {
            height: UI.Theme.paginationDotBaseSize
            width: UI.Theme.paginationDotBaseSize

            Rectangle {
                id: rectangleIndicator

                anchors.centerIn: parent

                height: Math.round(UI.Theme.paginationDotBaseSize * 0.30)
                width: height
                radius: height

                color: root.color

                state: index === root.view.currentIndex ? "active" : ""

                states: [
                    State {
                        name: "active"
                        PropertyChanges {
                            target: rectangleIndicator
                            height: Math.round(UI.Theme.paginationDotBaseSize * 0.66)
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
