import QtQuick 2.3
import QtQuick.Controls 1.2 as QC
import com.iktwo.components 1.0 as IC
import "android" as Android
import "utils" as Utils
import DevDays14 1.0 as DD14
import QtQuick.Window 2.0 as Window

Utils.BaseWindow {
    id: superRoot

    property var resolutions: [
        {"height": 480, "width": 320, "name": "HVGA", "ratio": "3:2"},
        {"height": 640, "width": 360, "name": "nHD", "ratio": "16:9"},
        {"height": 640, "width": 480, "name": "VGA", "ratio": "4:3"},
        {"height": 800, "width": 480, "name": "WVGA", "ratio": "5:3"},
        {"height": 800, "width": 600, "name": "SVGA", "ratio": "4:3"},
        {"height": 960, "width": 540, "name": "qHD", "ratio": "16:9"},
        {"height": 1280, "width": 720, "name": "720p", "ratio": "16:9"},
        {"height": 1280, "width": 800, "name": "WXGA", "ratio": "16:10"},
        {"height": 1920, "width": 1080, "name": "1080p", "ratio": "16:9"}
    ]

    property int currentResolution: 5

    property bool isScreenPortrait: height >= width

    visible: true
    width: resolutions[currentResolution]["width"]
    height: resolutions[currentResolution]["height"]

//    Android.ActionBar {
//        id: actionBar
//        title: "<html><font color=\"#322e2d\">Qt DEVELOPER DAYS </font> <font color=\"#5c9c1c\">2014</font></html>"
//        isScreenPortrait: superRoot.isScreenPortrait
//    }

    Loader {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        source: "home.qml"
        focus: true

        onLoaded: {
            item.header.height = Math.ceil(ScreenValues.dp * (ScreenValues.isTablet ? 56 : (isScreenPortrait ? 48 : 40)))
        }
    }

    Component.onCompleted: {
        console.log("xxx..", ScreenValues.dp)
        console.log("yyy..", Window.Screen.pixelDensity)
//        IC.Theme.titleBarColor = "#f3f3f3"

    }
}
