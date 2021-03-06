//
//  BaseFrameWorkTests.swift
//  BaseFrameWorkTests
//
//  Created by ZhangYu on 2021/8/23.
//

import XCTest
@testable import BaseFrameWork

class BaseFrameWorkTests: XCTestCase {
    var viewModel:HomeViewModel = HomeViewModel()


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testNet() {
        let networkExpection = expectation(description: "networkDownSuccess")
        viewModel.requestHomeList(params:[:]) { result in
            debugPrint(result)
            networkExpection.fulfill()
        } failedCallBack: { error in
//            debugPrint(error)
        }
        let result = XCTWaiter(delegate: self).wait(for: [networkExpection], timeout:  10)
            if result == .timedOut {
                print("超时")
        }
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
