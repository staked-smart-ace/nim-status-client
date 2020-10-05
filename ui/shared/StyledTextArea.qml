import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12
import "../imports"

Item {
    property alias textField: textArea
    property string placeholderText: "My placeholder"
    property alias text: textArea.text
    property string validationError: ""
    property string label: ""
    readonly property bool hasLabel: label !== ""
    property color bgColor: Style.current.inputBackground
    readonly property var forceActiveFocus: function () {
        textArea.forceActiveFocus(Qt.MouseFocusReason)
    }
    readonly property int labelMargin: 7
    property int customHeight: 44

    id: inputBox
    height: inputRectangle.height + (hasLabel ? inputLabel.height + labelMargin : 0) + (!!validationError ? validationErrorText.height : 0)
    anchors.right: parent.right
    anchors.left: parent.left

    StyledText {
        id: inputLabel
        text: inputBox.label
        font.weight: Font.Medium
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        font.pixelSize: Style.current.secondaryTextFontSize
    }

    Rectangle {
        id: inputRectangle
        height: customHeight
        color: bgColor
        radius: Style.current.radius
        anchors.top: inputBox.hasLabel ? inputLabel.bottom : parent.top
        anchors.topMargin: inputBox.hasLabel ? inputBox.labelMargin : 0
        anchors.right: parent.right
        anchors.left: parent.left
        border.width: !!validationError ? 1 : 0
        border.color: Style.current.red

        TextArea {
            id: textArea
            text: ""
            font.pixelSize: Style.current.primaryTextFontSize
            wrapMode: Text.WordWrap
            placeholderText: inputBox.placeholderText
            anchors.rightMargin: Style.current.padding
            anchors.leftMargin: inputBox.hasIcon ? 36 : Style.current.padding
            anchors.bottomMargin: Style.current.smallPadding
            anchors.topMargin: Style.current.smallPadding
            anchors.fill: parent
            font.family: Style.current.fontRegular.name
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                textArea.forceActiveFocus(Qt.MouseFocusReason)
            }
        }
    }

    TextEdit {
        visible: !!validationError
        id: validationErrorText
        text: validationError
        anchors.top: inputRectangle.bottom
        anchors.topMargin: 1
        selectByMouse: true
        readOnly: true
        font.pixelSize: Style.current.tertiaryTextFontSize
        color: Style.current.red

    }
}

/*##^##
Designer {
    D{i:0;formeditorColor:"#ffffff";formeditorZoom:1.25}
}
##^##*/

