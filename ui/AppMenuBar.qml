// SPDX-License-Identifier: AGPL-3.0-or-later
// © Société des arts technologiques
import QtQuick
import QtQuick.Controls.Basic
import ca.qc.sat.qmlcomponents

MenuBar {
    id: menuBar

    property var aboutDialog: null

    Menu {
        title: qsTr("&Help")
        Action {
            text: qsTr("&About")
            enabled: menuBar.aboutDialog !== null
            onTriggered: {
                if (menuBar.aboutDialog)
                    menuBar.aboutDialog.open()
            }
        }
    }
}
