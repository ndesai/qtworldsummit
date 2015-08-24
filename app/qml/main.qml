import QtQuick 2.5
import QtQuick.Controls 1.4
import QtWorldSummit 1.5

ApplicationWindow {
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

    property Api __api: Api { }

    visible: true
    width: resolutions[currentResolution]["width"]
    height: resolutions[currentResolution]["height"]

    StackView {
        id: stackView

        property int timesBackWasPressed: 0
        anchors.fill: parent

        initialItem: mainPage
        opacity: 0
        focus: true

        Keys.onBackPressed: currentItem.handleBackKey(event)

        Behavior on opacity {
            SequentialAnimation {
                PauseAnimation { duration: 450  }
                NumberAnimation { target: stackView; property: "opacity"; to: 1 }
            }
        }
    }

    Component {
        id: tutorialPage

        TutorialPage {
            clip: true
            // onClosed: ScreenValues.setStatusBarColor(149, 165, 166)
            onClosed: stackView.pop()

            Component.onCompleted: stackView.opacity = 1
        }
    }

    MainPage {
        id: mainPage
    }

    Component.onCompleted: stackView.push(tutorialPage)
}
