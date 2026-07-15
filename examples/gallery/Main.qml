// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
//
// Standalone gallery: instantiates every (score-free) component so the module
// can be smoke-tested with the bare `qml` runtime, no ossia/score needed.
//   mkdir -p "/tmp/qml-components-imports/ca/qc/sat"
//   ln -s "$PWD" "/tmp/qml-components-imports/ca/qc/sat/qmlcomponents"
//   /usr/lib/qt6/bin/qml -I /tmp/qml-components-imports examples/gallery/Main.qml
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import ca.qc.sat.qmlcomponents

ApplicationWindow {
    id: win
    width: 480
    height: 720
    visible: true
    title: "ca.qc.sat.qmlcomponents — gallery"
    color: Theme.backgroundColor

    menuBar: AppMenuBar { aboutDialog: about }

    ApplicationWindow {
        id: contentWindow
        width: 1280
        height: 720
        x: win.x + win.width
        y: win.y
        visible: true
        title: "ca.qc.sat.qmlcomponents — content"
        color: Theme.backgroundColor

        CustomLabel {
            anchors.centerIn: parent
            text: "Content window — use the ☰ button to reveal the side panel"
            color: Theme.textColorSecondary
        }

        SidePanel {
            anchors.fill: parent
            panelWidth: 480
            edge: Qt.RightEdge
            open: true

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                TabBar {
                    id: panelTabs
                    Layout.fillWidth: true

                    CustomTabButton { text: "Sources" }
                    CustomTabButton { text: "Options" }
                }

                StackLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    currentIndex: panelTabs.currentIndex

                    ScrollView {
                        id: sourcesScroll
                        contentWidth: availableWidth
                        clip: true

                        ColumnLayout {
                            width: win.width - 2 * Theme.padding
                            x: Theme.padding
                            spacing: Theme.spacing

                            CustomLabel {
                                text: "Source"
                                font.bold: true
                                font.pixelSize: Theme.fontSizeTitle
                                Layout.topMargin: Theme.padding
                            }

                            CustomSwitch {
                                text: "Test"
                                checked: testEnabled
                                onToggled: testEnabled = checked

                                property bool testEnabled: true
                            }

                            InputSourceSelector {
                                Layout.fillWidth: true
                                allowedBackends: ["Camera", "Video file", "NDI", "Spout", "Syphon"]
                                platformOs: "windows"   // force-show NDI + Spout in the gallery
                                sources: ["OBS (NDI)", "Resolume"]
                                statusText: "Type a source if it is not listed"
                            }
                        }
                    }

                    ScrollView {
                        id: optionsScroll
                        contentWidth: availableWidth
                        clip: true

                        ColumnLayout {
                            width: win.width - 2 * Theme.padding
                            x: Theme.padding
                            spacing: Theme.spacing

                            CustomLabel {
                                id: optionsTitle
                                text: "Options"
                                font.bold: true
                                font.pixelSize: Theme.fontSizeTitle
                                Layout.topMargin: Theme.padding
                            }

                            RowLayout {
                                Layout.fillWidth: true

                                CustomLabel { text: "Model" }
                                EditableComboBox {
                                    id: modelComboBox
                                    Layout.fillWidth: true
                                    model: ["Model 0", "Model 1"]
                                }

                            }

                            Rectangle { Layout.fillWidth: true; height: 1; color: Theme.separatorColor }

                            CustomLabel {
                                id: cameraTitle
                                text: "Camera"
                                font.bold: true
                                font.pixelSize: Theme.fontSizeTitle
                                Layout.topMargin: Theme.padding
                            }

                            RowLayout {
                                Layout.fillWidth: true

                                CustomLabel { text: "FoV" }
                                SpinBox {
                                    id: fovSpinBox
                                    editable: true
                                    Layout.fillWidth: true
                                    from: 60
                                    to: 120
                                    value: 90
                                    stepSize: 1
                                    font.family: Theme.fontFamily
                                    font.pixelSize: Theme.fontSizeBody
                                }

                            }

                            CustomSwitch {
                                id: flySwitch
                                text: "Fly mode"
                                checked: flyEnabled
                                onToggled: flyEnabled = checked

                                property bool flyEnabled: false
                            }

                            Rectangle { Layout.fillWidth: true; height: 1; color: Theme.separatorColor }

                            CustomLabel {
                                id: advancedTitle
                                text: "Advanced"
                                font.bold: true
                                font.pixelSize: Theme.fontSizeTitle
                                Layout.topMargin: Theme.padding
                            }

                            CustomSwitch {
                                id: debugSwitch
                                text: "Debug"
                                checked: debugEnabled
                                onToggled: debugEnabled = checked

                                property bool debugEnabled: false
                            }

                            CustomButton {
                                id: aboutButton
                                Layout.preferredWidth: parent.width
                                height: Theme.buttonHeight
                                text: "About"
                                onClicked: contentAbout.open()
                            }

                        }
                    }
                }
            }
        }

        AboutDialog {
            id: contentAbout
            appName: "Gallery"
            appDetails: "Component gallery for the shared SAT QML module."
            parentWindow: contentWindow
        }
    }

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

            CustomLabel { text: "A custom content window" }
            CustomButton {
                Layout.preferredWidth: parent.width
                height: Theme.buttonHeight
                text: contentWindow.visible ? "Close" : "Open"
                isActive: contentWindow.visible
                onClicked: contentWindow.visible = !contentWindow.visible
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
