pragma ComponentBehavior: Bound

import Quickshell

Scope {
    id: root

    property var theme

    property int horizontalMargin: 32

    Variants {
        model: Quickshell.screens

        // qmllint disable uncreatable-type
        PanelWindow {
            id: panel

            required property var modelData
            screen: modelData

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                left: root.horizontalMargin
                right: root.horizontalMargin
            }

            implicitHeight: 30

            // left
            NiriWorkspaces {
                output: panel.screen.name
                activeTextColor: root.theme.foreground
                inactiveTextColor: root.theme.background
                activeChipColor: root.theme.foreground
                inactiveChipColor: root.theme.bg2
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
            }
            // ------------------

            // middle
            ClockWidget {
                dateFormat: "hh:mm"
                anchors.centerIn: parent
                color: root.theme.foreground
            }
            // ------------------

            // right
            BluetoothWidget {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                chipColor: root.theme.bg2
                textColor: root.theme.foreground
                bgColor: root.theme.background
            }

            BatteryIndicator {
                lowBatteryColor: root.theme.warning
                backgroundColor: root.theme.bg2
                color: root.theme.foreground
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
            // ------------------
        }
    }
}
