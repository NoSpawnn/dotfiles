pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Bluetooth
import QtQuick

Item {
    id: root

    property color chipColor
    property color textColor
    property color bgColor

    implicitWidth: widget.implicitWidth
    implicitHeight: widget.implicitHeight

    Rectangle {
        id: widget

        implicitHeight: 24
        implicitWidth: chipLabel.implicitWidth + 24
        radius: 4

        color: root.chipColor

        Text {
            id: chipLabel
            color: root.textColor
            anchors.centerIn: parent
            text: {
                const connectedDevices = Bluetooth.devices.values.filter(device => device.connected).length;
                return connectedDevices > 0 ? `Bluetooth (${connectedDevices})` : "Bluetooth";
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: popup.visible = !popup.visible
        }
    }

    PopupWindow {
        id: popup

        anchor.item: widget
        anchor.rect.x: (this.anchor.item.width - this.width) / 2
        anchor.rect.y: this.anchor.item.height

        visible: false
        color: "transparent"

        implicitWidth: 500

        Rectangle {
            color: root.chipColor
            anchors.fill: parent
            anchors.margins: 8
            radius: 10

            Column {
                id: deviceListColumn

                spacing: 6
                width: 240
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: 8
                }

                Repeater {
                    id: deviceList
                    model: Bluetooth.devices
                    delegate: Row {
                        id: row

                        required property var modelData

                        width: deviceListColumn.width
                        spacing: 6

                        Rectangle {
                            id: nameContainer
                            color: root.bgColor

                            radius: 5
                            height: textItem.implicitHeight + 12
                            width: (parent.width - parent.spacing) * 2 / 3

                            Row {
                                id: textItem
                                anchors.centerIn: parent
                                spacing: 6

                                Text {
                                    text: row.modelData.name
                                    color: root.textColor
                                }

                                Text {
                                    visible: row.modelData.batteryAvailable
                                    text: "(" + (row.modelData.battery * 100) + "%)"
                                    color: root.textColor
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: _ => {
                                    const d = row.modelData;
                                    if (d.paired) {
                                        d.connected ? d.disconnect() : d.connect();
                                    } else {
                                        d.pair();
                                    }
                                }
                            }
                        }

                        // connection status
                        Rectangle {
                            height: nameContainer.height
                            width: parent.width - nameContainer.width - parent.spacing
                            radius: 5
                            color: nameContainer.color
                            Text {
                                color: root.textColor
                                anchors.centerIn: parent
                                text: BluetoothDeviceState.toString(row.modelData.state)
                            }
                        }
                    }
                }
            }
        }
    }
}
