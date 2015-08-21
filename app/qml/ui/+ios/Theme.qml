pragma Singleton
import QtQuick 2.5

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
    property color colorLightGreyAccentSecondary : "#eeeeee"
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

    property string fontFamily: "Sans Serif"

    property int paginationDotBaseSize: 30
    property int paginationDotContainerHeight: 50
    property int dividerHeight: 1
    property int tabHeight: 98*0.5
    property int toolBarHeight: 56
    property int spacing: 8
    property int headerMargin: 16
    property int tutorialDescriptionFontSize: 26
    property int tutorialTitleFontSize: 34
    property int tutorialTitleMargins: 28
    property int tutorialDescriptionMargins: 28
    property int tutorialContentMargin: 22
    property int fontSizeSmall: 14
    property int fontSizeRegular: 18
    property int fontSizeLarge: 22

    function dp(value) {
        var _dp = simulateDp ? simulatedDp : ScreenValues.dpi
        var factor = _dp*0.45;
        if ((Qt.platform.os === "osx"
                || Qt.platform.os === "ios") && !simulateDp) {
            return value;
        }
        return factor*value;
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
