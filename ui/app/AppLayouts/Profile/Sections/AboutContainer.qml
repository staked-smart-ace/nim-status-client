import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import "../../../../imports"
import "../../../../shared"
import "../../../../shared/status"

Item {
    id: aboutContainer
    Layout.fillHeight: true
    Layout.fillWidth: true

    Column {
        id: generalColumn
        spacing: Style.current.bigPadding
        anchors.top: parent.top
        anchors.topMargin: 46
        anchors.left: parent.left
        anchors.leftMargin: contentMargin
        anchors.right: parent.right
        anchors.rightMargin: contentMargin

        StatusSectionDescItem {
            name: qsTr("App version")
            description: qsTr("Version: %1").arg("beta.5")
        }

        StatusSectionDescItem {
            name: qsTr("Node version ")
            description: profileModel.nodeVersion()
        }

        StyledText {
            text: qsTr("Check for updates")
            font.pixelSize: 15
            color: Style.current.blue

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: {
                    parent.font.underline = true
                }
                onExited: {
                    parent.font.underline = false
                }
                onClicked: {
                    appMain.openLink("https://github.com/status-im/nim-status-client/releases")
                }
            }
        }

        StyledText {
            text: qsTr("Privacy Policy")
            font.pixelSize: 15
            color: Style.current.blue

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: {
                    parent.font.underline = true
                }
                onExited: {
                    parent.font.underline = false
                }
                onClicked: {
                    appMain.openLink("https://status.im/privacy-policy/")
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;height:600;width:800}
}
##^##*/
