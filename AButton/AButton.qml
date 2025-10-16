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
        color: Config.getBackgroundColor(btnType, ghost, isHovered, isPressed, enabled)
        border.width: Config.getBorderWidth()
        border.color: Config.getBorderColor(btnType, ghost, isHovered, isPressed, enabled)

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
                // 1) 获取 2D 绘图上下文对象
                // Canvas 元素有两种上下文类型："2d" 和 "webgl"
                // 在 QML 中，"2d" 表示使用普通的 2D 绘图接口
                var ctx = getContext("2d")

                // 2) 安全检查：如果获取不到上下文，则直接退出
                // 一般只有在 Canvas 尚未初始化或被销毁时才可能为 null
                if (!ctx) return;

                // 3️) 清空画布（防止残影）
                // 参数 (0, 0, width, height) 表示清除整个画布区域
                // 这一步相当于重置绘图区域，避免上一次绘制的虚线或阴影残留
                ctx.clearRect(0, 0, width, height)

                // 4️) 如果当前 Canvas 不可见，直接返回
                // 避免执行不必要的绘图逻辑，提高性能
                if (!visible) return;

                // 5) 设置线条宽度（单位：像素）
                // 通常定义在配置文件 Config 中，方便统一管理边框粗细
                ctx.lineWidth = Config.getBorderWidth()

                // 6) 设置虚线模式
                // setLineDash([dashLength, gapLength])
                // 这里 [3, 2] 表示画 3 像素长的线段，再空 2 像素，再画 3 像素……如此循环
                // 你也可以用 Config.getDashPattern() 来动态配置虚线样式
                ctx.setLineDash([3, 2])

                // 7) 设置描边颜色（边框颜色）
                // strokeStyle 支持颜色字符串（如 "#d9d9d9" 或 "rgba(0,0,0,0.5)"）
                // 通过 Config.getDashedBorderColor(...) 可根据按钮类型、hover、press 状态动态决定颜色
                ctx.strokeStyle = Config.getDashedBorderColor(btnType, ghost, isHovered, isPressed)

                // 8) 计算绘制矩形的实际位置和尺寸
                // 为了避免边框被 Canvas 边缘裁切，我们需要内缩半个线宽
                var r = Math.min(parent.radius, Math.min(width, height) / 2) // 圆角半径（取较小值避免溢出）
                var half = ctx.lineWidth / 2                                // 半线宽偏移量
                var x = half, y = half                                       // 左上角起点坐标（内缩 half）
                var w = Math.max(0, width - ctx.lineWidth)                   // 实际可绘制宽度
                var h = Math.max(0, height - ctx.lineWidth)                  // 实际可绘制高度
                var rx = Math.min(r, w / 2), ry = Math.min(r, h / 2)         // 圆角横向/纵向半径

                // 9) 开始定义路径
                // 这里手动绘制一个带圆角的矩形路径，确保虚线能顺着边界均匀分布
                ctx.beginPath()

                // 从上边中间点开始，顺时针画矩形
                ctx.moveTo(x + rx, y)                       // 起点：上边左圆角内侧
                ctx.lineTo(x + w - rx, y)                   // 上边直线段
                ctx.arcTo(x + w, y, x + w, y + ry, rx)      // 右上圆角

                ctx.lineTo(x + w, y + h - ry)               // 右边直线段
                ctx.arcTo(x + w, y + h, x + w - rx, y + h, rx) // 右下圆角

                ctx.lineTo(x + rx, y + h)                   // 下边直线段
                ctx.arcTo(x, y + h, x, y + h - ry, rx)      // 左下圆角

                ctx.lineTo(x, y + ry)                       // 左边直线段
                ctx.arcTo(x, y, x + rx, y, rx)              // 左上圆角

                ctx.closePath()                             // 闭合路径形成完整矩形

                // 10) 绘制路径
                // stroke() 用当前 strokeStyle 描边路径
                ctx.stroke()
            }

        }
    }

    contentItem: Text {
        id: txt
        text: btn.text
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font: btn.font
        
        color: Config.getTextColor(btnType, ghost, isHovered, isPressed, enabled)
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            isHovered = true
            dashedCanvas.requestPaint()
        }

        onExited: {
            isHovered = false
            dashedCanvas.requestPaint()
        }

        onPressed: {
            isPressed = true
            dashedCanvas.requestPaint()
        }

        onReleased: {
            isPressed = false
            dashedCanvas.requestPaint()
        }
    }
}
