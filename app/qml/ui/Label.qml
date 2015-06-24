import QtQuick 2.3

Text {
    color: "#323232"
    font.family: {
        try {
            __theme.fontFamily
        } catch (exception) {
            "Sans Serif"
        }
    }
    font.pixelSize: 34
}
