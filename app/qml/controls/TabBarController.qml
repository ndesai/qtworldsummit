import QtQuick 2.3
import "../utils/" as Utils
Item {
    id: root

    property bool enabled: true
    property variant tabBarModel: []
    property variant activeButton: _Repeater_TabBar.count > 0 ? _Repeater_TabBar.itemAt(0) : { }

    property alias theme: _BaseButtonTheme

    signal tabClicked(variant tabObject)
    signal hideAllPages

    function clickFirstTab() {
        if (_Repeater_TabBar.count > 0)
            _Repeater_TabBar.itemAt(0).clicked()
    }

    function showView(sourceComponent) {
        for (var i = 0; i < _Repeater_TabBar.count; i++) {
            var obj = _Repeater_TabBar.itemAt(i)
            if (obj.dataModel.sourceComponent === sourceComponent) {
                _Repeater_TabBar.itemAt(i).clicked()
            }
        }
    }

    Utils.BaseButtonTheme {
        id: _BaseButtonTheme
        backgroundDefaultColor: "#eeeeee"
        backgroundPressedColor: "#dddddd"
        backgroundActiveColor: "#80c342"
        iconDefaultColor: "#80c342"
        iconPressedColor: "#6aa336"
        iconActiveColor: "#ffffff"
        borderColor: "transparent"
    }

    Row {
        id: _Row_TabBar

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        height: 100

        Repeater {
            id: _Repeater_TabBar

            property variant responder: root.activeButton

            model: root.tabBarModel

            delegate: TabBarButton {
                property variant dataModel: modelData

                width: Math.floor(root.width / root.tabBarModel.length)
                icon: modelData.icon
                onClicked: {
                    root.tabClicked(modelData)
                    root.activeButton = this
                    root.hideAllPages()
                    eval(modelData.sourceComponent).show()
                }
            }

            Component.onCompleted: {
                if (count > 0)
                    itemAt(0).clicked()
            }
        }
    }

    Utils.ClickGuard {
        visible: !root.enabled
    }
}
