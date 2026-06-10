// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import ca.qc.sat.qmlcomponents

// CustomComboBox variant that lets the user either pick a discovered entry
// or type a value that is not in the list (e.g. an NDI/Spout source name on a
// remote machine that does not enumerate). Emits `committed` on pick or on
// Enter after typing.
ComboBox {
    id: control
    editable: true
    selectTextByMouse: true

    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSizeBody

    // Fired with the chosen/typed text whenever the user commits a value.
    signal committed(string value)

    onActivated: index => committed(textAt(index))
    onAccepted: committed(editText)

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

    contentItem: TextField {
        leftPadding: 12
        rightPadding: control.indicator.width + control.spacing
        text: control.editText
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSizeBody
        color: Theme.textColor
        selectByMouse: true
        verticalAlignment: Text.AlignVCenter
        placeholderText: control.editable ? qsTr("Pick or type a source…") : ""
        placeholderTextColor: Theme.textColorSecondary
        background: null
        onAccepted: control.accepted()
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
