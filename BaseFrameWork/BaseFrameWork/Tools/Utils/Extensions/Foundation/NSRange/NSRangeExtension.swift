//
//  NSRangeExtension.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//

import Foundation

extension NSRange {

    /// Finds and returns the range of the first occurrence of a given string within the string.
    /// - Parameters:
    ///    - text: The text where the `textToFind` will be searched. 要搜索的字符串穿
    ///    - occurence: The text will be searched after this specified text. 从此字符串开始进行搜索
    /// - Returns: The range corresponding to `textToFind` in `text`.
    ///            If the text has not been found then it will returns `NSNotFound`.
    public init(text: String, afterOccurence occurence: String) {
        self = (text as NSString).range(of: occurence, options: [])
        if location != NSNotFound {
            location = location + occurence.count
            length = text.count - location
        }
    }

    /// Finds and returns the range of the first occurrence of a given string within the string.
    /// - Parameters:
    ///    - textToFind: The text to search for.
    ///    - text: The text where the `textToFind` will be searched.
    /// - Returns: The range corresponding to `textToFind` in `text`.
    ///            If the text has not been found then it will returns `NSNotFound`.
    public init(textToFind: String, in text: String) {
        self = (text as NSString).range(of: textToFind, options: [])
    }

}
