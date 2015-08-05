import QtQuick 2.3
import "../utils"
import "../controls"

BaseTabBarPage {
    id: root

    function trackDetailClicked(trackObject)
    {

        function isDataSufficient(tdo)
        {
            return tdo.presentation.abstract !== ""
        }

        try {
            var trackDetailObject = JSON.parse(JSON.stringify(__api.track[trackObject.id]))
            trackDetailObject.id = trackObject.id
            trackDetailObject.presentation.track.color = trackObject.color
            trackDetailObject.session = trackObject.session
            trackDetailObject.day = _ListView_DateView.currentItem.dataModel.day
            trackDetailObject.date = trackObject.date
            if(isDataSufficient(trackDetailObject))
            {
                _TrackDetailSheet.openWithObject(trackDetailObject);
            }
        } catch (ex)
        {
            console.warn("track detail data does not exist")
        }
    }

    function showToday()
    {
        _ListView_ScheduleView.highlightMoveDuration = 1

        for(var i = 0; i < __api.schedule.schedule.length; i++)
        {
            var modelData = __api.schedule.schedule[i]
            var s = new Date(modelData.day.startingSession)
            var e = new Date(modelData.day.endingSession)
            if(__api.today > s && __api.today < e)
            {
                _ListView_DateView.currentIndex = i
                _ListView_DateView.positionViewAtIndex(i, ListView.Center)
                _ListView_ScheduleView.positionViewAtIndex(i, ListView.Center)
                _ListView_ScheduleView.currentItem.sessionRepeater.positionToCurrentSession()
                break
            }
        }
        _ListView_ScheduleView.highlightMoveDuration = _ListView_DateView.highlightMoveDuration
    }

    Rectangle {
        id: _Rectangle_DateView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: __theme.dateViewHeight
        color: __theme.colorQtGreen

        ListView {
            id: _ListView_DateView
            property int delegateWidth : width / 1.5
            anchors.fill: parent
            orientation: ListView.Horizontal
            snapMode: ListView.SnapOneItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: ((width - delegateWidth) / 2)
            preferredHighlightEnd: preferredHighlightBegin + delegateWidth
            highlightMoveDuration: __theme.dp(400)

            onCurrentIndexChanged: {
                _ListView_ScheduleView.currentIndex = currentIndex
            }
            model: __api.schedule && __api.schedule.schedule ?
                       __api.schedule.schedule
                     : 0

            delegate: Item {
                id: _Item_Delegate
                property variant dataModel : modelData
                width: ListView.view.delegateWidth
                height: ListView.view.height

                Item {
                    id: _Item_DateView
                    width: parent.width
                    height: _Rectangle_DateView.height
                    Label {
                        anchors.fill: parent
                        anchors.margins: __theme.dp(15)
                        anchors.topMargin: __theme.dp(18)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: modelData.day.date.formatted
                        color: "#ffffff"
                        font.pixelSize: __theme.dateViewPixelSize
                        Fill { }
                    }
                    Fill { color: index%2==0?"red":"yellow" }
                }
                ClickGuard {
                    onClicked: _Item_Delegate.ListView.view.currentIndex = index
                }
            }
        }
        Rectangle {
            width: parent.width
            height: __theme.dp(2)
            anchors.bottom: parent.bottom
            color: __theme.colorQtMediumGreen
            //opacity: _Item_Delegate.ListView.isCurrentItem ? 1 : 0
            //Behavior on opacity { NumberAnimation { duration: 100 } }
        }
    }

    ListView {
        id: _ListView_ScheduleView
        // This ListView has one delegate per day of schedule
        // SingleDayDelegate (ListView)
        // - SingleSessionDelegate (Repeater)
        // -- SingleTrackDelegate (Repeater)
        anchors.top: _Rectangle_DateView.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        preferredHighlightBegin: 0
        preferredHighlightEnd: width
        highlightMoveDuration: _ListView_DateView.highlightMoveDuration
        cacheBuffer: 2*width*count

        onCurrentIndexChanged: {
            _ListView_DateView.currentIndex = currentIndex
        }
        model: _ListView_DateView.model
        delegate: SingleDayDelegate { }
    }
}
