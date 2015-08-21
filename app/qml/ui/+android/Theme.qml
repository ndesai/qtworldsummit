pragma Singleton
import QtQuick 2.5
import QtWorldSummit 1.5

QtObject {
    id: root

    function randomTrackColor() {
        var keys = Object.keys(root).filter(function(e) { return (e.indexOf("colorTrack") > -1 && e.indexOf("Changed") === -1)});
        return root[keys[Math.floor(Math.random()*keys.length)]];
    }

    property int heightHeader: dp(128)
    property int marginTop: dp(40)

    property int dateViewHeight: dp(100)
    property int dateViewPixelSize: dp(34)

    property int scheduleViewPixelSize: dp(36)
    property int scheduleViewTitlePixelSize: dp(34)
    property int scheduleViewTrackNamePixelSize : dp(22)
    property int scheduleViewPresenterPixelSize : dp(30)

    property int colorIndicatorWidth: dp(10)
    property int colorIndicatorBorderWidth: dp(2)

    property int detailDatePixelSize: dp(28)
    property int detailPixelSize: dp(52)
    property int detailTrackNamePixelSize: dp(36)
    property int detailTitlePixelSize: dp(40)
    property int detailAbstractPixelSize: dp(32)
    property int detailPresenterNamePixelSize: dp(36)
    property int detailPresenterOrganizationPixelSize: dp(30)

    property int informationAddressPixelSize: dp(32)
    property int informationTitlePixelSize: dp(36)
    property int informationDatePixelSize: dp(34)
    property int informationVenueDescriptionPixelSize: dp(28)

    property var activeObject
    property bool showFills: false

    property color activeTabColor: "#81c343"
    property color unactiveTabColor: "#f3f3f3"
    property color toolBarColor: "#ffffff"
    property color toolBarTextColor: "#bdbebf"

    property color colorLightGrey: "#f3f3f3"
    property color colorLightGreyAccent: "#d1d1d0"
    property color colorLightGreyAccentSecondary: "#eeeeee"
    property color colorQtMediumGreen: "#5c9c1c"
    property color colorPageBackground: "#ffffff"
    property color colorQtGreen: "#81C343"

    property color colorTrackLightGreen: "#80c342"
    property color colorTrackDarkGreen: "#408500"
    property color colorTrackYellow: "#face20"
    property color colorTrackOrange: "#ff8c0a"
    property color colorTrackRed: "#e41e25"
    property color colorTrackBlue: "#46a2da"
    property color colorConcreteGrey: "#a4a5a7"

    property string fontFamily: "Roboto"

    property int paginationDotBaseSize: 10 * ScreenValues.dp
    property int paginationDotContainerHeight: 57 * ScreenValues.dp
    property int dividerHeight: 1 * ScreenValues.dp
    property int tabHeight: 38 * ScreenValues.dp
    property int toolBarHeight: 56 * ScreenValues.dp   
    property int spacing: 8 * ScreenValues.dp
    property int headerMargin: 16 * ScreenValues.dp
    property int tutorialDescriptionFontSize: 20 * ScreenValues.dp
    property int tutorialDescriptionMargins: 22 * ScreenValues.dp
    property int tutorialTitleFontSize: 24 * ScreenValues.dp
    property int tutorialTitleMargins: 16 * ScreenValues.dp
    property int tutorialContentMargin: 16 * ScreenValues.dp
    property int fontSizeSmall: 14 * ScreenValues.dp
    property int fontSizeRegular: 18 * ScreenValues.dp
    property int fontSizeLarge: 22 * ScreenValues.dp

    function dp(value) {
        return (value / 2)* ScreenValues.dp;
    }

    function shadeColor(c, percent) {
        var color = c.toString()
        var R = parseInt(color.substring(1,3),16);
        var G = parseInt(color.substring(3,5),16);
        var B = parseInt(color.substring(5,7),16);

        R = parseInt(R * (100 + percent) / 100);
        G = parseInt(G * (100 + percent) / 100);
        B = parseInt(B * (100 + percent) / 100);

        R = (R<255)?R:255;
        G = (G<255)?G:255;
        B = (B<255)?B:255;

        var RR = ((R.toString(16).length==1)?"0"+R.toString(16):R.toString(16));
        var GG = ((G.toString(16).length==1)?"0"+G.toString(16):G.toString(16));
        var BB = ((B.toString(16).length==1)?"0"+B.toString(16):B.toString(16));

        return "#"+RR+GG+BB;
    }
}
