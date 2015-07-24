pragma Singleton
import QtQuick 2.5
import QtWorldSummit 1.5

QtObject {
    property color activeTabColor: "#81c343"
    property color unactiveTabColor: "#f3f3f3"
    property color toolBarColor: "#ffffff"
    property color toolBarTextColor: "#bdbebf"

    property string fontFamily: "Roboto"

    property int paginationDotBaseSize: 14 * ScreenValues.dp
    property int tabHeight: 38 * ScreenValues.dp
    property int toolBarHeight: 56 * ScreenValues.dp
    property int tutorialTitleFontSize: 28 * ScreenValues.dp
    property int tutorialTitleMargins: 32 * ScreenValues.dp
    property int tutorialContentMargin: 18 * ScreenValues.dp
    property int fontSizeSmall: 14 * ScreenValues.dp
    property int fontSizeRegular: 18 * ScreenValues.dp
    property int fontSizeLarge: 22 * ScreenValues.dp
}
