// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Dialogs
import "InputBackends.js" as Backends
import ca.qc.sat.qmlcomponents

// Multi-backend video-input picker — PURE PRESENTATION.
//
// This widget performs NO Score.* calls. It exposes the selected backend and
// source through properties and signals; the host app owns the device
// lifecycle (Score.createDevice / setAddress / mixer). That separation is what
// makes the widget reusable across livepose / DomeportPro / future apps.
//
// Typical host wiring:
//   InputSourceSelector {
//       advanced: !!Util.environmentVariable("LIVEPOSE_ADVANCED_IO")
//       sources: discoveredNames          // app populates from enumeration
//       onBackendSelected: name => app.onBackendChanged(name)
//       onSourceSelected:  name => app.connectSource(descriptor(name)?.uuid ?? "", name)
//       onVideoFileSelected: path => app.useVideoFile(path)
//       onRefreshRequested: () => app.reenumerate(currentBackend)
//   }
ColumnLayout {
    id: selector

    // ---- Inputs from the host ----
    property string platformOs: Qt.platform.os
    property bool advanced: false
    property bool cameraEnabled: true      // apps without camera capture (DomeportPro/koaia) set false
    property var sources: []               // discovered source names for the current device backend
    property string statusText: ""         // optional host-provided hint ("No NDI sources found")

    // ---- Derived / current state ----
    property var backends: Backends.availableBackends(platformOs, advanced, cameraEnabled)
    property string currentBackend: backends.length > 0 ? backends[0] : ""
    property string currentSource: ""
    property string videoFilePath: ""

    readonly property bool deviceBackend: Backends.isDevice(currentBackend)
    readonly property bool typableSource: Backends.isTypable(currentBackend)

    // ---- Signals to the host ----
    signal backendSelected(string name)
    signal sourceSelected(string name)
    signal videoFileSelected(string path)
    signal refreshRequested

    // Expose the descriptor table so the host can map a name to its UUID.
    function descriptor(name) { return Backends.descriptor(name) }

    spacing: Theme.spacing

    CustomLabel {
        text: qsTr("Input Source")
        font.bold: true
        font.pixelSize: Theme.fontSizeSubtitle
    }

    // ---- Backend selector ----
    CustomComboBox {
        id: backendCombo
        Layout.fillWidth: true
        model: selector.backends
        onActivated: index => {
            selector.currentBackend = selector.backends[index]
            selector.currentSource = ""
            selector.backendSelected(selector.currentBackend)
        }
    }

    // ---- Device source row (Camera / NDI / Spout / Syphon) ----
    RowLayout {
        Layout.fillWidth: true
        visible: selector.deviceBackend
        spacing: Theme.spacing

        // Non-typable backend (Camera): pick from the discovered list only.
        CustomComboBox {
            id: pickCombo
            Layout.fillWidth: true
            visible: !selector.typableSource
            model: selector.sources
            onActivated: index => {
                selector.currentSource = selector.sources[index] ?? ""
                if (selector.currentSource !== "")
                    selector.sourceSelected(selector.currentSource)
            }
        }

        // Typable backend (NDI/Spout/Syphon): pick or type a source name.
        EditableComboBox {
            id: typeCombo
            Layout.fillWidth: true
            visible: selector.typableSource
            model: selector.sources
            onCommitted: value => {
                selector.currentSource = value
                if (value !== "")
                    selector.sourceSelected(value)
            }
        }

        Button {
            text: qsTr("Refresh")
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            onClicked: selector.refreshRequested()
        }
    }

    CustomLabel {
        visible: selector.deviceBackend && selector.statusText !== ""
        text: selector.statusText
        color: Theme.textColorSecondary
        font.pixelSize: Theme.fontSizeSmall
    }

    // ---- Video-file row ----
    RowLayout {
        Layout.fillWidth: true
        visible: !selector.deviceBackend
        spacing: Theme.spacing

        CustomTextField {
            id: videoPathField
            Layout.fillWidth: true
            placeholderText: qsTr("Select video file…")
            text: selector.videoFilePath
            onTextChanged: {
                selector.videoFilePath = text
                selector.videoFileSelected(text)
            }
        }

        Button {
            text: qsTr("Browse")
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            onClicked: videoFileDialog.open()
        }
    }

    FileDialog {
        id: videoFileDialog
        title: qsTr("Select Video File")
        nameFilters: ["Video Files (*.mp4 *.avi *.mov *.mkv *.webm)", "All Files (*)"]
        onAccepted: {
            if (!selectedFile)
                return
            var filePath = selectedFile.toString()
            if (filePath.startsWith("file://"))
                filePath = filePath.substring(7)
            videoPathField.text = filePath
        }
    }
}
