import QtQuick 2.3
import QtQuick.Controls 1.2 as Controls
import QtQuick.Window 2.0
import "utils" as Utils

Utils.BaseWindow {
    id: superRoot

    visible: true
    width: 600
    height: 900
    color: "#000000"

    Image {
        anchors.fill: parent
        source: "img/triangular.png"
        fillMode: Image.Tile
    }

    Item {
        id: _itemContainer
        anchors.fill: parent
        anchors.margins: 50

        Item {
            id: _itemLoaderContainer

            property bool largePhone : true

            width:750 / 2
            height: 1334 / 2

            Loader {
                id: _Loader_iOS

                anchors.left: parent.left;
                anchors.top: parent.top
                width: parent.largePhone ? 750 : 640
                height: parent.largePhone ? 1334 : 1136

                source: "home.qml"
                clip: true

                Scale {
                    id: _Scale_iOS
                    xScale: 0.5; yScale: 0.5
                    origin.x: 0; origin.y: 0
                }

                state: "scaled"
                states: [
                    State {
                        name: "scaled"
                        PropertyChanges {
                            target: _Loader_iOS
                            transform: _Scale_iOS
                        }
                    }
                ]
            }
        }

        Column {
            anchors.top: _itemLoaderContainer.bottom
            anchors.topMargin: 25
            width: _itemLoaderContainer.width
            spacing: 20

            Controls.Button {
                width: parent.width
                height: 40
                text: "Show Fills"
                onClicked: {
                    superRoot.showFills ^= 1
                }
            }

            Controls.Button {
                width: parent.width
                height: 40
                text: "Toggle Size"
                onClicked: {
                    _itemLoaderContainer.largePhone ^= 1
                }
            }
        }
    }
}
