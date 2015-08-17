import QtQuick 2.5
import "../controls"
import "../utils" as Utils
import QtGraphicalEffects 1.0 as QGE
import "qrc:/qml/qml/ui" 1.5 as UI
import ".."

Slide {
    id: root

    sourceComponent: Item {
        id: _Item

        QGE.FastBlur {
            layer.enabled: true
            Rectangle {
                anchors.fill: parent
                color: "white"
                opacity: 0.9
            }

            radius: 15
            width: root.width / _scale.xScale
            height: root.height / _scale.yScale
            transform: Scale {
                id: _scale
                xScale: 6; yScale: xScale
            }

            source: ShaderEffectSource {
                sourceItem: _itemPageContainer
                sourceRect: Qt.rect(root.x, -1*_header.height, root.width, root.height)
                live: true
            }
        }

        Header {
            id: _Header
            z: 3
            enableLeftAndRightContainers: true
            leftContent: Utils.ClickGuard {
                Utils.BaseIcon {
                    source: "../img/icon-back.png"
                    color: "#222222"
                    anchors.centerIn: parent
                }
                onClicked: root.close()
            }
            rightContent: Utils.ClickGuard {
                id: _ClickGuard_FavoriteButton
                property bool isFavorite : __api.favoritesModelContainsTrack(root.getProperty('id'))
                Utils.BaseIcon {
                    id: _BaseIcon_Bookmark
                    source: "../img/icon-bookmark.png"
                    color: "#222222"
                    anchors.centerIn: parent
                    width: 52
                }
                states: [
                    State {
                        when: _ClickGuard_FavoriteButton.isFavorite
                        PropertyChanges {
                            target: _BaseIcon_Bookmark
                            color: UI.Theme.colorQtGreen
                            source: "../img/icon-bookmark-hl.png"
                        }
                    }
                ]
                onClicked: {
                    isFavorite ^= 1
                    if(isFavorite)
                    {
                        __api.insertFavorite(root.dataObject)
                    } else
                    {
                        __api.removeFavorite(root.dataObject)
                    }
                }
            }

            Label {
                id: _labelDate
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                font.pixelSize: UI.Theme.detailDatePixelSize
                font.weight: Font.DemiBold

                text: root.getProperty('date.formatted')['12h']

                Utils.Fill { color: "blue" }
            }

            Utils.ClickGuard {
                onClicked: {
                    root.close()
                }
            }
        }
        Flickable {
            id: _Flickable
            anchors.top: _Header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            contentWidth: width
            contentHeight: _Item_Container.height
            z: 1
            Item {
                id: _Item_Container
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: childrenRect.height

                Column {
                    width: parent.width
                    height: childrenRect.height
                    Image {
                        id: _imageHero
                        anchors.left: parent.left
                        anchors.right: parent.right

                        fillMode: Image.PreserveAspectFit

                        source: "../img/qws2015-hero.jpg"

                        Label {
                            id: _Label_Title
                            anchors.fill: parent
                            anchors.leftMargin: UI.Theme.dp(30)
                            anchors.rightMargin: anchors.leftMargin

                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            color: UI.Theme.colorPageBackground
                            font.pixelSize: UI.Theme.detailTitlePixelSize
                            wrapMode: Text.WordWrap
                            maximumLineCount: 2
                            elide: Text.ElideRight

                            text: root.getProperty('presentation').title
                        }
                    }
                    Utils.VerticalSpacer { height: 30 }
                    Column {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: UI.Theme.dp(40)

                        Row {
                            id: _Row_TrackColor
                            width: parent.width
                            height: 60
                            Rectangle {
                                id: _Rectangle_TrackColor
                                width: 60
                                height: 60
                                radius: width / 2
                                color: UI.Theme.randomTrackColor()//root.getProperty('presentation').track.color
                                visible: _Label_TrackTitle !== ""
                                Rectangle {
                                    radius: parent.radius
                                    anchors.fill: parent
                                    opacity: 0.25
                                    border { width: 2; color: Qt.darker(_Rectangle_TrackColor.color) }
                                }
                            }
                            Utils.HorizontalSpacer { width: 30 }
                            Label {
                                id: _Label_TrackTitle
                                anchors.verticalCenter: _Rectangle_TrackColor.verticalCenter
                                text: "Training"//root.getProperty('presentation').track.title
                                color: "#222222"
                                font.pixelSize: UI.Theme.detailTrackNamePixelSize
                            }
                        }
                        Utils.VerticalSpacer { height: 30; visible: _Row_TrackColor.visible }
                        Label {
                            id: _Label_Abstract
                            width: parent.width
                            wrapMode: Text.WordWrap
                            font.pixelSize: UI.Theme.detailAbstractPixelSize
                            text: root.getProperty('presentation').abstract
                        }
                        Utils.VerticalSpacer { height: 60 }
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: UI.Theme.colorLightGreyAccentSecondary
                        }
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: UI.Theme.colorLightGreyAccent
                        }
                        Utils.VerticalSpacer { height: 60 }
                        Item {
                            width: parent.width
                            height: 120
                            Rectangle {
                                id: _Rectangle_PresenterBackfill
                                height: parent.height
                                width: height
                                color: UI.Theme.colorLightGrey
                                clip: true
                                Image {
                                    id: _Image_Presenter
                                    anchors.fill: parent
                                    sourceSize.width: width
                                    sourceSize.height: height
                                    smooth: true
                                    source: Qt.platform.os === "ios" ?
                                                "../img/avatar-default.jpg" :
                                                root.getProperty('presenter').image.replace("https:", "http:") || ""
                                    onStatusChanged: {
                                        if(status === Image.Error)
                                        {
                                            console.log("image error - " + source)
                                        }
                                    }
                                }
                            }
                            Column {
                                anchors.left: _Rectangle_PresenterBackfill.right
                                anchors.leftMargin: 36
                                anchors.right: parent.right
                                height: childrenRect.height
                                anchors.verticalCenter: _Rectangle_PresenterBackfill.verticalCenter
                                Label {
                                    id: _Label_PresenterName
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    elide: Text.ElideRight
                                    maximumLineCount: 2
                                    font.pixelSize: UI.Theme.detailPresenterNamePixelSize
                                    visible: text!==""
                                    text: root.getProperty('presenter').name
                                    lineHeight: 0.85
                                    Utils.Fill { color: "red" }
                                }
                                Label {
                                    id: _Label_PresenterOrganization
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    elide: Text.ElideRight
                                    maximumLineCount: 2
                                    font.italic: true
                                    visible: text!==""
                                    text: root.getProperty('presenter').organization
                                    font.pixelSize: UI.Theme.detailPresenterOrganizationPixelSize
                                    Utils.Fill { color: "purple" }
                                }
                            }
                        }
                        Utils.VerticalSpacer { height: 40 }
                        Label {
                            id: _Label_PresenterBio
                            width: parent.width
                            wrapMode: Text.WordWrap
                            font.pixelSize: UI.Theme.detailAbstractPixelSize
                            text: root.getProperty('presenter').bio
                        }


                    }

                }

                Utils.Fill { color: "yellow" }

            }
        }
    }
}
