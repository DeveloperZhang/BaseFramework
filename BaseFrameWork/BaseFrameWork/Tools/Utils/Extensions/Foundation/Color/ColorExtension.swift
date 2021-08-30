//
//  ColorExtension.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//


import UIKit



///颜色扩展类
// MARK: Init
extension UIColor {

    /// Initialize a Color from an hex String.
    /// 通过16进制字符串初始化颜色
    /// - Parameter hex: the hex used to create the color.
    @objc
    public convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3:
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xFF0000) * 17, (int & 0xFF0000) * 17)
        case 6:
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF0000, int & 0xFF0000)
        case 8:
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF0000, int >> 8 & 0xFF0000, int & 0xFF0000)
        default:
            (alpha, red, green, blue) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: CGFloat(alpha) / 255)
    }

}

// MARK: - Components
extension UIColor {

    /// Extract the red component from the `Color`.
    /// 获取红色数值
    /// - Returns: Int.
    public var redComponent: Int {
        var red: CGFloat = 0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return Int(red * 255)
    }

    /// Extract the green component from the `Color`.
    /// 获取绿色数值
    /// - Returns: Int.
    public var greenComponent: Int {
        var green: CGFloat = 0
        getRed(nil, green: &green, blue: nil, alpha: nil)
        return Int(green * 255)
    }

    /// Extract the blue component from the `Color`.
    /// - Returns: Int.
    public var blueComponent: Int {
        var blue: CGFloat = 0
        getRed(nil, green: nil, blue: &blue, alpha: nil)
        return Int(blue * 255)
    }

    /// Extract the alpha component from the `Color`.
    /// 获取透明度
    /// - Returns: Int.
    public var alpha: CGFloat {
        var alpha: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)
        return alpha
    }

}

// MARK: - Brightness
///颜色深浅
extension UIColor {

    /// Make the Color lighter.
    /// - Parameter amount: the amount of brightness to apply/
    /// - Returns: The `Color` with the amount lighter applied.
    public func lighter(amount: CGFloat = 0.25) -> UIColor {
        hueColor(withBrightnessAmount: 1 + amount)
    }

    /// Make the Color darker.
    /// - Parameter amount: the amount of dark to apply.
    /// - Returns: The `Color` with the amount darker applied.
    public func darker(amount: CGFloat = 0.25) -> UIColor {
        hueColor(withBrightnessAmount: 1 - amount)
    }

    private func hueColor(withBrightnessAmount amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue,
                           saturation: saturation,
                           brightness: brightness * amount,
                           alpha: alpha)
    }

}

