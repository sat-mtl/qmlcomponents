// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
// Renders a panel of components and saves a screenshot (headless via offscreen).
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtTest
import ca.qc.sat.qmlcomponents

TestCase {
    id: tc
    name: "visual"
    width: 460
    height: 720
    visible: true
    when: windowShown

    Rectangle {
        id: panel
        anchors.fill: parent
        color: Theme.backgroundColor

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Theme.padding
            spacing: Theme.spacing

            CustomLabel {
                text: "ca.qc.sat.qmlcomponents"
                font.bold: true
                font.pixelSize: Theme.fontSizeTitle
            }
            RowLayout {
                spacing: Theme.spacing
                CustomButton { Layout.preferredWidth: 140; text: "Run"; isActive: true }
                CustomButton { Layout.preferredWidth: 140; text: "Logs" }
            }
            CustomLabel { text: "ONNX model file" }
            CustomTextField { Layout.fillWidth: true; placeholderText: "Select model…" }
            CustomLabel { text: "AI model" }
            CustomComboBox { Layout.fillWidth: true; model: ["BlazePose", "RTMPose", "YOLOPose"]; currentIndex: 0 }
            CustomSwitch { text: "Draw skeleton"; checked: true }
            Rectangle { Layout.fillWidth: true; height: 1; color: Theme.separatorColor }
            InputSourceSelector {
                Layout.fillWidth: true
                advanced: true
                platformOs: "windows"
                sources: ["OBS (NDI)", "Resolume Arena"]
                statusText: "Type a source if it is not listed"
            }
            Item { Layout.fillHeight: true }
        }
    }

    function test_grab() {
        wait(250)
        var img = grabImage(panel)
        img.save("/tmp/gallery.png")
        verify(true)
    }
}
