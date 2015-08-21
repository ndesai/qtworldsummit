import QtQuick 2.5
import utils 1.5

Item {
    id: root

    signal opened
    signal closed

    property alias controller: _Connections.target

    function show() {
        root.opened()
        visible = true
    }

    anchors.fill: parent

    visible: false

    ClickGuard { }

    Connections {
        id: _Connections

        target: null
        ignoreUnknownSignals: true

        onHideAllPages: {
            root.closed()
            root.visible = false
        }
    }
}
