//
//  AnyOptional.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//


import Foundation

///判断是否为空的协议,用于所有遵循Optional的对象

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

