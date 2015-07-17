pragma Singleton
import QtQuick 2.4
import QtWorldSummit 1.5

QtObject {
    property color activeTabColor: "#81c343"
    property color unactiveTabColor: "#f3f3f3"
    property color toolBarColor: "#ffffff"

    property int tabHeight: 38 * ScreenValues.dp
    property int toolBarHeight: 56 * ScreenValues.dp
}
