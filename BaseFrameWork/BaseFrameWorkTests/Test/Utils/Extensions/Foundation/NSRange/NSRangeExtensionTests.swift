//
//  NSRangeExtensionTests.swift
//  BaseFrameWorkTests
//
//  Created by ZhangYu on 2021/8/30.
//

import XCTest

class NSRangeExtensionTests: XCTestCase {

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

// MARK: - Range

extension NSRangeExtensionTests {

    func testRangeAfterOccurence() {
        let string = "Hello world"
        let range = NSRange(text: string, afterOccurence: "llo")
        XCTAssertEqual(range.location, 5)
        XCTAssertEqual(range.length, 6)
    }

    func testRangeOfOccurence() {
        let string = "Hello world"
        let stringToFind = "ello wo"
        let range = NSRange(textToFind: stringToFind, in: string)
        XCTAssertEqual(range.location, 1)
        XCTAssertEqual(range.length, stringToFind.count)
    }

}
