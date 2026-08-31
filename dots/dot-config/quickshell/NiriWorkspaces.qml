pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: root

    required property string output

    property string activeChipColor: "#555555"
    property string inactiveChipColor: "#ffffff"
    property string activeTextColor: "#ffffff"
    property string inactiveTextColor: "#555555"
    property bool   hideScratchBuffer: true
    property bool   useIndexAsName: true

    property var workspaces: []

    implicitWidth: workspacesRow.implicitWidth
    implicitHeight: workspacesRow.implicitHeight

    Row {
        id: workspacesRow

        anchors.fill: parent
        spacing: 6

        Repeater {
            model: root.workspaces
            delegate: Rectangle {
                required property var modelData

                visible: !root.hideScratchBuffer || modelData.name !== "scratch"
                color: modelData.is_active ? root.activeChipColor : root.inactiveChipColor

                width: label.implicitWidth + 16
                height: 24
                radius: 4

                Text {
                    id: label
                    anchors.centerIn: parent
                    text: root.useIndexAsName ? parent.modelData.idx : (parent.modelData.name || parent.modelData.idx)
                    color: parent.modelData.is_active ? root.inactiveTextColor : root.activeTextColor
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Quickshell.execDetached(["niri", "msg", "action", "focus-workspace", parent.modelData.idx]);
                }
            }
        }
    }

    Process {
        command: ["niri", "msg", "--json", "event-stream"]
        running: true
        stdout: SplitParser {
            onRead: (line) => {
                try {
                    const event = JSON.parse(line)
                    if (event.WorkspacesChanged) {
                        root.workspaces =
                            event.WorkspacesChanged.workspaces
                                .slice()
                                .filter((ws) => ws.output === root.output)
                                .sort((a, b) => a.idx - b.idx)
                    }
                    else if (event.WorkspaceActivated) {
                        const id = event.WorkspaceActivated.id
                        const focused = event.WorkspaceActivated.focused
                        root.workspaces = root.workspaces.map((workspace) => {
                            return Object.assign({}, workspace, { is_active: workspace.id === id })
                        })
                    }
                } catch (error) {
                    console.log("Invalid Niri event:", line)
                }
            }
        }
    }
}
