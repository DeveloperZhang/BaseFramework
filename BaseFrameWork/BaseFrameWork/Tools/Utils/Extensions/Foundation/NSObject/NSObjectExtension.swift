//
//  NSObjectExtension.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//

import Foundation

extension NSObject {

    /// The name of a the type inheriting of `NSObject`
    /// - Returns: String
    public var className: String {
        Self.className
    }
    
    /// The name of a the type inheriting of `NSObject`
    /// - Returns: String
    public static var className: String {
        String(describing: self)
    }

}
