// .pragma library

// 按钮类型枚举
const BtnType = {
    Primary: 0,         // 主按钮、
    Ghost: 1,           // 幽灵按钮
    Dashed: 2,          // 虚线按钮
    Link: 3,            // 链接按钮
    Text: 4,            // 文本按钮
    Default: 5          // 次按钮
}

// 按钮大小枚举
const BtnSize = {
    Large: 0,           // 大
    Middle: 1,          // 中
    Small: 2            // 小
}

// 尺寸映射
const sizeMap = {
    [BtnSize.Large]: { width: 120, height: 40 },
    [BtnSize.Middle]: { width: 90, height: 32 },
    [BtnSize.Small]: { width: 60, height: 24 }
}

// 颜色常量
const Colors = {
    primary: "#1677FF",
    primaryHover: "#4096ff",
    primaryPressed: "#0958d9",
    border: "#d9d9d9",
    text: "rgba(0, 0, 0, 0.88)",
    disabled: "rgba(0, 0, 0, 0.25)",
    white: "#FFF",
    transparent: "transparent"
}

// 工具函数 - 获取背景颜色
function getBackgroundColor(btnType, ghost, enabled = true) {

    switch (btnType) {
        case BtnType.Primary:
            return Colors.primary;

        case BtnType.Ghost:
        case BtnType.Dashed:
        case BtnType.Link:
        case BtnType.Text:
            return Colors.transparent;

        case BtnType.Default:
            return Colors.white;
    }

}

// 工具函数 - 获取边框宽度
function getBorderWidth() {

    if (btnType === BtnType.Primary ||
        btnType === BtnType.Default) {
        return 1
    }

    return 0

}

// 工具函数 - 获取边框颜色
function getBorderColor(btnType, ghost, isHovered = false, isPressed = false) {

    if (btnType === BtnType.Primary) {
        return isPressed ? Colors.primaryPressed :
            isHovered ? Colors.primaryHover : Colors.primary
    } else if (btnType === BtnType.Default || btnType === BtnType.Dashed) {
        return isPressed ? Colors.primaryPressed :
            isHovered ? Colors.primary : Colors.border
    }

    return Colors.transparent;


}

// 工具函数 - 获取虚线边框颜色
function getDashedBorderColor(btnType, ghost, isHovered = false, isPressed = false) {

    if (ghost) {
        return isHovered ? Colors.primary : Colors.white
    }
    return isHovered ? Colors.primary : Colors.border

}

// 导出所有内容
Qt.include("ButtonConfig.js")
