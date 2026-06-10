// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import ca.qc.sat.qmlcomponents

// Timestamped log pane. Self-contained: call log(message) / clear().
// The host app keeps a reference (e.g. `logger`) to push messages in.
Pane {
    id: logView

    property string title: qsTr("Application Log")

    background: Rectangle {
        color: Theme.backgroundColor
    }

    function log(message) {
        var time = new Date();
        var timestamp = time.getHours() + ":" +
                       (time.getMinutes() < 10 ? "0" : "") + time.getMinutes() + ":" +
                       (time.getSeconds() < 10 ? "0" : "") + time.getSeconds();
        logTextArea.append("[" + timestamp + "] " + message);
        console.log(message);
    }

    function clear() {
        logTextArea.text = "";
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.padding
        spacing: Theme.spacing

        CustomLabel {
            text: logView.title
            font.bold: true
            font.pixelSize: Theme.fontSizeTitle
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            TextArea {
                id: logTextArea
                text: ""
                readOnly: true
                wrapMode: TextEdit.Wrap
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeBody
                color: Theme.textColor
            }
        }

        RowLayout {
            spacing: Theme.spacing

            Button {
                text: qsTr("Clear Log")
                font.family: Theme.fontFamily
                onClicked: logView.clear()
            }

            Item { Layout.fillWidth: true }
        }
    }
}
