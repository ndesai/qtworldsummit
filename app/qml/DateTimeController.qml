import QtQuick 2.0

QtObject {

    property var today: Date("2015-10-05 12:13 pm", "Y-m-d g:i a");

    onTodayChanged: {
        console.log("today = " + today)

        function date_isRightNow(start, end)
        {
            var s = new Date(start)
            var e = new Date(end)
            return today > s && today < e
        }
    }
}
