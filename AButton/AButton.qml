import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "AButton.js" as Config

Button {
    id: btn

    property int btnType: Config.BtnType.Default        // 设置按钮类型
    property int btnSize: Config.BtnSize.Middle         // 设置按钮大小

    background: Rectangle {
        id: bg
        implicitWidth: Config.sizeMap[btnSize].width
        implicitHeight: Config.sizeMap[btnSize].height
        radius: 6

        color: "skyblue"
    }

}
