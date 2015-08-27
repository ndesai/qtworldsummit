import QtQuick 2.0
import "../controls"

BaseTabBarPage {
    id: root

    property int imageIndex: _listViewNavigation.currentIndex
    property var images: ["../img/level_a.svg", "../img/level_b.svg", "../img/level_c.svg"]

    ListView {
        id: _listViewNavigation
        anchors.left: parent.left
        anchors.right: parent.right

        height: __theme.dp(100)

        orientation: ListView.Horizontal

        model: root.images

        delegate: Rectangle {
            width: ListView.view.width / root.images.length
            height: ListView.view.height

            color: ListView.isCurrentItem ? __theme.colorQtGreen
                                          : __theme.colorLightGreyAccentSecondary

            Label {
                anchors.fill: parent
                elide: Text.ElideRight

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: __theme.dp(30)

                property var split: modelData.split('/')

                text: split[2].replace(/.svg/g, '').replace(/_/g, ' ').toUpperCase();

                color: parent.ListView.isCurrentItem ? "#ffffff" : "#323232"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: parent.ListView.view.currentIndex = index;
            }
        }

        z: 2
    }

    Flickable {
        id: _Flickable
        anchors.top: _listViewNavigation.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: _Image.sourceSize.height
        contentWidth: _Image.sourceSize.width
        z: 1

        Image {
            id: _Image
            height: parent.height
            fillMode: Image.Stretch
            smooth: true

            source: root.images[imageIndex]
        }
    }
}
