//
//  BundleExtensionTests.swift
//  BaseFrameWorkTests
//
//  Created by ZhangYu on 2021/8/30.
//

import XCTest

class BundleExtensionTests: XCTestCase {

}

// MARK: - App Information

extension BundleExtensionTests {

    func testAppName() {
        debugPrint("❤️ Bundle.main.appName is \(Bundle.main.appName)")
//        XCTAssertEqual(Bundle.main.appName, "xctest")
    }

    func testDisplayName() {
        debugPrint("❤️ Bundle.main.displayName is \(Bundle.main.displayName)")
//        XCTAssertEqual(Bundle.main.displayName, "")
    }

    func testAppVersion() {
        debugPrint("❤️ Bundle.main.appVersion is \(Bundle.main.appVersion)")
//        XCTAssertEqual(Bundle.main.appVersion, "")
    }

    func testBundleId() {
        debugPrint("❤️ Bundle.main.bundleId is \(Bundle.main.bundleId)")
//        XCTAssertEqual(Bundle.main.bundleId, "com.apple.dt.xctest.tool")
    }

}

// MARK: - Status

extension BundleExtensionTests {

    func testIsInTestFlight() {
        debugPrint("❤️ Bundle.main.isInTestFlight is \(Bundle.main.isInTestFlight)")
//        XCTAssertFalse(Bundle.main.isInTestFlight)
    }

}

// MARK: - Schemes

extension BundleExtensionTests {

    func testSchemes() {
        debugPrint("❤️ Bundle.main.schemes is \(Bundle.main.schemes)")
//        XCTAssertEqual(Bundle.main.schemes, [])
    }

    func testMainSchemes() {
        debugPrint("❤️ Bundle.main.mainScheme is \(String(describing: Bundle.main.mainScheme))")
//        XCTAssertNil(Bundle.main.mainScheme)
    }

}
