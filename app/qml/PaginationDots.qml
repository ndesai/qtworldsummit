import QtQuick 2.5
import "qrc:/qml/qml/ui" 1.5 as UI

Row {
    id: root

    property ListView view
    property color color: "#34db98"
    property color activeColor: "#3498db"

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

                color: index === root.view.currentIndex ? root.activeColor : root.color
            }
        }
    }
}
