// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Layouts
import Score.UI as UI
import ca.qc.sat.qmlcomponents

// Framed texture preview of a process outlet (16:9 by default).
//
// NOTE: depends on the host-provided `Score.UI` module (ossia/score custom-app
// runtime). It cannot be instantiated outside a score app, so it is excluded
// from the standalone qmllint pass.
Rectangle {
    id: frame

    property real aspectRatio: 1280 / 720
    property string process: ""
    property int port: 0
    property bool showTexture: true

    property int frameHeight: 350

    Layout.preferredHeight: frameHeight
    Layout.minimumHeight: 200
    Layout.preferredWidth: frameHeight * aspectRatio
    Layout.minimumWidth: 350
    Layout.fillWidth: true

    color: "transparent"
    radius: Theme.borderRadius
    border.color: Theme.borderColor
    border.width: 1

    Item {
        anchors.fill: parent
        anchors.margins: 1
        clip: true

        Rectangle {
            anchors.fill: parent
            radius: frame.radius - 1
            color: Theme.backgroundColorTertiary
            layer.enabled: true
            layer.smooth: true

            UI.TextureSource {
                anchors.fill: parent
                process: frame.process
                port: frame.port
                visible: frame.showTexture
            }
        }
    }
}
