//
//  URLExtensionTests.swift
//  BaseFrameWorkTests
//
//  Created by ZhangYu on 2021/8/30.
//

import XCTest

class URLExtensionTests: XCTestCase {

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

extension URLExtensionTests {

    func testQueryParameters() {
        let url = URL(string: "http://example.com/api?v=1.1&q=google")!
        let queryParameters = url.queryParameters
        XCTAssertEqual(queryParameters?["v"], Optional("1.1"))
        XCTAssertEqual(queryParameters?["q"], Optional("google"))
        XCTAssertNil(queryParameters?["other"])
    }

    func testQueryParameters_withoutParameters() {
        let url = URL(string: "http://example.com/api")!
        XCTAssertNil(url.queryParameters)
    }

}
