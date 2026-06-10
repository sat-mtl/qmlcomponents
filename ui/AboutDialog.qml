// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import ca.qc.sat.qmlcomponents

// Generic "About" dialog. All app-specific strings and image paths are
// properties with neutral defaults; the host app sets appName, logoPath, etc.
// (logo paths must resolve in the host app — e.g. a qrc or absolute path).
Dialog {
    id: aboutDialog

    property string appName: ""
    property string appDescription: qsTr("A tool developed by the Société des arts technologiques")
    property string appDetails: ""
    property string appWebsite: "https://www.sat.qc.ca"

    property url logoPath
    property url satLogoPath
    property string satWebsite: "https://www.sat.qc.ca"
    property url ossiaLogoPath
    property string ossiaWebsite: "https://ossia.io"

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

            Image {
                source: aboutDialog.satLogoPath
                visible: aboutDialog.satLogoPath != ""
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 180
                Layout.preferredHeight: 90
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.openUrlExternally(aboutDialog.satWebsite)
                }
            }

            Image {
                source: aboutDialog.ossiaLogoPath
                visible: aboutDialog.ossiaLogoPath != ""
                fillMode: Image.PreserveAspectFit
                Layout.preferredWidth: 180
                Layout.preferredHeight: 90
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.openUrlExternally(aboutDialog.ossiaWebsite)
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
