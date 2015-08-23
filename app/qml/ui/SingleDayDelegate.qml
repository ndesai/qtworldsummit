import QtQuick 2.5
import utils 1.5 as Utils

Item {
    id: _Item_ScheduleView

    property alias sessionRepeater: _Flickable

    width: ListView.view.width
    height: ListView.view.height
//    layer.enabled: true
//    layer.smooth: true

    ListView {
        id: _Flickable

        function positionToCurrentSession() {
            for (var i = 0; i < count; i++) {
                if (itemAt(i).flagIcon.state === "visible") {
                    _Behavior_ContentY.enabled = true
                    console.log("setting contentY to " + itemAt(i).y)
                    _Flickable.contentY = itemAt(i).y
                    _Behavior_ContentY.enabled = false
                }
            }
        }

        anchors.fill: parent

        flickableDirection: Flickable.VerticalFlick
        contentWidth: width
        // contentHeight: _Column_Sessions.height
        clip: true

        maximumFlickVelocity: height * 3

        model: modelData.sessions

        delegate: SingleSessionDelegate { }
    }
}
