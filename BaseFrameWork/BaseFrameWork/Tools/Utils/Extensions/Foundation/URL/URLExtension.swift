//
//  URLExtension.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//

import Foundation

// MARK: - Query

extension URL {

    // swiftlint:disable discouraged_optional_collection
    /// Extract the query items from an URL.
    /// 获取url ? 后面的参数字典
    /// - Returns: A dictionary containing all the query items found. If no items found then it will return nil.
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self as URL, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
                return nil
        }

        var parameters = [String: String]()
        queryItems.forEach {
            parameters[$0.name] = $0.value
        }
        return parameters
    }

}

// MARK: - Attributes

extension URL {

    /// Add the `URLResourceKey.isExcludedFromBackupKey` attribute to the URL.
    ///
    /// This key is used to determine whether the resource is excluded from all backups of app data.
    public func addSkipBackupAttribute() throws {
        try (self as NSURL).setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
    }

}
