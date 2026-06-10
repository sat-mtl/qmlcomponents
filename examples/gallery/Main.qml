// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
//
// Standalone gallery: instantiates every (score-free) component so the module
// can be smoke-tested with the bare `qml` runtime, no ossia/score needed.
//   qml -I <importpath> examples/gallery/Main.qml
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import ca.qc.sat.qmlcomponents

ApplicationWindow {
    id: win
    width: 480
    height: 760
    visible: true
    title: "ca.qc.sat.qmlcomponents — gallery"
    color: Theme.backgroundColor

    menuBar: AppMenuBar { aboutDialog: about }

    AboutDialog {
        id: about
        appName: "Gallery"
        appDetails: "Component gallery for the shared SAT QML module."
        parentWindow: win
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            width: win.width - 2 * Theme.padding
            x: Theme.padding
            spacing: Theme.spacing

            CustomLabel {
                text: "Theme + controls"
                font.bold: true
                font.pixelSize: Theme.fontSizeTitle
                Layout.topMargin: Theme.padding
            }

            CustomSwitch {
                text: "Dark theme"
                checked: Theme.dark
                onToggled: Theme.dark = checked
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: Theme.spacing
                CustomButton {
                    Layout.preferredWidth: 120
                    text: "Run"
                    isActive: true
                }
                CustomButton {
                    Layout.preferredWidth: 120
                    text: "Logs"
                }
            }

            CustomLabel { text: "A custom text field" }
            CustomTextField {
                Layout.fillWidth: true
                placeholderText: "Type here…"
            }

            CustomLabel { text: "A custom combo box" }
            CustomComboBox {
                Layout.fillWidth: true
                model: ["BlazePose", "RTMPose", "YOLOPose"]
            }

            CustomLabel { text: "An editable combo box" }
            EditableComboBox {
                Layout.fillWidth: true
                model: ["camera 0", "camera 1"]
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: Theme.separatorColor }

            InputSourceSelector {
                Layout.fillWidth: true
                allowedBackends: ["Camera", "Video file", "NDI", "Spout", "Syphon"]
                platformOs: "windows"   // force-show NDI + Spout in the gallery
                sources: ["OBS (NDI)", "Resolume"]
                statusText: "Type a source if it is not listed"
            }

            Item { Layout.fillHeight: true; Layout.preferredHeight: Theme.padding }
        }
    }
}
