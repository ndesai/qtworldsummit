import QtQuick 2.4
import QtQuick.Controls 1.3 as QC
import QtQuick.Controls.Styles 1.3 as CS
import QtQuick.Layouts 1.1 as LA
import QtWorldSummit 1.5
import "qrc:/qml/qml/ui" 1.5 as UI

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

    ToolBar {
        anchors {
            left: parent.left
            right: parent.right
        }
    }

    LA.RowLayout {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        height: UI.Theme.tabHeight
        spacing: 0

        QC.Button{
            LA.Layout.fillWidth: true
            LA.Layout.fillHeight: true

            text: "1"
            checkable: true
            checked: true
            exclusiveGroup: group

            style: TabButtonStyle { }
        }

        QC.Button{
            LA.Layout.fillWidth: true
            LA.Layout.fillHeight: true

            text: "2"
            checkable: true
            exclusiveGroup: group

            style: TabButtonStyle { }
        }

        QC.Button{
            LA.Layout.fillWidth: true
            LA.Layout.fillHeight: true

            checkable: true
            exclusiveGroup: group
            text: "3"

            style: TabButtonStyle { }
        }
    }

    QC.ExclusiveGroup {
        id: group
    }
}
