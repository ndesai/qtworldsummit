import QtQuick 2.4

Item {
    id: root

    property string fontFamily: "Avenir Next"
    property color colorQtGreen: "#81C343"

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
