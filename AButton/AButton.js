.pragma library

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

function func() {

}
