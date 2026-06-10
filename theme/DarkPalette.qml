// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick

// Dark colour palette. Layout/typography tokens live in Theme (shared
// across palettes); this object only carries colours.
QtObject {
    // Primary accent
    readonly property color primaryColor: "#0A84FF"
    readonly property color secondaryColor: "#5E5CE6"

    // Backgrounds
    readonly property color backgroundColor: "#1C1C1E"
    readonly property color backgroundColorSecondary: "#2C2C2E"
    readonly property color backgroundColorTertiary: "#3A3A3C"

    // Text
    readonly property color textColor: "#E5E5E7"
    readonly property color textColorSecondary: "#A1A1A6"
    readonly property color textColorOnAccent: "#FFFFFF"

    // Borders & separators
    readonly property color borderColor: "#48484A"
    readonly property color separatorColor: "#38383A"

    // Interactive states
    readonly property color buttonBgActive: "#30D158"
    readonly property color buttonBgInactive: "#3A3A3C"
    readonly property color buttonBgHover: "#48484A"
    readonly property color errorColor: "#FF453A"

    // Sidebar
    readonly property color sidebarBackgroundColor: "#2C2C2E"
    readonly property color sidebarTextColor: "#E5E5E7"
    readonly property color sidebarTextColorInactive: "#8E8E93"
    readonly property color sidebarHoverColor: "#3A3A3C"
}
