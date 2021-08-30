//
//  ReusableFormatters.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//

import Foundation

// swiftlint:disable convenience_type
public struct SUDateFormatter {
    public static let shared = DateFormatter()
}

public struct SUNumberFormatter {
    public static let shared = NumberFormatter()
}

public struct SUByteCountFormatter {
    public static let shared = ByteCountFormatter()
}

public struct SUDateComponentsFormatter {
    public static let shared = DateComponentsFormatter()
}

public struct SUDateIntervalFormatter {
    public static let shared = DateIntervalFormatter()
}

public struct SUEnergyFormatter {
    public static let shared = EnergyFormatter()
}

public struct SUMassFormatter {
    public static let shared = MassFormatter()
}

public struct SULengthFormatter {
    public static let shared = LengthFormatter()
}
