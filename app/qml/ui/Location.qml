import QtQuick 2.5
import "../controls"

BaseTabBarPage {
    id: root

    Flickable {
        id: _Flickable

        anchors.fill: parent

        contentHeight: _Image.sourceSize.height
        contentWidth: _Image.sourceSize.width

        Image {
            id: _Image

            source: "qrc:/images/floorplan-bcc.png"
            smooth: true
        }
    }
}
