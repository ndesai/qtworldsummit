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

    property int scheduleViewPixelSize: dp(36)
    property int scheduleViewTitlePixelSize: dp(34)
    property int scheduleViewTrackNamePixelSize : dp(22)
    property int scheduleViewPresenterPixelSize : dp(30)

    property int colorIndicatorWidth: dp(10)
    property int colorIndicatorBorderWidth: dp(2)

    property int detailPixelSize: dp(34)
    property int detailTitlePixelSize: dp(40)
    property int detailAbstractPixelSize: dp(30)
    property int detailPresenterPixelSize: dp(36)

    property int informationAddressPixelSize: dp(32)
    property int informationTitlePixelSize: dp(36)
    property int informationDatePixelSize: dp(34)
    property int informationVenueDescriptionPixelSize: dp(28)

    property bool simulateDp: false
    property double simulatedDp: $

    function dp(value) {
        var _dp = simulateDp ? simulatedDp : $
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
