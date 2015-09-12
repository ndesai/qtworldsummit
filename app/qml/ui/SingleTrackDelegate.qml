import QtQuick 2.0
import "../utils" as Utils

Rectangle {
    id: _Rectangle_Track
    property variant dataModel : modelData
    property var trackDetail : { "color" : "#2299FF" }//_Model.legend[_Rectangle_Track.dataModel.track] || { }
    property bool isFavorite : __api.favoritesModelContainsTrack(_Rectangle_Track.dataModel)


    Connections {
        target: __api
        onFavoritesUpdated: {
            _Rectangle_Track.isFavorite = __api.favoritesModelContainsTrack(_Rectangle_Track.dataModel)
        }
    }

    height: Math.max(__theme.dp(80), _Column_TrackInformation.height + __theme.dp(30))
    width: _Column_Tracks.width
    color: _ClickGuard_Track.pressed ? "#dddddd" : "#ffffff"

    Rectangle {
        id: _Rectangle_TrackColor
        width: __theme.colorIndicatorWidth
        anchors.top: parent.top
        anchors.topMargin: __theme.dp(20)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: __theme.dp(20)
        anchors.left: parent.left
        anchors.leftMargin: __theme.dp(20)
//        color: || _Rectangle_Track.trackDetail.color || __theme.colorQtMediumGreen
        radius: __theme.dp(5)
        Rectangle {
            radius: parent.radius
            anchors.fill: parent
            opacity: 0.25
            border { width: __theme.colorIndicatorBorderWidth; color: Qt.darker(_Rectangle_TrackColor.color) }
        }
        Component.onCompleted: {
            color = __theme.randomTrackColor();
        }
    }

    Column {
        id: _Column_TrackInformation
        anchors.left: _Rectangle_TrackColor.right
        anchors.right: _BaseIcon_Favorite.left
        anchors.leftMargin: __theme.dp(20)
        anchors.rightMargin: __theme.dp(20)
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: _Label_TrackName
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: __theme.scheduleViewTrackNamePixelSize
            wrapMode: Text.WordWrap
            visible: text !== ""
            color: __theme.shadeColor(_Rectangle_TrackColor.color, -30)
            font.bold: true
            font.capitalization: Font.AllUppercase
            font.letterSpacing: 2.0
            text: (_Rectangle_Track.trackDetail.name || "")
        }
        Utils.VerticalSpacer { height: __theme.dp(6); visible: _Label_TrackLocation.visible }
        Label {
            id: _Label_TrackTitle
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: __theme.scheduleViewTitlePixelSize
            wrapMode: Text.WordWrap
            text: _Rectangle_Track.dataModel.title
            Utils.Fill { color: index%2===0?"blue":"green" }
        }
        Utils.VerticalSpacer { height: __theme.dp(4); visible: _Label_TrackPresenter.visible }
        Label {
            id: _Label_TrackPresenter
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: __theme.scheduleViewPresenterPixelSize
            wrapMode: Text.WordWrap
            visible: text !== ""
            text: _Rectangle_Track.dataModel.presenter
            color: "#525252"
            font.italic: true
        }
        Utils.VerticalSpacer { height: __theme.dp(4); visible: _Label_TrackLocation.visible }
        Label {
            id: _Label_TrackLocation
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: __theme.dp(28)
            wrapMode: Text.WordWrap
            visible: text !== ""
            text: _Rectangle_Track.dataModel.location ? "Room: " + _Rectangle_Track.dataModel.location : ""
            color: "#525252"
        }
    }

    Utils.BaseIcon {
        id: _BaseIcon_Favorite
        anchors.centerIn: undefined
        anchors.right: parent.right
        anchors.rightMargin: __theme.dp(30)
        anchors.top: _Column_TrackInformation.top
        color: __theme.colorQtGreen
        source: "../img/icon-bookmark-hl.png"
        visible: _Rectangle_Track.isFavorite
//        Connections {
//            target: _Model
//            onAddedFavoritesTrack: {
//                if(trackId === _Rectangle_Track.dataModel.id)
//                {
//                    _BaseIcon_Favorite.visible = true
//                }
//            }
//            onRemovedFavoritesTrack: {
//                if(trackId === _Rectangle_Track.dataModel.id)
//                {
//                    _BaseIcon_Favorite.visible = false
//                }
//            }
//        }
    }

    Utils.ClickGuard {
        id: _ClickGuard_Track
        enabled: _Rectangle_Track.dataModel.presenter
                 && _Rectangle_Track.dataModel.presenter !== ""
        onClicked: {
            var trackObject = JSON.parse(JSON.stringify(modelData))
            trackObject.color = _Rectangle_TrackColor.color
            trackObject.session = _Item_ScheduleDelegate.dataModel.date.formatted
            trackObject.date = _Item_ScheduleDelegate.dataModel.date
            root.trackDetailClicked(trackObject)
        }
    }

    Utils.AccentBottom {
        color: __theme.colorLightGreyAccent
        visible: index<_Repeater_Tracks.count-1
    }
    Utils.Fill { color: index%2===0?"yellow":"red" }
}
