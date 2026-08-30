import Quickshell

Scope {
    id: root

    property var theme

    property int horizontalMargin: 32

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            color: theme.background

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
                output: screen.name
                activeTextColor: theme.foreground
                inactiveTextColor: theme.background
                activeChipColor: theme.foreground
                inactiveChipColor: theme.bg2
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
                color: theme.foreground
            }
            // ------------------

            // right
            BluetoothWidget {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: theme.foreground
            }

            BatteryIndicator {
                lowBatteryColor: theme.warning
                backgroundColor: theme.bg2
                color: theme.foreground
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
            // ------------------
        }
    }
}
