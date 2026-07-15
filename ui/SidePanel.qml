// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import ca.qc.sat.qmlcomponents

// Slide-over side panel that animates in from the right edge of its parent.
//
// A discrete hamburger button toggles the panel: pinned to the top-right when
// closed, it slides left to sit just outside the panel as it opens. A light
// scrim fades in behind the open panel and dismisses it when clicked.
// Give the component a parent that fills the window and it overlays everything
// declared before it:
//
//   SidePanel {
//       anchors.fill: parent
//       ScrollView { anchors.fill: parent; /* host content */ }
//   }
//
// Child items declared inside a SidePanel are its panel body: they are the
// default `content` slot and fill the whole panel. `open` is bindable from
// the host and `panelWidth` sets the width of the sliding surface.
Item {
    id: root

    property bool open: false
    property int panelWidth: 320

    // Host-injected panel body (default slot). Children declared inside a
    // SidePanel are reparented into the content holder below.
    default property alias content: contentHolder.data

    // Overlay above sibling content declared earlier in the parent.
    z: 100

    // #rrggbb form of the active text colour for embedding in the SVG markup
    // (SVG does not accept Qt's #aarrggbb string form).
    readonly property string _iconColor: {
        function h(v) { var s = Math.round(v * 255).toString(16); return s.length < 2 ? "0" + s : s }
        return "#" + h(Theme.textColor.r) + h(Theme.textColor.g) + h(Theme.textColor.b)
    }

    // ---- Scrim: dims the content and closes the panel when clicked away ----
    Rectangle {
        id: scrim
        anchors.fill: parent
        color: "#000000"
        opacity: root.open ? 0.35 : 0.0
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: Theme.animationDuration; easing.type: Easing.InOutQuad }
        }

        MouseArea {
            anchors.fill: parent
            enabled: root.open
            onClicked: root.open = false
        }
    }

    // ---- Sliding panel ----
    Rectangle {
        id: panel
        objectName: "panel"
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: root.panelWidth
        x: root.open ? parent.width - width : parent.width
        color: Theme.backgroundColor

        Behavior on x {
            NumberAnimation { duration: Theme.animationDuration; easing.type: Easing.InOutQuad }
        }

        // Left-edge separator against the underlying content.
        Rectangle {
            anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
            width: 1
            color: Theme.separatorColor
        }

        // Swallow clicks so they do not fall through to the scrim/content.
        MouseArea { anchors.fill: parent }

        // Host content area. The toggle button slides out to the left of the
        // panel when open, so the body gets the full panel — no reserved strip.
        Item {
            id: contentHolder
            anchors.fill: parent
        }
    }

    // ---- Discrete hamburger toggle, pinned to the top-right corner ----
    Item {
        id: toggle
        width: Theme.buttonHeight
        height: Theme.buttonHeight
        anchors.top: parent.top
        anchors.topMargin: Theme.padding
        // Pinned top-right when closed; slides left to just outside the panel's
        // left edge as it opens, in lockstep with the panel's slide.
        x: root.open
           ? parent.width - root.panelWidth - width - Theme.padding
           : parent.width - width - Theme.padding
        z: 1   // above the panel so it always toggles

        Behavior on x {
            NumberAnimation { duration: Theme.animationDuration; easing.type: Easing.InOutQuad }
        }

        Rectangle {
            anchors.fill: parent
            radius: Theme.borderRadius
            color: toggleArea.containsMouse ? Theme.buttonBgHover : "transparent"
            Behavior on color { ColorAnimation { duration: Theme.animationDuration / 2 } }
        }

        Image {
            objectName: "hamburgerIcon"
            anchors.centerIn: parent
            sourceSize.width: 22
            sourceSize.height: 22
            // Inline SVG hamburger icon, tinted with the active theme colour.
            source: "data:image/svg+xml;utf8," + encodeURIComponent(
                '<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22">'
                + '<g stroke="' + root._iconColor + '" stroke-width="2" stroke-linecap="round">'
                + '<line x1="3" y1="6"  x2="19" y2="6"/>'
                + '<line x1="3" y1="11" x2="19" y2="11"/>'
                + '<line x1="3" y1="16" x2="19" y2="16"/>'
                + '</g></svg>')
        }

        MouseArea {
            id: toggleArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.open = !root.open
        }
    }
}
