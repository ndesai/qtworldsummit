pragma Singleton
import QtQuick 2.5
import QtWorldSummit 1.5

QtObject {
    property color activeTabColor: "#81c343"
    property color unactiveTabColor: "#f3f3f3"
    property color toolBarColor: "#ffffff"
    property color toolBarTextColor: "#bdbebf"

    property string fontFamily: "Roboto"

    property int tabHeight: 38 * ScreenValues.dp
    property int toolBarHeight: 56 * ScreenValues.dp
    property int tutorialTitleFontSize: 28 * ScreenValues.dp
}
