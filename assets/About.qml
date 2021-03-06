import bb.cascades 1.2

Sheet {
    id: aboutSheet
    Page {
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: CustomFreeFormTitleBar {
                title: qsTr("About")
                closeButtonActive: true
                onBackButtonClicked: {
                    aboutSheet.close()
                }
            }
        }
        ScrollView {
            Container {
                leftPadding: 20
                rightPadding: 20
                bottomPadding: 20
                topPadding: 20
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    CustomImageTransition {
                        background: Color.Green
                        userImage: "images/DuktoMetroIcon.png"
                    }
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    layout: DockLayout {
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "Dukto"
                        textStyle.fontSize: FontSize.XXLarge
                    }
                    Container {
                        topPadding: 80
                        Label {
                            text: qsTr("by Emanuele Colombo")
                            textStyle {
                                color: Color.Gray
                                fontSize: FontSize.XXSmall
                            }
                        }
                    }
                }
                Container {
                    topPadding: 20
                    horizontalAlignment: HorizontalAlignment.Center
                    layout: DockLayout {
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: qsTr("Developer")
                    }
                    Container {
                        topPadding: 40
                        horizontalAlignment: HorizontalAlignment.Center
                        Label {
                            text: "Marden Laairoy"
                            textStyle {
                                fontSize: FontSize.Large
                                fontStyle: FontStyle.Italic
                                color: _control.themeColor
                            }
                        }
                    }
                }
                Container {
                    topPadding: 20
                    horizontalAlignment: HorizontalAlignment.Center
                    layout: DockLayout {
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        topPadding: 10
                        text: qsTr("Translators")
                    }
                    Container {
                        topPadding: 40
                        horizontalAlignment: HorizontalAlignment.Center
                        Label {
                            text: "Daniel London " + qsTr("(Chinese)")
                            textStyle {
                                fontSize: FontSize.Large
                                fontStyle: FontStyle.Italic
                                color: _control.themeColor
                            }
                        }
                    }
                }
                Container {
                    topPadding: 30
                    leftPadding: 100
                    rightPadding: 100
                    Container {
                        background: _control.themeColor
                        Divider {
                        }
                    }
                }
                Container {
                    topPadding: 20
                    horizontalAlignment: HorizontalAlignment.Center
                    CustomButton {
                        preferredWidth: 500
                        background: Color.Green
                        text: qsTr("Donate")
                        onClicked: {
                            dotateDialog.createObject().open()
                        }

                    }
                    Container {
                        topPadding: 20
                        CustomButton {
                            preferredWidth: 500
                            background: Color.Green
                            text: qsTr("Rate App")
                            onClicked: {
                                reviewApp.trigger("bb.action.OPEN")
                            }
                        }

                    }
                    Container {
                        topPadding: 20
                        CustomButton {
                            preferredWidth: 500
                            background: Color.Green
                            text: qsTr("Contact me")
                            onClicked: {
                                sendMail.trigger("bb.action.SENDEMAIL")
                            }
                        }

                    }
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Center
                    text: qsTr("This application and it's source code are released freely as open source project.")
                    multiline: true
                    textStyle {
                        textAlign: TextAlign.Center
                        fontSize: FontSize.Small
                        color: Color.Gray
                    }
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Center
                    text: qsTr("Download desktop version on:") + " \n http://msec.it/dukto/"
                    multiline: true
                    textStyle {
                        textAlign: TextAlign.Center
                        fontSize: FontSize.Small
                        color: Color.Gray
                    }
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: dotateDialog
                        DonateDialog {
                        }
                    },
                    Invocation {
                        id: sendMail
                        query {
                            invokeTargetId: "sys.pim.uib.email.hybridcomposer"
                            invokeActionId: "bb.action.SENDEMAIL"
                            uri: "mailto:marden.laairoy@gmail.com?subject=Dukto Support"
                        }
                    },
                    Invocation {
                        id: reviewApp
                        query {
                            invokeTargetId: "sys.appworld"
                            invokeActionId: "bb.action.OPEN"
                            uri: "appworld://content/59945056"
                        }
                    }

                ]
            }
        }
    }
}