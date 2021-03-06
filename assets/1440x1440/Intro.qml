import bb.cascades 1.2

Sheet {
    id: mIntroSheet
    Page {
        Container {
            background: _control.themeColor
            layout: DockLayout {
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                topPadding: 50
                horizontalAlignment: HorizontalAlignment.Center
                leftPadding: 50
                rightPadding: 50
                implicitLayoutAnimationsEnabled: false
                Label {
                    id: mIntroLabel
                    implicitLayoutAnimationsEnabled: false
                    text: "Share to any Device"
                    multiline: true
                    textStyle {
                        textAlign: TextAlign.Center
                        fontSize: FontSize.XLarge
                        color: Color.White
                        fontWeight: FontWeight.Bold
                    }
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                ListView {
                    id: listview
                    property int screenSizeWidth: 1440
                    preferredWidth: screenSizeWidth
                    preferredHeight: 1440 / 2
                    flickMode: FlickMode.SingleItem
                    snapMode: SnapMode.LeadingEdge
                    scrollIndicatorMode: ScrollIndicatorMode.None

                    layout: StackListLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    dataModel: XmlDataModel {
                        source: "asset:///XML/intro.xml"
                    }
                    listItemComponents: [
                        ListItemComponent {
                            type: "intro"
                            Container {
                                horizontalAlignment: HorizontalAlignment.Fill
                                preferredWidth: ListItem.view.screenSizeWidth
                                leftPadding: 50
                                rightPadding: 50
                                layout: DockLayout {
                                }
                                verticalAlignment: VerticalAlignment.Fill
                                Container {
                                    verticalAlignment: VerticalAlignment.Center
                                    horizontalAlignment: HorizontalAlignment.Center
                                    ImageView {
                                        imageSource: ListItemData.imageSource
                                        scalingMethod: ScalingMethod.AspectFit
                                    }
                                }
                            }
                        }
                    ]
                    attachedObjects: [
                        // This handler is tracking the scroll state of the ListView.
                        ListScrollStateHandler {
                            onFirstVisibleItemChanged: {
                                var item = listview.dataModel.data(firstVisibleItem)
                                mIntroLabel.text = item.text
                                mIntroIndicator.number = item.number
                            }
                        }
                    ]
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Bottom
                horizontalAlignment: HorizontalAlignment.Center
                bottomPadding: 20
                CustomListIndicator {
                    id: mIntroIndicator
                    horizontalAlignment: HorizontalAlignment.Center
                    bottomPadding: 40
                }
                CustomButton {
                    preferredWidth: 400
                    background: Color.Green
                    horizontalAlignment: HorizontalAlignment.Center
                    text: qsTr("Close")
                    onClicked: {
                        mIntroSheet.close()
                    }
                }
            }
        }
    }
}