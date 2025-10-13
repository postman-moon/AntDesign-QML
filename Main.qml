import QtQuick
import QtQuick.Window

import "AButton"
import "AButton/AButton.js" as AButtonConfig

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    AButton {
        btnSize: AButtonConfig.BtnSize.Large
    }
}
