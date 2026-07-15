// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import ca.qc.sat.qmlcomponents

// SpinBox themed to match the shared palette (CustomComboBox / CustomTextField):
// a secondary-background field with a themed border and a primary-accent focus
// ring, themed text, and transparent +/- steppers that highlight when pressed.
// Editable by default.
SpinBox {
    id: control

    editable: true
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSizeBody
    implicitHeight: Theme.inputHeight

    contentItem: TextInput {
        z: 2
        text: control.displayText
        clip: width < implicitWidth
        padding: 6
        font: control.font
        color: control.enabled ? Theme.textColor : Theme.textColorSecondary
        selectionColor: Theme.primaryColor
        selectedTextColor: Theme.textColorOnAccent
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints
    }

    up.indicator: Rectangle {
        x: control.mirrored ? 0 : control.width - width
        height: control.height
        implicitWidth: Theme.inputHeight
        implicitHeight: Theme.inputHeight
        color: control.up.pressed ? Theme.buttonBgActive : "transparent"

        Rectangle {   // horizontal bar of the plus
            anchors.centerIn: parent
            width: parent.width / 3
            height: 2
            color: control.enabled ? Theme.textColor : Theme.textColorSecondary
        }
        Rectangle {   // vertical bar of the plus
            anchors.centerIn: parent
            width: 2
            height: parent.width / 3
            color: control.enabled ? Theme.textColor : Theme.textColorSecondary
        }
    }

    down.indicator: Rectangle {
        x: control.mirrored ? control.width - width : 0
        height: control.height
        implicitWidth: Theme.inputHeight
        implicitHeight: Theme.inputHeight
        color: control.down.pressed ? Theme.buttonBgActive : "transparent"

        Rectangle {   // bar of the minus
            anchors.centerIn: parent
            width: parent.width / 3
            height: 2
            color: control.enabled ? Theme.textColor : Theme.textColorSecondary
        }
    }

    background: Rectangle {
        implicitWidth: 120
        color: Theme.backgroundColorSecondary
        border.color: control.activeFocus ? Theme.primaryColor : Theme.borderColor
        border.width: 1
        radius: Theme.borderRadius
    }
}
