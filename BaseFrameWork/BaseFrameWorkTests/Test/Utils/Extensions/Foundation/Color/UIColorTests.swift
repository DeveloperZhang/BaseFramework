//
//  UIColorTests.swift
//  BaseFrameWorkTests
//
//  Created by ZhangYu on 2021/8/30.
//

import XCTest

class UIColorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

// MARK: - Components

extension UIColorTests {

    func testValidHexColor() {
        let color = UIColor(hex: "FFFFFFFEFEFEZAZF")
        XCTAssertNotNil(color)
    }

    func testInvalidHexColor() {
        let color = UIColor(hex: "FFFFFF")
        XCTAssertNotNil(color)
    }

    func testInitFromHex_length_3() {
        let color = UIColor(hex: "#555")
        XCTAssertNotNil(color)
    }

    func testInitFromHex_length_6() {
        let color = UIColor(hex: "#555557")
        XCTAssertNotNil(color)
    }

    func testInitFromHex_length_8() {
        let color = UIColor(hex: "#55555555")
        XCTAssertNotNil(color)
    }

    func testInitFromHex_invalidLength() {
        let color = UIColor(hex: "🤭")
        XCTAssertNotNil(color)
    }

}

// MARK: - Components

extension UIColorTests {

    func testRedComponent() {
        let color = UIColor.red
        XCTAssertEqual(color.redComponent, 255)
    }

    func testGreenComponent() {
        let color = UIColor.green
        XCTAssertEqual(color.greenComponent, 255)
    }

    func testBlueComponent() {
        let color = UIColor.blue
        XCTAssertEqual(color.blueComponent, 255)
    }

    func testAlpha() {
        let expectedAlpha: CGFloat = 0.5
        let color = UIColor.black.withAlphaComponent(expectedAlpha)
        XCTAssertEqual(color.alpha, expectedAlpha)
    }

}

// MARK: - Brigthness

extension UIColorTests {

    func testLighterWhiteIsWhite() {
        let white = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let lighterWhite = white.lighter()

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        lighterWhite.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #if os(OSX)
            XCTAssertEqual(red, 1.25, accuracy: 0.0001)
            XCTAssertEqual(green, 1.25, accuracy: 0.0001)
            XCTAssertEqual(blue, 1.25, accuracy: 0.0001)
        #elseif os(iOS)
            if #available(iOS 10.0, *) {
                XCTAssertEqual(red, 1.25, accuracy: 0.0001)
                XCTAssertEqual(green, 1.25, accuracy: 0.0001)
                XCTAssertEqual(blue, 1.25, accuracy: 0.0001)
            } else {
                XCTAssertEqual(red, 1.0, accuracy: 0.0001)
                XCTAssertEqual(green, 1.0, accuracy: 0.0001)
                XCTAssertEqual(blue, 1.0, accuracy: 0.0001)
            }
        #endif
        XCTAssertEqual(alpha, 1.0, accuracy: 0.0001)
    }

    func testDarkerBlackIsBlack() {
        let black = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let darkerBlack = black.darker()

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        darkerBlack.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.0, accuracy: 0.0001)
        XCTAssertEqual(green, 0.0, accuracy: 0.0001)
        XCTAssertEqual(blue, 0.0, accuracy: 0.0001)
        XCTAssertEqual(alpha, 1.0, accuracy: 0.0001)
    }

    func testLighterColor() {
        let color = UIColor(red: 0.5, green: 0.8, blue: 0.8, alpha: 1.0)
        let lighterColor = color.lighter()

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        lighterColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.625, accuracy: 0.0001)
        XCTAssertEqual(green, 1.0, accuracy: 0.0001)
        XCTAssertEqual(blue, 1.0, accuracy: 0.0001)
        XCTAssertEqual(alpha, 1.0, accuracy: 0.0001)
    }

    func testDarkerColor() {
        let color = UIColor(red: 0.5, green: 0.8, blue: 0.8, alpha: 1.0)
        let darkerColor = color.darker()

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        darkerColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.375, accuracy: 0.0001)
        XCTAssertEqual(green, 0.6, accuracy: 0.0001)
        XCTAssertEqual(blue, 0.6, accuracy: 0.0001)
        XCTAssertEqual(alpha, 1.0)
    }

}
