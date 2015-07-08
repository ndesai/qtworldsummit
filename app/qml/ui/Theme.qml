pragma Singleton
import QtQuick 2.5

QtObject {
    property color activeTabColor: "#81c343"
    property color unactiveTabColor: "#f3f3f3"
    property color toolBarColor: "#ffffff"
    property color toolBarTextColor: "#bdbebf"
    property color colorQtGreen: "#81C343"
    property color colorLightGrey: "#f3f3f3"
    property color colorLightGreyAccent: "#d1d1d0"
    property color colorQtMediumGreen: "#5c9c1c"
    property color colorPageBackground: "#ffffff"

    property string fontFamily: "Avenir Next"

    property int heightHeader: 128
    property int marginTop: 40

    property int paginationDotBaseSize: 30
    property int paginationDotContainerHeight: 56
    property int dividerHeight: 1
    property int tabHeight: 98
    property int toolBarHeight: 56
    property int tutorialDescriptionFontSize: 26
    property int tutorialTitleFontSize: 34
    property int tutorialTitleMargins: 28
    property int tutorialDescriptionMargins: 28
    property int tutorialContentMargin: 22
    property int fontSizeSmall: 14
    property int fontSizeRegular: 18
    property int fontSizeLarge: 22
}
