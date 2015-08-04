import QtQuick 2.4

Item {
    id: root

    // Fonts
    property string fontFamily: "Avenir Next"

    // Colors
    property color colorQtGreen: "#81C343"
    property color colorLightGrey : "#f3f3f3"
    property color colorLightGreyAccent : "#d1d1d0"
    property color colorQtMediumGreen : "#5c9c1c"
    property color colorPageBackground: "#ffffff"

    // Geometry
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

    states: [
        State {
            when: Qt.platform.os === "android"
            PropertyChanges {
                target: root
                fontFamily: _fontLoaderOpenSansRegular.name
            }
            PropertyChanges {
                target: _fontLoaderOpenSansRegular
                source: "fonts/Open_Sans/OpenSans-Regular.ttf"
            }
            PropertyChanges {
                target: _fontLoaderOpenSansSemiBold
                source: "fonts/Open_Sans/OpenSans-Semibold.ttf"
            }
            PropertyChanges {
                target: _fontLoaderOpenSansBold
                source: "fonts/Open_Sans/OpenSans-Bold.ttf"
            }
        }
    ]
}
