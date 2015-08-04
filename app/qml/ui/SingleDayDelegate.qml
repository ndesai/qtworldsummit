import QtQuick 2.0
import "../utils" as Utils

Component {
    Item {
        id: _Item_ScheduleView
        property alias sessionRepeater : _Repeater_Sessions
        width: ListView.view.width
        height: ListView.view.height
        layer.enabled: true
        layer.smooth: true
        Flickable {
            id: _Flickable
            anchors.fill: parent
            flickableDirection: Flickable.VerticalFlick
            contentWidth: width
            contentHeight: _Column_Sessions.height
            clip: true

            Behavior on contentY {
                id: _Behavior_ContentY
                enabled: false
                NumberAnimation {
                    duration: 350
                    easing.type: Easing.OutCubic
                }
            }

            Column {
                id: _Column_Sessions
                width: parent.width
                height: childrenRect.height
                Repeater {
                    id: _Repeater_Sessions
                    model: modelData.sessions

                    function positionToCurrentSession()
                    {
                        for(var i = 0; i < count; i++)
                        {
                            if(itemAt(i).flagIcon.state === "visible")
                            {
                                _Behavior_ContentY.enabled = true
                                console.log("setting contentY to " + itemAt(i).y)
                                _Flickable.contentY = itemAt(i).y
                                _Behavior_ContentY.enabled = false
                            }
                        }
                    }
                    delegate: SingleSessionDelegate { }
                }
            }
        }
    }
}
