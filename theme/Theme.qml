// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
pragma Singleton
import QtQuick

// Shared application theme: a single switchable source of truth for colours,
// layout tokens and typography across SAT ossia/score apps.
//
// `dark` follows the OS colour scheme by default and tracks it live; an app
// that must pin a scheme sets `colorSchemeOverride`. Every component in this
// module reads `Theme.*` directly (no injected `appStyle` context property
// anymore). DarkPalette/LightPalette live in the same directory, so they
// resolve without importing the module here.
QtObject {
    id: theme

    // ---- Active palette selection ----
    // Qt.ColorScheme.Unknown follows the OS; Light/Dark pins the scheme.
    property int colorSchemeOverride: Qt.ColorScheme.Unknown
    // An OS that reports Unknown gets the dark palette: these apps are dark-first.
    property bool dark: colorSchemeOverride === Qt.ColorScheme.Unknown
                        ? Application.styleHints.colorScheme !== Qt.ColorScheme.Light
                        : colorSchemeOverride === Qt.ColorScheme.Dark
    readonly property DarkPalette darkPalette: DarkPalette {}
    readonly property LightPalette lightPalette: LightPalette {}

    // ---- Colours (typed access so qmllint can verify every token) ----
    // primaryColor / secondaryColor are the brand accent: writable so an app
    // can pin its own accent (e.g. koaia's teal) while keeping every other
    // token palette-driven. The default still tracks the active palette.
    property color primaryColor: dark ? darkPalette.primaryColor : lightPalette.primaryColor
    property color secondaryColor: dark ? darkPalette.secondaryColor : lightPalette.secondaryColor
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

    // ---- Brand ----
    // PNG rather than SVG: the qsvg image-format plugin is what
    // SCORE_QT_PLUGINS_NO_IMAGEFORMATS=1 is meant to drop, while QtGui decodes
    // PNG itself. @2x is picked up automatically on high-DPI screens.
    readonly property url satLogoSource: Qt.resolvedUrl(
        dark ? "images/logo-sat-white.png" : "images/logo-sat-black.png")

    // ---- Sidebar ----
    property int sidebarWidth: 100
    property int sidebarButtonWidth: 80
    property int sidebarButtonHeight: 50
}
