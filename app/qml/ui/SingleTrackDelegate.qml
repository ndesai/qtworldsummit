import QtQuick 2.0
import utils 1.5 as Utils
import ui 1.5 as UI
import ".."

Rectangle {
    id: _Rectangle_Track

    property variant dataModel: modelData
    property var trackDetail: { "color" : "#2299FF" }//_Model.legend[_Rectangle_Track.dataModel.track] || { }
    property bool isFavorite: Math.floor(Math.random()*12)%2===0

    height: Math.max(UI.Theme.dp(80), _Column_TrackInformation.height + UI.Theme.dp(30))
    width: _Column_Tracks.width
    color: _ClickGuard_Track.pressed ? "#dddddd" : "#ffffff"

    Rectangle {
        id: _Rectangle_TrackColor

        anchors {
            top: parent.top; topMargin: UI.Theme.dp(20)
            bottom: parent.bottom; bottomMargin: UI.Theme.dp(20)
            left: parent.left; leftMargin: UI.Theme.dp(20)
        }

        width: UI.Theme.colorIndicatorWidth
        color: UI.Theme.randomTrackColor() || _Rectangle_Track.trackDetail.color || UI.Theme.colorQtMediumGreen
        radius: UI.Theme.dp(5)

        Rectangle {
            anchors.fill: parent

            border {
                width: UI.Theme.colorIndicatorBorderWidth
                color: Qt.darker(_Rectangle_TrackColor.color)
            }

            radius: parent.radius
            opacity: 0.25
        }
    }

    Column {
        id: _Column_TrackInformation

        anchors {
            left: _Rectangle_TrackColor.right; leftMargin: UI.Theme.dp(20)
            right: _BaseIcon_Favorite.left; rightMargin: UI.Theme.dp(20)
            verticalCenter: parent.verticalCenter
        }

        Label {
            id: _Label_TrackName

            anchors {
                left: parent.left
                right: parent.right
            }

            wrapMode: Text.WordWrap
            visible: text !== ""
            color: UI.Theme.shadeColor(_Rectangle_TrackColor.color, -30)

            font {
                pixelSize: UI.Theme.scheduleViewTrackNamePixelSize
                bold: true
                capitalization: Font.AllUppercase
                letterSpacing: 2.0
            }

            text: (_Rectangle_Track.trackDetail.name || "")
        }

        Utils.VerticalSpacer { height: UI.Theme.dp(6); visible: _Label_TrackLocation.visible }

        Label {
            id: _Label_TrackTitle

            anchors {
                left: parent.left
                right: parent.right
            }

            font.pixelSize: UI.Theme.scheduleViewTitlePixelSize

            wrapMode: Text.WordWrap
            text: _Rectangle_Track.dataModel.title
            Utils.Fill { color: index%2===0?"blue":"green" }
        }

        Utils.VerticalSpacer { height: UI.Theme.dp(4); visible: _Label_TrackPresenter.visible }

        Label {
            id: _Label_TrackPresenter

            anchors {
                left: parent.left
                right: parent.right
            }

            font.pixelSize: UI.Theme.scheduleViewPresenterPixelSize
            wrapMode: Text.WordWrap
            visible: text !== ""
            text: _Rectangle_Track.dataModel.presenter
            color: "#525252"
            font.italic: true
        }

        Utils.VerticalSpacer { height: UI.Theme.dp(4); visible: _Label_TrackLocation.visible }

        Label {
            id: _Label_TrackLocation

            anchors {
                left: parent.left
                right: parent.right
            }

            font.pixelSize: UI.Theme.dp(28)
            wrapMode: Text.WordWrap
            visible: text !== ""
            text: _Rectangle_Track.dataModel.location
            color: "#525252"
        }
    }

    Utils.BaseIcon {
        id: _BaseIcon_Favorite

        anchors {
            centerIn: undefined
            right: parent.right; rightMargin: UI.Theme.dp(30)
            top: _Column_TrackInformation.top
        }

        color: UI.Theme.colorQtGreen
        source: "qrc:/images/icon-bookmark-hl.png"
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
        color: UI.Theme.colorLightGreyAccent
        visible: index<_Repeater_Tracks.count-1
    }

    Utils.Fill { color: index%2===0?"yellow":"red" }
}
