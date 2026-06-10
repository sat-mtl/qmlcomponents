// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
pragma Singleton
import QtQuick

// Shared application theme: a single switchable source of truth for colours,
// layout tokens and typography across SAT ossia/score apps.
//
// Apps select the active palette with `Theme.dark = true|false`; every
// component in this module reads `Theme.*` directly (no injected `appStyle`
// context property anymore). DarkPalette/LightPalette live in the same
// directory, so they resolve without importing the module here.
QtObject {
    id: theme

    // ---- Active palette selection ----
    property bool dark: true
    readonly property DarkPalette darkPalette: DarkPalette {}
    readonly property LightPalette lightPalette: LightPalette {}

    // ---- Colours (typed access so qmllint can verify every token) ----
    readonly property color primaryColor: dark ? darkPalette.primaryColor : lightPalette.primaryColor
    readonly property color secondaryColor: dark ? darkPalette.secondaryColor : lightPalette.secondaryColor
    readonly property color backgroundColor: dark ? darkPalette.backgroundColor : lightPalette.backgroundColor
    readonly property color backgroundColorSecondary: dark ? darkPalette.backgroundColorSecondary : lightPalette.backgroundColorSecondary
    readonly property color backgroundColorTertiary: dark ? darkPalette.backgroundColorTertiary : lightPalette.backgroundColorTertiary
    readonly property color textColor: dark ? darkPalette.textColor : lightPalette.textColor
    readonly property color textColorSecondary: dark ? darkPalette.textColorSecondary : lightPalette.textColorSecondary
    readonly property color textColorOnAccent: dark ? darkPalette.textColorOnAccent : lightPalette.textColorOnAccent
    readonly property color borderColor: dark ? darkPalette.borderColor : lightPalette.borderColor
    readonly property color separatorColor: dark ? darkPalette.separatorColor : lightPalette.separatorColor
    readonly property color buttonBgActive: dark ? darkPalette.buttonBgActive : lightPalette.buttonBgActive
    readonly property color buttonBgInactive: dark ? darkPalette.buttonBgInactive : lightPalette.buttonBgInactive
    readonly property color buttonBgHover: dark ? darkPalette.buttonBgHover : lightPalette.buttonBgHover
    readonly property color errorColor: dark ? darkPalette.errorColor : lightPalette.errorColor
    readonly property color sidebarBackgroundColor: dark ? darkPalette.sidebarBackgroundColor : lightPalette.sidebarBackgroundColor
    readonly property color sidebarTextColor: dark ? darkPalette.sidebarTextColor : lightPalette.sidebarTextColor
    readonly property color sidebarTextColorInactive: dark ? darkPalette.sidebarTextColorInactive : lightPalette.sidebarTextColorInactive
    readonly property color sidebarHoverColor: dark ? darkPalette.sidebarHoverColor : lightPalette.sidebarHoverColor

    // ---- Layout tokens (shared across palettes) ----
    property int windowWidth: 600
    property int windowHeight: 1000
    property int windowMinWidth: 600
    property int windowMinHeight: 1000
    property int padding: 16
    property int spacing: 12
    property int inputHeight: 36
    property int buttonHeight: 36

    // ---- Typography ----
    property int fontSizeTitle: 20
    property int fontSizeSubtitle: 16
    property int fontSizeBody: 14
    property int fontSizeSmall: 12
    property string fontFamily: "DM Sans"

    // ---- Misc ----
    property int borderRadius: 8
    property int animationDuration: 200

    // ---- Sidebar ----
    property int sidebarWidth: 100
    property int sidebarButtonWidth: 80
    property int sidebarButtonHeight: 50
}
