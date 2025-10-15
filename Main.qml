import QtQuick
import QtQuick.Window
import QtQuick.Controls

import "AButton"
import "AButton/AButton.js" as AButtonConfig

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent
        // color: "#bec8c8"
    }


    Column {
        padding: 10
        spacing: 10

        Row {
            spacing: 10

            AButton {
                text: "Primary Button"

                btnType: AButtonConfig.BtnType.Primary
            }

            AButton {
                text: "Default Button"

                btnType: AButtonConfig.BtnType.Default
            }

            AButton {
                text: "Dashed Button"

                btnType: AButtonConfig.BtnType.Dashed
            }

            AButton {
                text: "Text Button"

                btnType: AButtonConfig.BtnType.Text
            }

            AButton {
                text: "Link Button"

                btnType: AButtonConfig.BtnType.Link
            }
        }
    }




}
