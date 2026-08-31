import QtQuick

Text {
    property string dateFormat: "ddd MMM d hh:mm:ss AP t yyyy"
    text: Qt.formatDateTime(Time.time, dateFormat)
}
