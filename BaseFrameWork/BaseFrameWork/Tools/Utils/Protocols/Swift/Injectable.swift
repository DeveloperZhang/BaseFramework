//
//  Injectable.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//

import Foundation

///用于注入属性
public protocol Injectable {
    associatedtype T
    func inject(properties: T)
    func assertDependencies()
}

