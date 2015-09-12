import QtQuick 2.0
import "../utils" as Utils

Item {
    id: _Item_ScheduleDelegate
    property variant dataModel : modelData
    property alias flagIcon : _RightNowIcon
    width: parent.width
    height: _Rectangle_SessionTime.height + _Column_Tracks.height
    Rectangle {
        id: _Rectangle_SessionTime
        width: parent.width - __theme.dp(2)
        height: __theme.dp(80)
        color: __theme.colorLightGrey
        Label {
            anchors.left: parent.left
            anchors.leftMargin: __theme.dp(30)
            anchors.right: _RightNowIcon.state !== "hidden" ? _RightNowIcon.left : parent.right
            anchors.rightMargin: _RightNowIcon.state !== "hidden" ? __theme.dp(20) : __theme.dp(30)
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            text: _Item_ScheduleDelegate.dataModel.date.formatted['12h']
            color: "#222222"
            style: Text.Raised
            styleColor: "#ffffff"
            font.pixelSize: __theme.scheduleViewPixelSize
            elide: Text.ElideRight
            Utils.Fill { color: "yellow" }
        }
        RightNowIcon {
            id: _RightNowIcon
            property bool isRightNow : __dateTimeController.date_isRightNow(_Item_ScheduleDelegate.dataModel.date.plain.starting,
                                                              _Item_ScheduleDelegate.dataModel.date.plain.ending)
            anchors.right: parent.right
            anchors.rightMargin: __theme.dp(30)
            skeleton: true
            state: "hidden"
            states: [
                State {
                    name: "hidden"
                    when: !_RightNowIcon.isRightNow
                    PropertyChanges {
                        target: _RightNowIcon
                        scale: 0
                        opacity: 0
                    }
                },
                State {
                    name: "visible"
                    when: _RightNowIcon.isRightNow
                    PropertyChanges {
                        target: _RightNowIcon
                        scale: 1
                        opacity: 1
                    }
                }
            ]
            transitions: [
                Transition {
                    from: "hidden"
                    to: "visible"
                    ParallelAnimation {
                        NumberAnimation {
                            target: _RightNowIcon; property: "scale";
                            duration: 450; easing.type: Easing.OutBack
                            easing.overshoot: 0.4
                        }
                        NumberAnimation {
                            target: _RightNowIcon; property: "opacity";
                            duration: 450; easing.type: Easing.OutBack
                        }
                    }
                }
            ]
        }
        Utils.AccentTop {
            color: __theme.colorLightGrey
        }
        Utils.AccentBottom {
            color: __theme.colorLightGreyAccent
        }
    }
    Column {
        id: _Column_Tracks
        anchors.top: _Rectangle_SessionTime.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: childrenRect.height
        clip: true
        Repeater {
            id: _Repeater_Tracks
            model: _Item_ScheduleDelegate.dataModel.tracks
            delegate: SingleTrackDelegate { }
        }
    }
    Utils.Fill { color: "blue"; anchors.fill: _Column_Tracks }
}
