//
//  Then.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//

import Foundation


///通过闭包设置属性对象的属性

public protocol Then {}

extension Then {

    /// Makes it available to set properties with closures.
    ///
    ///     let label = UILabel().then {
    ///         $0.textAlignment = .Center
    ///         $0.textColor = UIColor.blackColor()
    ///         $0.text = "Hello, World!"
    ///     }
    public func then(block: (inout (Self)) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }

}

extension NSObject: Then {}
