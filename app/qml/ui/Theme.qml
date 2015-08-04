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

    property int heightHeader: dp(128)
    property int marginTop: dp(40)

    property int dateViewHeight: dp(100)
    property int dateViewPixelSize: dp(34)

    property int scheduleViewPixelSize: 36
    property int scheduleViewTitlePixelSize: 34
    property int scheduleViewTrackNamePixelSize : 22
    property int scheduleViewPresenterPixelSize : 30

    property int colorIndicatorWidth: 10
    property int colorIndicatorBorderWidth: 2

    property int detailPixelSize: 34
    property int detailTitlePixelSize: 40
    property int detailAbstractPixelSize: 30
    property int detailPresenterPixelSize: 36

    property int informationAddressPixelSize: 32
    property int informationTitlePixelSize: 36
    property int informationDatePixelSize: 34
    property int informationVenueDescriptionPixelSize: 28

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

    function dp(value) {
        var factor = $*0.45;
        if (Qt.platform.os === "osx"
                || Qt.platform.os === "ios") {
            return value;
        }
        return factor*value;
    }

    FontLoader {
        id: _fontLoaderOpenSansRegular
    }

    FontLoader {
        id: _fontLoaderOpenSansSemiBold
    }

    FontLoader {
        id: _fontLoaderOpenSansBold
    }
}
