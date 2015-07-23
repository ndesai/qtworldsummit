import QtQuick 2.3
import "../utils"

Item {
    id: root
    signal opened
    signal closed

    property alias controller : _Connections.target

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
    function show()
    {
        root.opened()
        visible = true
    }
}
