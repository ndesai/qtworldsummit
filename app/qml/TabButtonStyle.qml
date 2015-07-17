import QtQuick 2.4
import QtQuick.Controls.Styles 1.3 as CS
import "qrc:/qml/qml/ui" 1.5 as UI

CS.ButtonStyle {
    background: Rectangle {
        color: control.checked ? UI.Theme.activeTabColor : UI.Theme.unactiveTabColor
    }
}
