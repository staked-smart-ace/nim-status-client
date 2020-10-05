import QtQuick 2.13
import "../../../../imports"
import "../../../../shared"
import "./"

ModalPopup {
  id: popup
  //% "Transaction Details"
  title: qsTrId("transaction-details")

  Item {
    id: confirmations
    anchors.left: parent.left
    anchors.leftMargin: Style.current.smallPadding
    anchors.top: parent.top
    anchors.topMargin: Style.current.smallPadding
    anchors.right: parent.right
    anchors.rightMargin: Style.current.smallPadding
    height: children[0].height + children[1].height + Style.current.smallPadding

    StyledText {
      id: confirmationsCount
      // TODO get the right value
      //% "9999 Confirmations"
      text: qsTrId("9999-confirmations")
      font.pixelSize: Style.current.altPrimaryTextFontSize
    }

    StyledText {
      id: confirmationsInfo
      //% "When the transaction has 12 confirmations you can consider it settled."
      text: qsTrId("confirmations-helper-text")
      wrapMode: Text.WordWrap
      font.pixelSize: Style.current.altPrimaryTextFontSize
      font.weight: Font.Medium
      color: Style.current.darkGrey
      anchors.top: confirmationsCount.bottom
      anchors.topMargin: Style.current.smallPadding
      width:parent.width
    }
  }

  Separator {
    id: separator
    anchors.top: confirmations.bottom
    anchors.topMargin: Style.current.padding
    anchors.left: parent.left
    anchors.leftMargin: -Style.current.padding
    anchors.right: parent.right
    anchors.rightMargin: -Style.current.padding
  }

  Item {
    id: block
    anchors.top: separator.bottom
    anchors.topMargin: Style.current.padding
    anchors.left: parent.left
    anchors.leftMargin: Style.current.smallPadding
    height: children[0].height

    StyledText {
      id: labelBlock
      //% "Block"
      text: qsTrId("block")
      font.pixelSize: Style.current.altPrimaryTextFontSize
      font.weight: Font.Medium
      color: Style.current.darkGrey
    }

    StyledText {
      id: valueBlock
      text: blockNumber
      font.pixelSize: Style.current.altPrimaryTextFontSize
      anchors.left: labelBlock.right
      anchors.leftMargin: Style.current.padding
    }
  }

  Item {
    id: hash
    anchors.top: block.bottom
    anchors.topMargin: Style.current.padding
    anchors.left: parent.left
    anchors.leftMargin: Style.current.smallPadding
    anchors.right: parent.right
    anchors.rightMargin: Style.current.smallPadding
    height: children[0].height

    StyledText {
      id: labelHash
      //% "Hash"
      text: qsTrId("hash")
      font.pixelSize: Style.current.altPrimaryTextFontSize
      font.weight: Font.Medium
      color: Style.current.darkGrey
    }

    Address {
      id: valueHash
      text: blockHash
      width: 160
      maxWidth: parent.width - labelHash.width - Style.current.padding
      color: Style.current.textColor
      font.pixelSize: Style.current.altPrimaryTextFontSize
      anchors.left: labelHash.right
      anchors.leftMargin: Style.current.padding
    }
  }

  Item {
    id: from
    anchors.top: hash.bottom
    anchors.topMargin: Style.current.padding
    anchors.left: parent.left
    anchors.leftMargin: Style.current.smallPadding
    height: children[0].height

    StyledText {
      id: labelFrom
      //% "From"
      text: qsTrId("from")
      font.pixelSize: Style.current.altPrimaryTextFontSize
      font.weight: Font.Medium
      color: Style.current.darkGrey
    }

    Address {
      id: valueFrom
      text: fromAddress
      color: Style.current.textColor
      width: 160
      font.pixelSize: Style.current.altPrimaryTextFontSize
      anchors.left: labelFrom.right
      anchors.leftMargin: Style.current.padding
    }
  }

  Item {
    id: toItem
    anchors.top: from.bottom
    anchors.topMargin: Style.current.padding
    anchors.left: parent.left
    anchors.leftMargin: Style.current.smallPadding
    height: children[0].height

    StyledText {
      id: labelTo
      //% "To"
      text: qsTrId("to")
      font.pixelSize: Style.current.altPrimaryTextFontSize
      font.weight: Font.Medium
      color: Style.current.darkGrey
    }

    Address {
      id: valueTo
      text: to
      color: Style.current.textColor
      width: 160
      font.pixelSize: Style.current.altPrimaryTextFontSize
      anchors.left: labelTo.right
      anchors.leftMargin: Style.current.padding
    }
  }

  Item {
    id: gasLimitItem
    anchors.top: toItem.bottom
    anchors.topMargin: Style.current.padding
    anchors.left: parent.left
    anchors.leftMargin: Style.current.smallPadding
    height: children[0].height

    StyledText {
      id: labelGasLimit
      //% "Gas limit"
      text: qsTrId("gas-limit")
      font.pixelSize: Style.current.altPrimaryTextFontSize
      font.weight: Font.Medium
      color: Style.current.darkGrey
    }

    StyledText {
      id: valueGasLimit
      text: gasLimit
      font.pixelSize: Style.current.altPrimaryTextFontSize
      anchors.left: labelGasLimit.right
      anchors.leftMargin: Style.current.padding
    }
  }

  Item {
    id: gasPriceItem
    anchors.top: gasLimitItem.bottom
    anchors.topMargin: Style.current.padding
    anchors.left: parent.left
    anchors.leftMargin: Style.current.smallPadding
    height: children[0].height

    StyledText {
      id: labelGasPrice
      //% "Gas price"
      text: qsTrId("gas-price")
      font.pixelSize: Style.current.altPrimaryTextFontSize
      font.weight: Font.Medium
      color: Style.current.darkGrey
    }

    StyledText {
      id: valueGasPrice
      text: gasPrice
      font.pixelSize: Style.current.altPrimaryTextFontSize
      anchors.left: labelGasPrice.right
      anchors.leftMargin: Style.current.padding
    }
  }

  Item {
    id: gasUsedItem
    anchors.top: gasPriceItem.bottom
    anchors.topMargin: Style.current.padding
    anchors.left: parent.left
    anchors.leftMargin: Style.current.smallPadding
    height: children[0].height

    StyledText {
      id: labelGasUsed
      //% "Gas used"
      text: qsTrId("gas-used")
      font.pixelSize: Style.current.altPrimaryTextFontSize
      font.weight: Font.Medium
      color: Style.current.darkGrey
    }

    StyledText {
      id: valueGasUsed
      text: gasUsed
      font.pixelSize: Style.current.altPrimaryTextFontSize
      anchors.left: labelGasUsed.right
      anchors.leftMargin: Style.current.padding
    }
  }

  Item {
    id: nonceItem
    anchors.top: gasUsedItem.bottom
    anchors.topMargin: Style.current.padding
    anchors.left: parent.left
    anchors.leftMargin: Style.current.smallPadding
    height: children[0].height

    StyledText {
      id: labelNonce
      //% "Nonce"
      text: qsTrId("nonce")
      font.pixelSize: Style.current.altPrimaryTextFontSize
      font.weight: Font.Medium
      color: Style.current.darkGrey
    }

    StyledText {
      id: valueNonce
      text: nonce
      font.pixelSize: Style.current.altPrimaryTextFontSize
      anchors.left: labelNonce.right
      anchors.leftMargin: Style.current.padding
    }
  }
}
