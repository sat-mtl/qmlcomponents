// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import ca.qc.sat.qmlcomponents

// TabBar button styled to match CustomButton: sidebar background with hover,
// a primary-accent indicator and accent + bold text on the active tab. The
// indicator runs along the bottom edge — the horizontal-tab analogue of
// CustomButton's left bar. Drop it straight into a TabBar:
//
//   TabBar {
//       CustomTabButton { text: "Sources" }
//       CustomTabButton { text: "Options" }
//   }
//
// `checked` (driven by the TabBar) is the active state, mirroring CustomButton's
// `isActive`.
TabButton {
    id: control

    implicitHeight: Theme.sidebarButtonHeight
    padding: 0

    // Pointing-hand cursor without intercepting the button's own click/hover.
    HoverHandler { cursorShape: Qt.PointingHandCursor }

    background: Rectangle {
        color: control.hovered && !control.checked
               ? Theme.sidebarHoverColor
               : Theme.sidebarBackgroundColor
        radius: 0

        Behavior on color {
            ColorAnimation { duration: Theme.animationDuration / 2 }
        }

        Rectangle {
            id: activeIndicator
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
            height: 3
            color: Theme.primaryColor
            visible: control.checked
        }
    }

    contentItem: Text {
        text: control.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: control.checked
               ? Theme.primaryColor
               : (control.hovered ? Theme.sidebarTextColor : Theme.sidebarTextColorInactive)
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSizeBody
        font.bold: control.checked

        Behavior on color {
            ColorAnimation { duration: Theme.animationDuration / 2 }
        }
    }
}
