// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import ca.qc.sat.qmlcomponents

Switch {
    id: control

    indicator: Rectangle {
        implicitWidth: 48
        implicitHeight: 26
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: control.checked ? Theme.buttonBgActive : Theme.buttonBgInactive
        border.color: control.checked ? Theme.buttonBgActive : Theme.borderColor

        Rectangle {
            x: control.checked ? parent.width - width - 2 : 2
            y: 2
            width: 22
            height: 22
            radius: 11
            color: Theme.backgroundColorSecondary
            border.color: control.checked ? Theme.buttonBgActive : Theme.borderColor

            Behavior on x {
                NumberAnimation { duration: 150 }
            }
        }
    }

    contentItem: Text {
        text: control.text
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSizeBody
        color: Theme.textColor
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + 8
    }
}
