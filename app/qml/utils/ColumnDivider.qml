import QtQuick 2.0

Column {
    property alias topSpacer : _VSTop.height
    property alias bottomSpacer : _VSBot.height
    width: parent.width
    height: childrenRect.height
    VerticalSpacer { id: _VSTop; height: __theme.dp(40) }
    Rectangle {
        width: parent.width
        height: __theme.dp(1)
        color: __theme.colorLightGreyAccentSecondary
    }
    Rectangle {
        width: parent.width
        height: __theme.dp(1)
        color: __theme.colorLightGreyAccent
    }
    VerticalSpacer { id: _VSBot; height: __theme.dp(40) }
}
