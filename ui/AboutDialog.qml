// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import ca.qc.sat.qmlcomponents

// Generic "About" dialog skeleton shared by the SAT apps. The host sets the
// app strings + icon and provides the footer/partner logos as a data list, so
// every app reuses the same layout (app logo, name, description, details +
// website link, partner logos, Close) and only varies the content.
//
//   AboutDialog {
//       appName: "MyApp"; logoPath: "..."; appDetails: "…"
//       partnerLogos: [
//           { source: "sat.png",   website: "https://www.sat.qc.ca" },
//           { source: "ossia.png", website: "https://ossia.io" }
//       ]
//   }
//
// `partnerLogos` is an array of { source, website } (website optional). Because
// it is plain data, theme-aware logos are just an expression in the host, e.g.
// `source: Theme.dark ? logoDark : logoLight`. Logo paths must resolve in the
// host app (qrc or absolute path).
Dialog {
    id: aboutDialog

    property string appName: ""
    property string appDescription: qsTr("A tool developed by the Société des arts technologiques")
    property string appDetails: ""
    property string appWebsite: "https://www.sat.qc.ca"

    property url logoPath
    property var partnerLogos: []

    property var parentWindow: null

    modal: true
    width: parentWindow ? parentWindow.width : 800
    height: parentWindow ? parentWindow.height : 600
    x: 0
    y: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 30

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: aboutDialog.logoPath
            visible: aboutDialog.logoPath != ""
            fillMode: Image.PreserveAspectFit
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
        }

        CustomLabel {
            Layout.alignment: Qt.AlignHCenter
            text: aboutDialog.appName
            font.pixelSize: 32
            font.bold: true
        }

        CustomLabel {
            Layout.alignment: Qt.AlignHCenter
            text: aboutDialog.appDescription
            font.pixelSize: Theme.fontSizeSubtitle
        }

        Text {
            Layout.fillWidth: true
            Layout.maximumWidth: 600
            Layout.alignment: Qt.AlignHCenter
            text: aboutDialog.appDetails
                  + (aboutDialog.appWebsite ? " <a href=\"" + aboutDialog.appWebsite + "\">" + aboutDialog.appWebsite + "</a>" : "")
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeBody
            color: Theme.textColor
            linkColor: Theme.primaryColor
            onLinkActivated: url => Qt.openUrlExternally(url)
        }

        Item { Layout.fillHeight: true }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 20
            spacing: 40

            Repeater {
                model: aboutDialog.partnerLogos
                delegate: Image {
                    required property var modelData
                    source: modelData.source ? modelData.source : ""
                    visible: source != ""
                    fillMode: Image.PreserveAspectFit
                    Layout.preferredWidth: 180
                    Layout.preferredHeight: 90
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        enabled: modelData.website ? modelData.website !== "" : false
                        onClicked: Qt.openUrlExternally(modelData.website)
                    }
                }
            }
        }

        Button {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Close")
            font.family: Theme.fontFamily
            onClicked: aboutDialog.close()
        }
    }
}
