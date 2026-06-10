// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick

// Light colour palette. Layout/typography tokens live in Theme (shared
// across palettes); this object only carries colours.
QtObject {
    // Primary accent
    readonly property color primaryColor: "#007AFF"
    readonly property color secondaryColor: "#5856D6"

    // Backgrounds
    readonly property color backgroundColor: "#F2F2F7"
    readonly property color backgroundColorSecondary: "#FFFFFF"
    readonly property color backgroundColorTertiary: "#E5E5EA"

    // Text
    readonly property color textColor: "#1C1C1E"
    readonly property color textColorSecondary: "#8E8E93"
    readonly property color textColorOnAccent: "#FFFFFF"

    // Borders & separators
    readonly property color borderColor: "#C6C6C8"
    readonly property color separatorColor: "#D1D1D6"

    // Interactive states
    readonly property color buttonBgActive: "#34C759"
    readonly property color buttonBgInactive: "#E5E5EA"
    readonly property color buttonBgHover: "#D1D1D6"
    readonly property color errorColor: "#FF3B30"

    // Sidebar
    readonly property color sidebarBackgroundColor: "#E8E8ED"
    readonly property color sidebarTextColor: "#1C1C1E"
    readonly property color sidebarTextColorInactive: "#8E8E93"
    readonly property color sidebarHoverColor: "#D1D1D6"
}
