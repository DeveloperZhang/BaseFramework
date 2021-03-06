//
//  DateExtension.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//

import Foundation

// MARK: - Initializers

extension Date {

    /// Initialize a Date from a String and a specified format.
    /// 通过字符串和格式类型初始化时间对象
    /// - Parameters:
    ///   - string: The string to map.
    ///   - format: The format which will be used to create the `Date`.
    /// - Returns: If sucessfull, the `Date` created from the `string` and format,
    ///            otherwise `nil` meaning that's the `string` didn't match the `format`.
    public init?(fromString string: String, format: String) {
        let formatter = SUDateFormatter.shared
        formatter.dateFormat = format
        guard let date = formatter.date(from: string) else {
            return nil
        }
        self.init(timeInterval: 0, since: date)
    }

}

// MARK: - Format

extension Date {

    /// Create a String from a Date.
    /// 格式化日期+时间
    /// - Parameters:
    ///   - dateStyle: the date style that will be applied when creating the string. Default is `medium`.
    ///   - timeStyle: the time style that will be applied when creating the string. Default is `medium`.
    /// - Returns: the string created from the `Date` and formatted using the `dateStyle` and `timeStyle`.
    public func string(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = SUDateFormatter.shared
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self as Date)
    }

    /// Create a String from a Date.
    /// 格式化日期
    /// - Parameter format: the date format that will be applied when creating the string.
    ///                     Note that the format must be a valid date format, you can find example here:
    ///                      https://www.nsdateformatter.com.
    /// - Returns: the string created from the `Date` and formatted using the `format`.
    public func string(format: String) -> String {
        let formatter = SUDateFormatter.shared
        formatter.dateFormat = format
        return formatter.string(from: self as Date)
    }

}

// MARK: - Since

extension Date {

    /// Calculate the number of days since another `Date`.
    /// 计算两个Date相差的天数
    /// - Parameter date: the date that will be used for to calculate the number of days.
    /// - Returns: the number of days since the dedicated dates.
    public func days(since date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 86_400)
        return diff
    }

    /// Calculate the number of hours since another `Date`.
    /// 计算两个Date相差的小时
    /// - Parameter date: the date that will be used for to calculate the number of hours.
    /// - Returns: the number of hours since the dedicated dates.
    public func hours(since date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 3600)
        return diff
    }

    /// Calculate the number of minutes since another `Date`.
    /// 计算两个Date相差的分钟
    /// - Parameter date: the date that will be used for to calculate the number of minutes.
    /// - Returns: the number of minutes since the dedicated dates.
    public func minutes(since date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 60)
        return diff
    }

    /// Calculate the number of seconds since another `Date`.
    /// 计算两个Date相差的秒数
    /// - Parameter date: the date that will be used for to calculate the number of seconds.
    /// - Returns: the number of seconds since the dedicated dates.
    public func seconds(since date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }

}

// MARK: - IsIn

extension Date {

    /// Check if a `Date` is in the future.
    /// 当前时间之后
    /// - Returns: Bool.
    public var isInFuture: Bool {
        self > Date()
    }

    /// Check if a `Date` is in the past.
    /// 当前时间之前
    /// - Returns: Bool.
    public var isInPast: Bool {
        self < Date()
    }

}
