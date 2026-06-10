// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import ca.qc.sat.qmlcomponents

// Sidebar-style navigation button with active indicator and hover.
Item {
    id: root

    property alias text: buttonText.text
    property alias color: buttonBackground.color
    property bool isActive: false
    signal clicked

    height: Theme.sidebarButtonHeight
    clip: false

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: mouseArea.containsMouse && !root.isActive
               ? Theme.sidebarHoverColor
               : Theme.sidebarBackgroundColor
        radius: 0

        Behavior on color {
            ColorAnimation { duration: Theme.animationDuration / 2 }
        }

        Rectangle {
            id: activeIndicator
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 3
            color: Theme.primaryColor
            visible: root.isActive
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked()
            cursorShape: Qt.PointingHandCursor
        }

        Text {
            id: buttonText
            text: "Button"
            anchors.centerIn: parent
            color: root.isActive
                   ? Theme.primaryColor
                   : (mouseArea.containsMouse ? Theme.sidebarTextColor : Theme.sidebarTextColorInactive)
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            font.bold: root.isActive

            Behavior on color {
                ColorAnimation { duration: Theme.animationDuration / 2 }
            }
        }
    }
}
