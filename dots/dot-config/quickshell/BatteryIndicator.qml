import QtQuick
import Quickshell.Services.UPower

Item {
    id: root

    property string chargingIndicator: "+"
    property string color
    property string backgroundColor: "transparent"
    property string lowBatteryColor: "red"
    property int lowBatteryThreshold: 20

    readonly property var battery: UPower.displayDevice
    readonly property int percentage: Math.round(battery.percentage * 100)
    readonly property bool charging: battery.state === UPowerDeviceState.Charging

    implicitWidth: batteryText.implicitWidth
    implicitHeight: batteryText.implicitHeight

    visible: battery.ready && battery.isLaptopBattery

    Rectangle {
        height: 24
        anchors.verticalCenter: parent.verticalCenter
        color: root.backgroundColor
        Text {
            id: batteryText
            anchors.centerIn: parent
            text: (root.charging ? (root.chargingIndicator + " ") : "") + root.percentage + "%"
            color: root.percentage <= root.lowBatteryThreshold ? root.lowBatteryColor : root.color
        }
    }
}
