// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import ca.qc.sat.qmlcomponents

ComboBox {
    id: control

    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSizeBody

    delegate: ItemDelegate {
        required property var modelData
        required property int index
        height: 25
        width: control.width
        contentItem: Text {
            text: modelData
            color: Theme.textColor
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
        background: Rectangle {
            color: highlighted ? Theme.primaryColor : Theme.backgroundColorSecondary
        }
    }

    contentItem: Text {
        leftPadding: 12
        rightPadding: control.indicator.width + control.spacing
        text: control.displayText
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSizeBody
        color: Theme.textColor
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: Theme.inputHeight
        color: Theme.backgroundColorSecondary
        border.color: control.pressed ? Theme.primaryColor : Theme.borderColor
        border.width: 1
        radius: Theme.borderRadius
    }

    popup: Popup {
        y: control.height
        width: control.width
        height: Math.min(400, contentHeight)
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            height: 200
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator {}
        }

        background: Rectangle {
            color: Theme.backgroundColorSecondary
            border.color: Theme.borderColor
            border.width: 1
            radius: Theme.borderRadius
        }
    }
}
