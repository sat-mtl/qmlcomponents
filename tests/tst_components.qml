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
        var sel = createTemporaryObject(cInput, tc, { advanced: false })
        verify(sel !== null)
        // Basic gating: without advanced, only Camera + Video file
        compare(sel.backends.length, 2)
        // Descriptor table exposes verified UUIDs
        compare(sel.descriptor("Camera").uuid, "d615690b-f2e2-447b-b70e-a800552db69c")
        compare(sel.descriptor("NDI").uuid, "ae78b7c6-6400-483e-b45b-fd6ff87ec700")
        verify(sel.descriptor("Video file").kind === "file")

        // Advanced + windows must expose NDI + Spout (not Syphon)
        sel.advanced = true
        sel.platformOs = "windows"
        verify(sel.backends.indexOf("NDI") !== -1)
        verify(sel.backends.indexOf("Spout") !== -1)
        verify(sel.backends.indexOf("Syphon") === -1)

        // macOS must expose NDI + Syphon (not Spout)
        sel.platformOs = "osx"
        verify(sel.backends.indexOf("Syphon") !== -1)
        verify(sel.backends.indexOf("Spout") === -1)
    }

    SignalSpy { id: backendSpy }

    function test_input_selector_signals() {
        var sel = createTemporaryObject(cInput, tc, { advanced: true, platformOs: "windows" })
        backendSpy.target = sel
        backendSpy.signalName = "backendSelected"
        sel.backendSelected("NDI")
        compare(backendSpy.count, 1)
    }
}
