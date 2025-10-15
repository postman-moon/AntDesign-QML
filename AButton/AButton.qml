import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "AButton.js" as Config

Button {
    id: btn

    property int btnType: Config.BtnType.Default        // 设置按钮类型
    property int btnSize: Config.BtnSize.Middle         // 设置按钮大小
    property bool ghost: false                          // 幽灵属性，使按钮背景透明

    // 内部状态管理
    property bool isHovered: false
    property bool isPressed: false

    leftPadding: 15
    rightPadding: 15
    topPadding: 4
    bottomPadding: 4

    background: Rectangle {
        id: bg
        implicitWidth: Config.sizeMap[btnSize].width
        implicitHeight: Config.sizeMap[btnSize].height
        radius: 6

        // 基础样式
        color: Config.getBackgroundColor(btnType, ghost)
        border.width: Config.getBorderWidth()
        border.color: Config.getBorderColor(btnType, ghost)

        // 虚线边框（仅 Dashed 类型）
        Canvas {
            id: dashedCanvas
            anchors.fill: parent
            visible: btn.btnType === Config.BtnType.Dashed
            onPaint: drawDashedBorder()

            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
            onVisibleChanged: requestPaint()
            Component.onCompleted: requestPaint()

            function drawDashedBorder() {   
                // 1. 获取 2D 上下文
                var ctx = getContext("2d")
                // 如果没有获取到上下文，直接返回
                if (!ctx) return;

                // 2. 清空画布（用逻辑像素宽高）
                ctx.clearRect(0, 0, width, height)

                // 3. 如果 Canvas 不可见就跳过绘制，节省性能
                if (!visible) return;

                // 4. 基本绘制参数
                ctx.lineWidth = Config.getBorderWidth()

                // 虚线模式：dash 长度和间隔可以放到 Config 中统一管理
                ctx.setLineDash([3, 2])

                // 线条颜色
                ctx.strokeStyle = Config.getDashedBorderColor(btnType, ghost, isHovered, isPressed)

                // 5. 计算绘制矩形的位置 & 大小（把线宽考虑进去，避免被裁切）
                var r = Math.min(parent.radius, Math.min(width, height) / 2)
                var half = ctx.lineWidth / 2
                var x = half, y = half
                var w = Math.max(0, width - ctx.lineWidth)
                var h = Math.max(0, height - ctx.lineWidth)
                var rx = Math.min(r, w / 2), ry = Math.min(r, h / 2)

                // 6. 绘制圆角矩形路径
                ctx.beginPath()
                ctx.moveTo(x + rx, y)
                ctx.lineTo(x + w - rx, y)
                ctx.arcTo(x + w, y, x + w, y + ry, rx)
                ctx.lineTo(x + w, y + h - ry)
                ctx.arcTo(x + w, y + h, x + w - rx, y + h, rx)
                ctx.lineTo(x + rx, y + h)
                ctx.arcTo(x, y + h, x, y + h - ry, rx)
                ctx.lineTo(x, y + ry)
                ctx.arcTo(x, y, x + rx, y, rx)
                ctx.closePath()
                ctx.stroke()
            }
        }
    }


}
