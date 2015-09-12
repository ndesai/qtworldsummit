import QtQuick 2.0

QtObject {
    id: root

    signal showToday

    property var today

    function date_isRightNow(start, end)
    {
        var s = new Date(start)
        var e = new Date(end)
        return today > s && today < e
    }

    property list<QtObject> __children: [
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                // Dev use
                // root.today = new Date("2015-10-06T13:15:00.000Z");
                root.today = new Date();
            }
        }
    ]
}
