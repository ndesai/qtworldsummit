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
