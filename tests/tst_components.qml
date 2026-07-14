// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
//
// Headless instantiation smoke test for the score-free components.
//   qmltestrunner -input tests -import <importpath>
import QtQuick
import QtTest
import ca.qc.sat.qmlcomponents

TestCase {
    id: tc
    name: "qmlcomponents"

    Component { id: cButton; CustomButton {} }
    Component { id: cLabel; CustomLabel {} }
    Component { id: cTextField; CustomTextField {} }
    Component { id: cSwitch; CustomSwitch {} }
    Component { id: cCombo; CustomComboBox {} }
    Component { id: cEditCombo; EditableComboBox {} }
    Component { id: cMenu; AppMenuBar {} }
    Component { id: cAbout; AboutDialog {} }
    Component { id: cLog; LogView {} }
    Component { id: cInput; InputSourceSelector {} }

    function test_theme_singleton() {
        verify(Theme.padding > 0)
        verify(Theme.fontFamily.length > 0)
        // palette switch must change a colour (compare string forms; QColor
        // value comparison via !== is unreliable in QML JS)
        Theme.dark = true
        compare(Theme.dark, true)
        var darkBg = Theme.backgroundColor.toString()
        Theme.dark = false
        compare(Theme.dark, false)
        var lightBg = Theme.backgroundColor.toString()
        Theme.dark = true
        verify(darkBg !== lightBg, "dark/light backgrounds must differ: " + darkBg + " vs " + lightBg)
    }

    function test_instantiate_data() {
        return [
            { tag: "CustomButton", comp: cButton },
            { tag: "CustomLabel", comp: cLabel },
            { tag: "CustomTextField", comp: cTextField },
            { tag: "CustomSwitch", comp: cSwitch },
            { tag: "CustomComboBox", comp: cCombo },
            { tag: "EditableComboBox", comp: cEditCombo },
            { tag: "AppMenuBar", comp: cMenu },
            { tag: "AboutDialog", comp: cAbout },
            { tag: "LogView", comp: cLog },
            { tag: "InputSourceSelector", comp: cInput },
        ]
    }

    function test_instantiate(row) {
        var o = createTemporaryObject(row.comp, tc)
        verify(o !== null, row.tag + " failed to instantiate")
    }

    function test_input_selector_logic() {
        var sel = createTemporaryObject(cInput, tc, { allowedBackends: ["Camera", "Video file"] })
        verify(sel !== null)
        // The picker offers exactly the host-allowed, platform-valid entries
        compare(sel.backends.length, 2)
        // Descriptor table exposes verified UUIDs
        compare(sel.descriptor("Camera").uuid, "d615690b-f2e2-447b-b70e-a800552db69c")
        compare(sel.descriptor("NDI").uuid, "ae78b7c6-6400-483e-b45b-fd6ff87ec700")
        verify(sel.descriptor("Video file").kind === "video")
        verify(sel.descriptor("Image file").kind === "image")

        // A full allow-list on Windows must expose NDI + Spout (not Syphon)
        sel.allowedBackends = ["Camera", "Video file", "NDI", "Spout", "Syphon"]
        sel.platformOs = "windows"
        verify(sel.backends.indexOf("NDI") !== -1)
        verify(sel.backends.indexOf("Spout") !== -1)
        verify(sel.backends.indexOf("Syphon") === -1)

        // macOS must expose NDI + Syphon (not Spout)
        sel.platformOs = "osx"
        verify(sel.backends.indexOf("Syphon") !== -1)
        verify(sel.backends.indexOf("Spout") === -1)
    }

    function test_input_selector_allowlist() {
        // The host can omit Camera (DomeportPro/koaia) — only what it allows shows.
        var sel = createTemporaryObject(cInput, tc, {
            allowedBackends: ["Video file", "NDI", "Spout", "Syphon"], platformOs: "windows" })
        verify(sel !== null)
        verify(sel.backends.indexOf("Camera") === -1)
        verify(sel.backends.indexOf("Video file") !== -1)
        verify(sel.backends.indexOf("NDI") !== -1)
        verify(sel.backends.indexOf("Spout") !== -1)
        // Unknown names and platform-invalid entries are dropped
        sel.allowedBackends = ["Video file", "Bogus", "Syphon"]
        compare(sel.backends.length, 1)
        compare(sel.backends[0], "Video file")
    }

    function test_about_partner_logos() {
        // The shared dialog accepts a data list of footer/partner logos so
        // every app reuses the same skeleton and only varies the content.
        var dlg = createTemporaryObject(cAbout, tc, {
            appName: "X",
            partnerLogos: [
                { source: "a.png", website: "https://a" },
                { source: "b.png" }
            ]
        })
        verify(dlg !== null)
        compare(dlg.partnerLogos.length, 2)
        compare(dlg.partnerLogos[0].website, "https://a")
    }

    function test_theme_accent_override() {
        // The brand accent is writable so an app can pin its own colour.
        var saved = Theme.primaryColor.toString()
        Theme.primaryColor = "#006B85"
        compare(Theme.primaryColor.toString(), "#006b85")
        Theme.primaryColor = saved
    }

    SignalSpy { id: backendSpy }

    function test_input_selector_signals() {
        var sel = createTemporaryObject(cInput, tc, {
            allowedBackends: ["Camera", "Video file", "NDI", "Spout"], platformOs: "windows" })
        backendSpy.target = sel
        backendSpy.signalName = "backendSelected"
        sel.backendSelected("NDI")
        compare(backendSpy.count, 1)
    }

    function test_backend_combo_reflects_currentBackend() {
        // Programmatic currentBackend changes (e.g. a host drag-and-drop that
        // picks the matching file backend) must move the visible combo selection.
        // Kept to non-device backends: realizing/tearing down the typable device
        // EditableComboBox segfaults on Qt 6.4.x offscreen, and drops only ever
        // select the video/image file backends anyway.
        var sel = createTemporaryObject(cInput, tc, {
            allowedBackends: ["Video file", "Image file"], platformOs: "windows" })
        verify(sel !== null)
        var combo = findChild(sel, "backendCombo")
        verify(combo !== null, "backendCombo not found")
        compare(combo.currentIndex, sel.backends.indexOf(sel.currentBackend))
        sel.currentBackend = "Image file"
        compare(combo.currentIndex, sel.backends.indexOf("Image file"))
        sel.currentBackend = "Video file"
        compare(combo.currentIndex, sel.backends.indexOf("Video file"))
    }
}
