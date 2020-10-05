import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14
import "../../../../../imports"
import "../../../../../shared"

Item {
    property string ensUsername: ""
    signal okBtnClicked()

    StyledText {
        id: sectionTitle
        //% "ENS usernames"
        text: qsTrId("ens-usernames")
        anchors.left: parent.left
        anchors.leftMargin: 24
        anchors.top: parent.top
        anchors.topMargin: 24
        font.weight: Font.Bold
        font.pixelSize: Style.current.actionTextFontSize
    }


    Rectangle {
        id: circle
        anchors.top: sectionTitle.bottom
        anchors.topMargin: 24
        anchors.horizontalCenter: parent.horizontalCenter
        width: 60
        height: 60
        radius: 120
        color: Style.current.blue

        StyledText {
            text: "✓"
            opacity: 0.7
            font.weight: Font.Bold
            font.pixelSize: Style.current.altTitleTextFontSize
            color: Style.current.white
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    StyledText {
        id: title
        //% "Username added"
        text: qsTrId("ens-saved-title")
        anchors.top: circle.bottom
        anchors.topMargin: 24
        font.weight: Font.Bold
        font.pixelSize: Style.current.superTitleTextFontSize
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }
    
    StyledText {
        id: subtitle
        //% "%1 will be connected once the transaction is complete."
        text: qsTrId("-1-will-be-connected-once-the-transaction-is-complete-").arg(ensUsername)
        anchors.top: title.bottom
        anchors.topMargin: 24
        font.pixelSize: Style.current.altPrimaryTextFontSize
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }

    StyledText {
        id: progress
        //% "You can follow the progress in the Transaction History section of your wallet."
        text: qsTrId("ens-username-you-can-follow-progress")
        anchors.top: subtitle.bottom
        anchors.topMargin: 24
        font.pixelSize: Style.current.tertiaryTextFontSize
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        color: Style.current.secondaryText

    }

    StyledButton {
        id: startBtn
        anchors.top: progress.bottom
        anchors.topMargin: Style.current.padding
        anchors.horizontalCenter: parent.horizontalCenter
        //% "Ok, got it"
        label: qsTrId("ens-got-it")
        onClicked: okBtnClicked()
    }
}
