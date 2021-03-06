import bb.cascades 1.2

Container {
    id: rootContainer
    property alias text: txtArea.text
    property alias hintText: txtArea.hintText
    property alias editable: txtArea.editable
    property int count
    layout: DockLayout {
    }
    Container {
        layout: DockLayout {
        }
        background: _control.themeColor
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        leftPadding: 4
        rightPadding: 4
        topPadding: 4
        bottomPadding: 4
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            background: Color.White
        }
    }
    TextArea {
        id: txtArea
        backgroundVisible: false
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        onTextChanging: {
            count = text.length
        }
    }
}
