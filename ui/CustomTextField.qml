// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import ca.qc.sat.qmlcomponents

TextField {
    id: root

    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSizeBody
    color: enabled ? Theme.textColor : Theme.textColorSecondary
    background: Rectangle {
        color: Theme.backgroundColorSecondary
        border.color: Theme.borderColor
        border.width: 1
        radius: Theme.borderRadius
    }
    height: Theme.inputHeight
}
