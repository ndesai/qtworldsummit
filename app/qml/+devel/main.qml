import QtQuick 2.5
import QtQuick.Controls 1.4 as QC
import QtQuick.Controls.Styles 1.4 as CS
import QtQuick.Layouts 1.1 as LA
import QtWorldSummit 1.5
import ui 1.5 as UI

QC.ApplicationWindow {
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

    QC.StackView {
        id: stackView

        anchors.fill: parent

        initialItem: tutorial
    }

    Component {
        id: tutorial

        TutorialPage {
            onClosed: stackView.replace(mainPage)
        }
    }

    Component {
        id: mainPage
        MainPage { }
    }
}
