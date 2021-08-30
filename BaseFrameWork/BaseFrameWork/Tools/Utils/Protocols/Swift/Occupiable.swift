//
//  Occupiable.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//

import Foundation

///用于判断对象是否为空
public protocol Occupiable {
    var isEmpty: Bool { get }
    var isNotEmpty: Bool { get }
}

extension Occupiable {
    public var isNotEmpty: Bool {
        !isEmpty
    }
}

extension String: Occupiable { }
extension Array: Occupiable { }
extension Dictionary: Occupiable { }
extension Set: Occupiable { }

extension Optional where Wrapped: Occupiable {
    public var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value.isEmpty
        }
    }

    public var isNotNilNotEmpty: Bool {
        !isNilOrEmpty
    }
}
